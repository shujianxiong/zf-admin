package com.chinazhoufan.admin.common.mpsdk4j.api;

import com.chinazhoufan.admin.common.mpsdk4j.core.JsonMsgBuilder;
import com.chinazhoufan.admin.common.mpsdk4j.exception.WechatApiException;
import com.chinazhoufan.admin.common.mpsdk4j.session.AccessTokenMemoryCache;
import com.chinazhoufan.admin.common.mpsdk4j.session.JSTicketMemoryCache;
import com.chinazhoufan.admin.common.mpsdk4j.session.MemoryCache;
import com.chinazhoufan.admin.common.mpsdk4j.util.HttpTool;
import com.chinazhoufan.admin.common.mpsdk4j.vo.ApiResult;
import com.chinazhoufan.admin.common.mpsdk4j.vo.MPAccount;
import com.chinazhoufan.admin.common.mpsdk4j.vo.api.*;
import com.chinazhoufan.admin.common.redis.RedisCacheService;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.utils.SystemPath;
import com.chinazhoufan.mobile.wechat.web.WeiXinConfig;
import net.sf.json.JSONObject;
import org.apache.http.client.ClientProtocolException;
import org.nutz.castor.Castors;
import org.nutz.json.Json;
import org.nutz.json.JsonFormat;
import org.nutz.lang.Lang;
import org.nutz.lang.Strings;
import org.nutz.lang.util.NutMap;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;

/**
 * 微信公众平台所有接口实现
 * 
 * @author 凡梦星尘(elkan1788@gmail.com)
 * @since 2.0
 */
@Component
public class WechatAPIImpl implements WechatAPI {

    private static final Log log = Logs.get();
    /*@Autowired
    private RedisCacheService<String,String> redisCacheService;*/

    /**
     * HTTP请求 重试次数
     */
    static int RETRY_COUNT = 3;

    protected static MemoryCache<AccessToken> _atmc;

    protected static MemoryCache<JSTicket> _jstmc;

    public static final String TEMP_FILE_PATH="uploadTemp";//上传文件临时目录

    private MPAccount mpAct;
    
    public WechatAPIImpl(MPAccount mpAct) {
        this.mpAct = mpAct;
        synchronized (this) {
            if (_atmc == null) {
                _atmc = new AccessTokenMemoryCache();
            }
            if (_jstmc == null) {
                _jstmc = new JSTicketMemoryCache();
            }
        }
    }

    public static MemoryCache<AccessToken> getAccessTokenCache() {
        return _atmc;
    }

    public static MemoryCache<JSTicket> getJsTicketCache() {
        return _jstmc;
    }

    /**
     * WechatAPI 实现方法
     * 
     *            微信公众号信息{@link MPAccount}
     * @return 对应的API
     */
    public static WechatAPIImpl create(String account) {
        return new WechatAPIImpl(WeiXinConfig.getAccountConfig(account));
    }
    
    public static WechatAPIImpl create(MPAccount maAccount) {
        return new WechatAPIImpl(maAccount);
    }

    private String mergeCgiBinUrl(String url, Object... values) {
        if (!Lang.isEmpty(values)) {
            return cgi_bin + String.format(url, values);
        }
        return cgi_bin + url;
    }

    /**
     * 强制刷新微信服务凭证
     */
    private synchronized void refreshAccessToken() {
        String url = mergeCgiBinUrl(get_at, mpAct.getAppId(), mpAct.getAppSecret());
        AccessToken at = null;
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.get(url));
            if (ar.isSuccess()) {
                at = Json.fromJson(AccessToken.class, ar.getJson());
                _atmc.set(mpAct.getMpId(), at);
                //redisCacheService.setStr("access_token", at.getAccessToken(), at.getExpiresIn());
            }

            if (at != null && at.isAvailable()) {
                return;
            }

            log.errorf("Get mp[%s]access_token failed. There try %d items.", mpAct.getMpId(), i + 1);

        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    private synchronized void refreshJSTicket() {
        String url = mergeCgiBinUrl(js_ticket + getAccessToken());
        JSTicket jst = null;
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.get(url));
            if (ar.isSuccess()) {
                jst = Json.fromJson(JSTicket.class, ar.getJson());
                _jstmc.set(mpAct.getMpId(), jst);
            }

