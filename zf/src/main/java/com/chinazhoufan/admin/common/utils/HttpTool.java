package com.chinazhoufan.admin.common.utils;

import org.nutz.http.Http;
import org.nutz.http.Request;
import org.nutz.http.Request.METHOD;
import org.nutz.http.Response;
import org.nutz.http.Sender;
import org.nutz.lang.Lang;
import org.nutz.log.Log;
import org.nutz.log.Logs;

/**
 * Http工具包，用于访问API，上传或下载微信素材
 * 当服务器承载大量请求时会阻塞服务进程，例如应用场景微信网页授权获取openid
 * @author 杨晓辉
 * @since 2.0
 */
// TODO Http.disableJvmHttpsCheck();
public class HttpTool {

    private static final Log log = Logs.get();

    private static final int CONNECT_TIME_OUT = 5 * 1000;
    private static final String FILE_NAME_FLAG = "filename=";

    public static String get(String url) {
        if (log.isDebugEnabled()) {
            log.debugf("Request url: %s, default timeout: %d", url, CONNECT_TIME_OUT);
        }

        try {
            Response resp = Http.get(url, CONNECT_TIME_OUT);
            if (resp.isOK()) {
                String content = resp.getContent("UTF-8");
                if (log.isInfoEnabled()) {
                    log.infof("GET Request success. Response content: %s", content);
                }
                return content;
            }

            throw Lang.wrapThrow(new RuntimeException(String.format("Get request [%s] failed. status: %d",
                                                                    url,
                                                                    resp.getStatus())));
        }
        catch (Exception e) {
            throw Lang.wrapThrow(e);
        }
    }

    public static String post(String url, String body) {
        if (log.isDebugEnabled()) {
            log.debugf("Request url: %s, post data: %s, default timeout: %d",
                       url,
                       body,
                       CONNECT_TIME_OUT);
        }

        try {
            Request req = Request.create(url, METHOD.POST);
            req.setEnc("UTF-8");
            req.setData(body);
            Response resp = Sender.create(req, CONNECT_TIME_OUT).send();
            if (resp.isOK()) {
                String content = resp.getContent();
                if (log.isInfoEnabled()) {
                    log.infof("POST Request success. Response content: %s", content);
                }
                return content;
            }

            throw Lang.wrapThrow(new RuntimeException(String.format("Post request [%s] failed. status: %d",
                                                                    url,
                                                                    resp.getStatus())));
        }
        catch (Exception e) {
            throw Lang.wrapThrow(e);
        }
    }
}