            if (jst != null && jst.isAvailable()) {
                return;
            }

            log.errorf("Get mp[%s] JSSDK ticket failed. There try %d items.",
                       mpAct.getMpId(),
                       i + 1);

        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public String getAccessToken() {
        AccessToken at = _atmc.get(mpAct.getMpId());
        if (at == null || !at.isAvailable()) {
            refreshAccessToken();
            at = _atmc.get(mpAct.getMpId());
        }
        return at.getAccessToken();

        /*String access_token = redisCacheService.getStr("access_token");
        if (StringUtils.isBlank(access_token)){
            refreshAccessToken();
            access_token = redisCacheService.getStr("access_token");
        }
        return access_token;*/
    }

    @Override
    public List<String> getServerIps() {
        String url = mergeCgiBinUrl(cb_ips + getAccessToken());
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.get(url));
            if (ar.isSuccess()) {
                return Json.fromJsonAsList(String.class, Json.toJson(ar.get("ip_list")));
            }

            log.errorf("Get mp[%s] server ips failed. There try %d items.", mpAct.getMpId(), i + 1);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public String getShortUrl(String longUrl) {
        String url = mergeCgiBinUrl(short_url + getAccessToken());
        String data = "{\"action\":\"long2short\",\"long_url\":\"" + longUrl + "\"}";
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.post(url, data));
            if (ar.isSuccess()) {
                return String.valueOf(ar.get("short_url"));
            }

            log.errorf("Create mp[%s] short url failed. There try %d items.", mpAct.getMpId(), i);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public String getJSTicket() {
        JSTicket jst = _jstmc.get(mpAct.getMpId());
        if (jst == null || !jst.isAvailable()) {
            refreshJSTicket();
            jst = _jstmc.get(mpAct.getMpId());
        }
        return jst.getTicket();
    }

    @Override
    public List<Menu> getMenu() throws WechatApiException {
        String url = mergeCgiBinUrl(query_menu + getAccessToken());
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.get(url));
            if (ar.isSuccess()) {
                Map<String, Object> button = Json.fromJson(Map.class, Json.toJson(ar.get("menu")));
                return Json.fromJsonAsList(Menu.class, Json.toJson(button.get("button")));
            }
            //无效的token
            if (ar.getErrCode().intValue() == 40001) {
            	throw new WechatApiException("菜单获取失败：无效的access_token");
            }
            // 菜单为空
            if (ar.getErrCode().intValue() == 46003) {
            	throw new WechatApiException("菜单获取失败：还未创建菜单");
            }

            log.errorf("Get mp[%s] custom menu failed. There try %d items.",
                       mpAct.getAppId(),
                       i + 1);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public boolean createMenu(Menu... menu) throws WechatApiException {
        String url = mergeCgiBinUrl(create_menu + getAccessToken());
        Map<String, Object> body = new HashMap<String, Object>();
        body.put("button", menu);
        String data = Json.toJson(body, JsonFormat.compact());
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.post(url, data));
            if (ar.isSuccess()) {
                return true;
            }
            //无效的token
            if (ar.getErrCode().intValue() == 40001) {
            	throw new WechatApiException("菜单创建失败：无效的access_token，请稍后再尝试");
            }
            log.errorf("Create mp[%s] custom menu failed. There try %d items.",
                       mpAct.getAppId(),
                       i + 1);

        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }
    
    @Override
    public boolean createMenu(List<Menu> menus) throws WechatApiException {
        String url = mergeCgiBinUrl(create_menu + getAccessToken());
        Map<String, Object> body = new HashMap<String, Object>();
        body.put("button", menus);
        String data = Json.toJson(body, JsonFormat.compact());
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.post(url, data));
            if (ar.isSuccess()) {
                return true;
            }
          //无效的token
            if (ar.getErrCode().intValue() == 40001) {
            	throw new WechatApiException("菜单创建失败：无效的access_token，请稍后再尝试");
            }
            log.errorf("Create mp[%s] custom menu failed. There try %d items.",
                       mpAct.getAppId(),
                       i + 1);

        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public boolean delMenu() {
        String url = mergeCgiBinUrl(del_menu + getAccessToken());
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.get(url));
            if (ar.isSuccess()) {
                return true;
            }

            log.errorf("Delete mp[%s] custom menu failed. There try %d items.",
                       mpAct.getMpId(),
                       i + 1);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    /*@Override
    public Media upMedia(String type, File media) {
        String url = mergeCgiBinUrl(upload_media, getAccessToken(), type);
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.upload(url, media));
            if (ar.isSuccess()) {
                return Json.fromJson(Media.class, ar.getJson());
            }

            log.errorf("Upload mp[%s] media failed. There try %d items.", mpAct.getMpId(), i + 1);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }*/

    /**
     * 图文素材中的图片上传（返回素材id）
     * 或者图文消息中的图片上传（返回图片url）
     * @author 舒剑雄
     * @version 2017-09-20
     */
    @Override
    public Media upMedia(String type, File file) {
        String url;
        Media media = new Media();
        if(type == null){//图文消息中的图片上传
            url = mergeCgiBinUrl(up_message_img, getAccessToken(), type);
        }else{
            url = mergeCgiBinUrl(upload_media, getAccessToken(), type);
        }
        String result = null;
        try {
            URL url1 = new URL(url);
            HttpURLConnection conn = (HttpURLConnection) url1.openConnection();
            conn.setConnectTimeout(5000);
            conn.setReadTimeout(30000);
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setUseCaches(false);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Connection", "Keep-Alive");
            conn.setRequestProperty("Cache-Control", "no-cache");
            String boundary = "-----------------------------" + System.currentTimeMillis();
            conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);

            OutputStream output = conn.getOutputStream();
            output.write(("--" + boundary + "\r\n").getBytes());
            output.write(
                    String.format("Content-Disposition: form-data; name=\"media\"; filename=\"%s\"\r\n", file.getName())
                            .getBytes());
            output.write("Content-Type: image/jpeg \r\n\r\n".getBytes());
            byte[] data = new byte[1024];
            int len = 0;
            FileInputStream input = new FileInputStream(file);
            while ((len = input.read(data)) > -1) {
                output.write(data, 0, len);
            }
            output.write(("\r\n--" + boundary + "\r\n\r\n").getBytes());
            output.flush();
            output.close();
            input.close();
            InputStream resp = conn.getInputStream();
            StringBuffer sb = new StringBuffer();
            while ((len = resp.read(data)) > -1)
                sb.append(new String(data, 0, len, "utf-8"));
            resp.close();
            result = sb.toString();
            JSONObject jsStr = JSONObject.fromObject(result); //将字符串{"url"：""}
            if(jsStr.get("errMsg") != null){
                return null;
            }
            if(type == null){
                String photoUrl = jsStr.getString("url");
                if(photoUrl == null){
                    log.error("未获取到url");
                }
                media.setPhoto(photoUrl);
            }
            System.out.println(result);
        } catch (ClientProtocolException e) {
            log.error("postFile，不支持http协议", e);
        } catch (IOException e) {
            log.error("postFile数据传输失败", e);
        }

        return media;
    }
    /**
     * 文件上传，IO流读写
     * @author 舒剑雄
     * @version 2017-09-20
     */
    public Media upLoad(String type,MultipartFile file){
        Media me;
        try {
            byte[] fileBytes = file.getBytes();
            String fileName = file.getOriginalFilename();
            String suffix = fileName.substring(fileName.lastIndexOf("."), fileName.length());
            if(StringUtils.isBlank(suffix)){
                return null;
            }
            String newFileName = UUID.randomUUID().toString();
            String videoFilePath = SystemPath.getSysPath()+""+ TEMP_FILE_PATH+"//"+newFileName+suffix;//新生成的文件
            File media=new File(SystemPath.getSysPath()+""+ TEMP_FILE_PATH);
            if(!media.isDirectory())
                media.mkdirs();
            media=new File(videoFilePath);
            if(!media.exists()){
                media.createNewFile();
            }
            OutputStream out = new FileOutputStream(media);
            out.write(fileBytes);
            out.flush();
            out.close();
            me = upMedia(type,media);
        }catch (IOException e){
            log.error("数据传输失败", e);
            return null;
        }
        return me;
    }
    /**
     * 新增永久素材（图文）
     * @author 舒剑雄
     * @version 2017-09-20
     */
    public String addMedia(List<MediaTemp> mediaTemps)throws WechatApiException{
        String url = mergeCgiBinUrl(add_media , getAccessToken());
        Map<String, Object> body = new HashMap<String, Object>();
        body.put("articles", mediaTemps);
        String data = Json.toJson(body, JsonFormat.compact());
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.post(url, data));
            if (ar.isSuccess()) {
                return ar.getContent().get("media_id").toString();
            }
            //无效的token
            if (ar.getErrCode().intValue() == 40001) {
                throw new WechatApiException("新增永久素材失败：无效的access_token，请稍后再尝试");
            }
            log.errorf("Create mp[%s] custom media failed. There try %d items.",
                    mpAct.getAppId(),
                    i + 1);

        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }
    /**
     * 修改永久素材（图文）
     * @author 舒剑雄
     * @version 2017-09-20
     */
    public Boolean updateArticle(MediaTemp mediaTemps)throws WechatApiException{
        String url = mergeCgiBinUrl(update_media , getAccessToken());
        Map<String, Object> body = new HashMap<String, Object>();
        body.put("media_id",mediaTemps.getMediaId());
        body.put("index",mediaTemps.getIndex());
        body.put("articles", mediaTemps);
        String data = Json.toJson(body, JsonFormat.compact());
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.post(url, data));
            if (ar.getErrMsg().equals("ok")) {
                return true;
            }
            //无效的token
            if (ar.getErrCode().intValue() == 40001) {
                throw new WechatApiException("修改永久素材失败：无效的access_token，请稍后再尝试");
            }
            log.errorf("Create mp[%s] custom media failed. There try %d items.",
                    mpAct.getAppId(),
                    i + 1);

        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }
    public Boolean delMedia(String mediaId)throws WechatApiException {
        String url = mergeCgiBinUrl(del_media, getAccessToken(), mediaId);
        Map<String, Object> body = new HashMap<String, Object>();
        body.put("media_id", mediaId);
        String data = Json.toJson(body, JsonFormat.compact());
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.post(url, data));
            if (ar.getErrMsg().equals("ok")) {
                return true;
            }
            //无效的token
            if (ar.getErrCode().intValue() == 40001) {
                throw new WechatApiException("删除永久素材失败：无效的access_token，请稍后再尝试");
            }
            log.errorf("delete mp[%s] custom media failed. There try %d items.",
                    mpAct.getAppId(),
                    i + 1);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }
    @Override
    public File dlMedia(String mediaId) {
        String url = mergeCgiBinUrl(get_media, getAccessToken(), mediaId);
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            Object tmp = HttpTool.download(url);
            if (tmp instanceof File) {
                return (File) tmp;
            }

            ar = ApiResult.create((String) tmp);
            log.errorf("Download mp[%s] media failed. There try %d items.", mpAct.getMpId(), i);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }
    
    @Override
	public String findMedias(String type, String pageNo, String pageSize) throws WechatApiException {
    	String url = mergeCgiBinUrl(get_media_list , getAccessToken());
        Integer offset = Integer.valueOf(pageNo)*Integer.valueOf(pageSize);
    	String data = "{\"type\":\""+type+"\",\"offset\":\""+offset+"\",\"count\":\""+pageSize+"\"}";
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.post(url, data));
            //无效的token
            if (ar.getErrCode()!=null&&ar.getErrCode().intValue() == 40001) {
            	throw new WechatApiException("素材获取失败：无效的access_token");
            }
            if(!StringUtils.isBlank(ar.getJson()))
            	return ar.getJson();
            log.errorf("Get mp[%s] custom menu failed. There try %d items.",
                       mpAct.getAppId(),   
                       i + 1);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
	}

    @Override
    public int createGroup(String name) {
        String url = mergeCgiBinUrl(create_groups + getAccessToken());
        String data = "{\"group\":{\"name\":\"" + name + "\"}}";
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.post(url, data));
            if (ar.isSuccess()) {
                Groups g = Json.fromJson(Groups.class, Json.toJson(ar.get("group")));
                return g.getId();
            }

            log.errorf("Create mp[%s] group name[%s] failed. There try %d items.",
                       mpAct.getMpId(),
                       name,
                       i);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public List<Groups> getGroups() {
        String url = mergeCgiBinUrl(get_groups + getAccessToken());
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.get(url));
            if (ar.isSuccess()) {
                return Json.fromJsonAsList(Groups.class, Json.toJson(ar.get("groups")));
            }

            log.errorf("Get mp[%s] groups failed. There try %d items.", mpAct.getMpId(), i);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public int getGroup(String openId) {
        String url = mergeCgiBinUrl(get_member_group + getAccessToken());
        String data = "{\"openid\":\"" + openId + "\"}";
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.post(url, data));
            if (ar.isSuccess()) {
                return Integer.parseInt(String.valueOf(ar.get("groupid")));
            }

            log.errorf("Get mp[%s] openId[%s] groups failed. There try %d items.",
                       mpAct.getMpId(),
                       openId,
                       i);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public boolean renGroups(int id, String name) {
        String url = mergeCgiBinUrl(update_group + getAccessToken());
        String data = "{\"group\":{\"id\":" + id + ",\"name\":\"" + name + "\"}}";
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.post(url, data));
            if (ar.isSuccess()) {
                return true;
            }

            log.errorf("Rename mp[%s] groups[%d-%s] failed. There try %d items.",
                       mpAct.getMpId(),
                       id,
                       name,
                       i);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public boolean move2Group(String openId, int groupId) {
        String url = mergeCgiBinUrl(update_member_group + getAccessToken());
        String data = "{\"openid\":\"" + openId + "\",\"to_groupid\":" + groupId + "}";
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.post(url, data));
            if (ar.isSuccess()) {
                return true;
            }

            log.errorf("Move mp[%s] openId[%s] to groups[%d] failed. There try %d items.",
                       mpAct.getMpId(),
                       openId,
                       groupId,
                       i);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public boolean batchMove2Group(Collection<String> openIds, int groupId) {
        String url = mergeCgiBinUrl(update_members_group + getAccessToken());
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("openid_list", Json.toJson(openIds));
        data.put("to_groupid", groupId);
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.post(url, Json.toJson(data, JsonFormat.compact())));
            if (ar.isSuccess()) {
                return true;
            }

            log.errorf("Move mp[%s] openIds to groups[%d] failed. There try %d items.",
                       mpAct.getMpId(),
                       groupId,
                       i);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public boolean delGroup(int id) {
        String url = mergeCgiBinUrl(delete_groups + getAccessToken());
        String data = "{\"group\":{\"id\":" + id + "}}";
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.post(url, data));
            if (ar.isSuccess()) {
                return true;
            }

            log.errorf("Delete mp[%s] groups[%d] failed. There try %d items.",
                       mpAct.getMpId(),
                       id,
                       i);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public QRTicket createQR(Object sceneId, int expireSeconds) {
        String url = mergeCgiBinUrl(create_qrcode + getAccessToken());
        ApiResult ar = null;
        NutMap data = new NutMap();
        NutMap scene;
        // 临时二维码
        if (expireSeconds > 0) {
            data.put("action_name", "QR_SCENE");
            data.put("expire_seconds", expireSeconds);

            scene = Lang.map("scene_id", Castors.me().castTo(sceneId, Integer.class));
        }
        // 永久二维码
        else if (sceneId instanceof Number) {
            data.put("action_name", "QR_LIMIT_SCENE");
            scene = Lang.map("scene_id", Castors.me().castTo(sceneId, Integer.class));
        }
        // 永久字符串二维码
        else {
            data.put("action_name", "QR_LIMIT_STR_SCENE");
            scene = Lang.map("scene_str", sceneId.toString());
        }
        data.put("action_info", Lang.map("scene", scene));
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.post(url, Json.toJson(data, JsonFormat.compact())));
            if (ar.isSuccess()) {
                return Json.fromJson(QRTicket.class, Json.toJson(ar.getContent()));
            }

            log.infof("Create mp[%s] scene[%s] qrcode failed. There try %d items.",
                      mpAct.getMpId(),
                      data.get("action_name"),
                      i);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public File getQR(String ticket) {
        String url = mergeCgiBinUrl(show_qrcode + ticket);
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            Object tmp = HttpTool.get(url);
            if (tmp instanceof File) {
                return (File) tmp;
            }

            ar = ApiResult.create((String) tmp);
            log.errorf("Download mp[%s] qrcode image failed. There try %d items.",
                       mpAct.getMpId(),
                       i);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public boolean updateRemark(String openId, String remark) {
        String url = mergeCgiBinUrl(user_remark + getAccessToken());
        ApiResult ar = null;
        String data = "{\"openid\":\"" + openId + "\",\"remark\":\"" + remark + "\"}";
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.post(url, data));
            if (ar.isSuccess()) {
                return true;
            }

            log.errorf("Update mp[%s] user[%s] remark[%s] failed. There try %d items.",
                       mpAct.getMpId(),
                       openId,
                       remark,
                       i);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public FollowList getFollowerList(String nextOpenId) {
        String url = mergeCgiBinUrl(user_list, getAccessToken(), Strings.sNull(nextOpenId, ""));
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.get(url));
            if (ar.isSuccess()) {
                FollowList fl = Json.fromJson(FollowList.class, ar.getJson());
                Map<String, Object> openid = (Map<String, Object>) ar.get("data");
                fl.setOpenIds(Json.fromJson(List.class, Json.toJson(openid.get("openid"))));
                return fl;
            }

            log.infof("Get mp[%s] follow list failed. There try %d items.", mpAct.getMpId(), i);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public Follower getFollower(String openId, String lang) {
        String url = mergeCgiBinUrl(user_info, getAccessToken(), openId, Strings.sNull(lang, "zh_CN"));
        ApiResult ar = null;
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.get(url));
            if (ar.isSuccess()) {
                return Json.fromJson(Follower.class, ar.getJson());
            }

            log.errorf("Get mp[%s] follower[%s] information failed. There try %d items.",
                       mpAct.getMpId(),
                       openId,
                       i);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public List<Follower> getFollowers(Collection<Follower2> users) {
        String url = mergeCgiBinUrl(batch_user_info + getAccessToken());
        ApiResult ar = null;
        String data = Json.toJson(Lang.map("user_list", users), JsonFormat.compact());
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.post(url, data));
            if (ar.isSuccess()) {
                return Json.fromJsonAsList(Follower.class, Json.toJson(ar.get("user_info_list")));
            }

            log.errorf("Get mp[%s] followers information failed. There try %d items.",
                       mpAct.getMpId(),
                       i);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public boolean setIndustry(int id1, int id2) {
        String url = mergeCgiBinUrl(set_industry + getAccessToken());
        ApiResult ar = null;
        String data = "{\"industry_id1\":\"" + id1 + "\",\"industry_id2\":\"" + id2 + "\"}";
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.post(url, data));
            if (ar.isSuccess()) {
                return true;
            }

            log.errorf("Set mp[%s] template industry failed. There try %d items.",
                       mpAct.getMpId(),
                       i);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public String getTemplateId(String tmlShortId) {
        String url = mergeCgiBinUrl(add_template + getAccessToken());
        ApiResult ar = null;
        String data = "{\"template_id_short\":\"" + tmlShortId + "\"}";
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.post(url, data));
            if (ar.isSuccess()) {
                return String.valueOf(ar.get("template_id"));
            }

            log.errorf("Get mp[%s] template id failed. There try %d items.", mpAct.getMpId(), i);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }

    @Override
    public long sendTemplateMsg(String openId,
                                String tmlId,
                                String topColor,
                                String url,
                                Template... tmls) {
        String apiurl = mergeCgiBinUrl(send_template + getAccessToken());
        ApiResult ar = null;
        String data = JsonMsgBuilder.create().template(openId, tmlId, topColor, url, tmls).build();
        for (int i = 0; i < RETRY_COUNT; i++) {
            ar = ApiResult.create(HttpTool.post(apiurl, data));
            if (ar.isSuccess()) {
                return Long.valueOf(ar.get("msgid").toString());
            }

            log.errorf("Send mp[%s] template message failed. There try %d items.",
                       mpAct.getMpId(),
                       i);
        }

        throw Lang.wrapThrow(new WechatApiException(ar.getJson()));
    }
}
