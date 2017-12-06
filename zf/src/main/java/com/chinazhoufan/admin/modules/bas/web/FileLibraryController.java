/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.qiniu.FileManager;
import com.chinazhoufan.admin.common.qiniu.QiNiuConfig;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.utils.SystemPath;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bas.entity.FileDir;
import com.chinazhoufan.admin.modules.bas.entity.FileLibrary;
import com.chinazhoufan.admin.modules.bas.entity.FileProp;
import com.chinazhoufan.admin.modules.bas.service.FileDirService;
import com.chinazhoufan.admin.modules.bas.service.FileLibraryService;
import com.chinazhoufan.admin.modules.bas.service.FilePropService;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.chinazhoufan.api.common.config.Constants;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;
import com.qiniu.common.QiniuException;

/**
 * 图片库Controller
 * @author 刘晓东
 * @version 2016-05-03
 */
@Controller
@RequestMapping(value = "${adminPath}/bas/fileLibrary")
public class FileLibraryController extends BaseController {

	protected transient Log logger = LogFactory.getLog(getClass());
	
	public static final String TEMP_FILE_PATH="uploadTemp";//上传文件临时目录
	
	@Autowired
	private FileLibraryService fileLibraryService;
	@Autowired
	private FilePropService filePropService;
	@Autowired
	private FileDirService fileDirService;
	
	@RequiresPermissions("bas:fileLibrary:view")
	@RequestMapping(value = {"list", ""})
	public String list(FileLibrary fileLibrary, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<FileLibrary> page=new Page<FileLibrary>(request, response);
		page.setPageSize(30);
		page = fileLibraryService.findPage(page, fileLibrary);
		model.addAttribute("page", page);
		return "modules/bas/fileLibraryList";
	}

	@RequiresPermissions("bas:fileLibrary:view")
	@RequestMapping(value = "form")
	public String form(FileLibrary fileLibrary, Model model) {
		model.addAttribute("fileLibrary", fileLibrary);
		return "modules/bas/fileLibraryForm";
	}
	
	@RequiresPermissions("bas:fileLibrary:view")
	@RequestMapping(value = "editForm")
	public String editForm(FileLibrary fileLibrary,HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isBlank(fileLibrary.getId())){
			addMessage(model, "图片修改错误：请选择您要修改的图片");
			return list(fileLibrary, request, response, model);
		}
		model.addAttribute("fileLibrary", fileLibraryService.find(fileLibrary.getId()));
		return "modules/bas/fileLibraryForm";
	}

	@RequiresPermissions("bas:fileLibrary:edit")
	@RequestMapping(value = "save")
	public String save(FileLibrary fileLibrary, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, fileLibrary)){
			return form(fileLibrary, model);
		}
		if(StringUtils.isBlank(fileLibrary.getFileUrl())){
			addMessage(model, "上传错误：请选择您要上传的图片");
			return form(fileLibrary, model);
		}
		fileLibraryService.save(fileLibrary);
		addMessage(model, "保存图片库成功");
		return  "redirect:"+Global.getAdminPath()+"/bas/fileLibrary/?repage";
	}
	
	@RequiresPermissions("bas:fileLibrary:edit")
	@RequestMapping(value = "delete")
	public String delete(String[] fileLibrarys, Model model,RedirectAttributes redirectAttributes) {
		if(fileLibrarys==null||fileLibrarys.length<=0){
			addMessage(redirectAttributes, "图片删除错误：请选择您要删除的图片");
			return "redirect:"+Global.getAdminPath()+"/bas/fileLibrary/?repage";
		}
		fileLibraryService.delete(fileLibrarys);
		addMessage(redirectAttributes, "删除图片库成功");
		return "redirect:"+Global.getAdminPath()+"/bas/fileLibrary/?repage";
	}
	
	@RequiresPermissions("bas:fileLibrary:edit")
	@RequestMapping(value = "propInfo")
	public String propInfo(String id,Model model){
		if(StringUtils.isBlank(id)){
			addMessage(model, "获取详情失败：未能获取到图片ID信息");
		}else{
			List<FileProp> list=filePropService.findListByLibraryId(id);
			model.addAttribute("fileProps", list);
		}
		return "modules/bas/filePropInfo";
	}
	
	
	@RequiresPermissions(value = {"bas:fileUpload", "bas:fileView"}, logical=Logical.OR)
	@RequestMapping(value = "uploadViewIndex")
	public String publicFileUploadIndex(String fileDirId,boolean selectMultiple,Model model,HttpServletRequest request, HttpServletResponse response){
		/*Page<FileLibrary> page=new Page<FileLibrary>(request, response);
		page.setPageSize(30);
		FileLibrary fileLibrary=new FileLibrary();
		FileDir fileDir = new FileDir(fileDirId);
		fileDir.setType(FileDir.TYPE_PUBLIC);
		fileLibrary.setFileDir(fileDir);
		page = fileLibraryService.findPage(page, fileLibrary);
		model.addAttribute("page", page);
		model.addAttribute("fileDirId", fileDirId);*/
		model.addAttribute("selectMultiple", selectMultiple);
		return "fileupload/publicIndex";
	}
	
	
	/**
	 * 进入公开文件上传页
	 * @param fileDirId				目录
	 * @param selectMultiple		文件选择模式 true多选 false单选
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequiresPermissions(value = {"bas:fileUpload", "bas:fileView"}, logical=Logical.OR)
	@RequestMapping(value = "uploadView")
	public String publicFileUpload(String fileDirId,boolean selectMultiple,Model model,HttpServletRequest request, HttpServletResponse response){
		Page<FileLibrary> page=new Page<FileLibrary>(request, response);
		page.setPageSize(30);
		FileLibrary fileLibrary=new FileLibrary();
		FileDir fileDir = new FileDir(fileDirId);
		fileDir.setType(FileDir.TYPE_PUBLIC);
		fileLibrary.setFileDir(fileDir);
		page = fileLibraryService.findPage(page, fileLibrary);
		model.addAttribute("page", page);
		model.addAttribute("selectMultiple", selectMultiple);
		model.addAttribute("fileDirId", fileDirId);
		return "fileupload/public";
	}
	
	/**
	 * 进入隐藏文件上传页
	 * @return
	 */
	@RequiresPermissions(value = {"bas:fileUpload", "bas:fileView"}, logical=Logical.OR)
	@RequestMapping(value = "hideUploadView")
	public String hideFileUpload(String fileDirCode,boolean selectMultiple,Model model,HttpServletRequest request, HttpServletResponse response){
		if(StringUtils.isBlank(fileDirCode)){
			throw new ServiceException("友情提示：未能获取到文件目录编码");
		}
		FileDir fileDir=fileDirService.findFileDirByCode(fileDirCode);
		if(fileDir==null){
			throw new ServiceException("警告：文件上传目录不存在");
		}
		Page<FileLibrary> page=new Page<FileLibrary>(request, response);
		page.setPageSize(30);
		FileLibrary fileLibrary=new FileLibrary();
		fileLibrary.setFileDir(fileDir);
		fileLibrary.setCreateBy(UserUtils.getUser());
		page = fileLibraryService.findPage(page, fileLibrary);
		model.addAttribute("page", page);
		model.addAttribute("selectMultiple", selectMultiple);
		model.addAttribute("fileDirCode", fileDirCode);
		return "fileupload/hide";
	}
	
	public static void main(String[] args) {
		String fileName = "aaa.xx.txt";
		System.out.println(fileName.substring(fileName.lastIndexOf("."), fileName.length()));
	}
	
	/**
	 * 文件上传
	 * @param fileLibrary
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequiresPermissions("bas:fileUpload")
	@RequestMapping(value = "upload")
	@ResponseBody
	public String fileUpload(MultipartFile Filedata,String Filename,String Upload,String fileDirId,String fileDirCode,Model model,HttpServletRequest request, HttpServletResponse response){
		if(StringUtils.isBlank(fileDirId)&&StringUtils.isBlank(fileDirCode)){
			return Constants.ERROR+"";
		}
		String fileName = Filedata.getOriginalFilename(); 
		String suffix = fileName.substring(fileName.lastIndexOf("."), fileName.length());
		if(StringUtils.isBlank(suffix)){
			return Constants.ERROR+"";
		}
		
		String newFileName = UUID.randomUUID().toString();
	    String imgFilePath = SystemPath.getSysPath()+""+ TEMP_FILE_PATH+"//"+newFileName+suffix;//新生成的图片
	    
	    FileDir fileDir=null;
	    if(!StringUtils.isBlank(fileDirId))
	    	fileDir=new FileDir(fileDirId);
	    if(!StringUtils.isBlank(fileDirCode))
	    	fileDir=fileDirService.findFileDirByCode(fileDirCode);
	    if(fileDir==null){
	    	return Constants.ERROR+"";
	    }
		try {
			File imgFile=new File(SystemPath.getSysPath()+""+ TEMP_FILE_PATH);
			if(!imgFile.isDirectory())
				imgFile.mkdirs();
			imgFile=new File(imgFilePath);
			if(!imgFile.exists()){
				imgFile.createNewFile();
			}
			OutputStream out = new FileOutputStream(imgFile);    
		    out.write(Filedata.getBytes());  
		    out.flush();  
		    out.close(); 
		    
		    FileManager fileManager=new FileManager();
			String qiNiufileName=fileManager.uploadByFile(imgFile, QiNiuConfig.bucketName);
			boolean result = imgFile.delete();
//			java.nio.file.Path path = java.nio.file.Paths.get(imgFile.toURI());
//			java.nio.file.Files.delete(path);
			if(!result){
				System.gc();//系统进行资源强制回收
				imgFile.delete();
			}
			
			//构建fileLibrary
			FileLibrary fileLibrary=new FileLibrary();
			fileLibrary.setFileDir(fileDir);
			fileLibrary.setFileUrl(qiNiufileName);
			fileLibrary.setName(fileName);//文件真实名称
			fileLibrary.setPostfix(suffix);//文件后缀
			if(suffix.equals(".JPG")
					||suffix.equals(".jpg")
					||suffix.equals(".JPEG")
					||suffix.equals(".jpeg")
					||suffix.equals(".png")
					||suffix.equals(".PNG")
					||suffix.equals(".gif")
					||suffix.equals(".GIF")
					||suffix.equals(".ico")
					||suffix.equals(".ICO")
					||suffix.equals(".bmp")
					||suffix.equals(".BMP")){
				fileLibrary.setType(FileLibrary.TYPE_IMG);
			}else{
				fileLibrary.setType(FileLibrary.TYPE_OTHERS);
			}
			fileLibraryService.save(fileLibrary);
		} catch (QiniuException e) {
			e.printStackTrace();
			return Constants.ERROR+"";
		}catch (IOException e) {
			e.printStackTrace();
			return Constants.ERROR+"";
		}catch (Exception e) {
			e.printStackTrace();
			return Constants.ERROR+"";
		}
		return Constants.SUCCESS+"";
	}
	
	/**[接口]
	 * 删除文件
	 * @param id 图片ID
	 * @param response
	 * @return
	 */
	@RequiresPermissions("bas:fileUpload")
	@RequestMapping(value = "delFile", method = {RequestMethod.POST, RequestMethod.GET})
	public @ResponseBody String delFile(String id,String fileDirId, HttpServletResponse response) {
		if(StringUtils.isBlank(id)){
			logger.debug("file del info:id为空");
			return JsonMapper.toJsonString(new Echos(Constants.PARAMETER_ISNULL));
		}
		User user=UserUtils.getUser();
		if(user==null){
			logger.debug("file del info:user为空,当前未登录");
			return JsonMapper.toJsonString(new Echos(Constants.ERROR,"当前未登录"));
		}
		FileLibrary fileLibrary = fileLibraryService.get(id);
		if(fileLibrary==null){
			logger.debug("file del info:fileLibrary为空,未能找到对应的文件");
			return JsonMapper.toJsonString(new Echos(Constants.ERROR,"未能找到对应的文件"));
		}
		if(!user.getLoginName().equals("admin") && !user.getId().equals(fileLibrary.getCreateBy().getId())){
			logger.debug("file del info:文件只有原始的上传人才能删除");
			return JsonMapper.toJsonString(new Echos(Constants.ERROR,"文件只有原始的上传人才能删除"));
		}
		List<FileLibrary> list = fileLibraryService.findByFileUrl(fileLibrary.getFileUrl());
		if(list!=null&&list.size()>1){
			//只删除记录，不删除七牛云
			if(StringUtils.isBlank(fileDirId)){
				fileLibraryService.delete(list.get(0));
			}else{
				for(FileLibrary file:list){
					if(file.getFileDir()!=null&&file.getFileDir().getId().equals(fileDirId)){
						fileLibraryService.delete(file);
						break;
					}
				}
			}
		}
		if(list!=null&&list.size()==1){
			//当只剩下唯一的一条记录时删除记录同时删除七牛云资源
			fileLibraryService.delete(list.get(0));
			try {
			    FileManager fileManager=new FileManager();
			    fileManager.delete(list.get(0).getFileUrl());
			} catch (QiniuException e) {
				e.printStackTrace();
				return JsonMapper.toJsonString(new Echos(Constants.ERROR,"图片删除记录，但是云资源删除失败"));
			}catch (IOException e) {
				e.printStackTrace();
				return JsonMapper.toJsonString(new Echos(Constants.ERROR,"图片删除记录，但是云资源删除失败"));
			}
		}
		//删除记录同时删除七牛云记录
		return JsonMapper.toJsonString(new Echos(Constants.SUCCESS));
	}

	
	/**[接口]
	 * 根据图片ID查询图片信息、图片属性信息
	 * @param id 图片ID
	 * @param response
	 * @return
	 */
	@RequiresPermissions("bas:fileLibrary:view")
	@RequestMapping(value = "getFileAndPropertyById", method = {RequestMethod.POST, RequestMethod.GET})
	public @ResponseBody String getFileAndPropertyById(String id, HttpServletResponse response) {
		if(StringUtils.isBlank(id)){
			logger.debug("get file and property by id info:参数id为空");
			return JsonMapper.toJsonString(new Echos(Constants.PARAMETER_ISNULL));
		}
		FileLibrary fileLibrary = fileLibraryService.getFileAndPropertyById(id);
		return JsonMapper.toJsonString(fileLibrary);
	}
	
	/**[接口]
	 * 根据图片ID查询图片信息、图片属性信息
	 * @param id 图片ID
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "fileInfo", method = {RequestMethod.POST, RequestMethod.GET})
	public @ResponseBody String getFileAndPropertyByUrl(String url, HttpServletResponse response) {
		if(StringUtils.isBlank(url)){
			logger.debug("get file and property by url info:url为空");
			return JsonMapper.toJsonString(new Echos(Constants.PARAMETER_ISNULL));
		}
		List<FileLibrary> list = fileLibraryService.findByFileUrl(url);
		if(list==null||list.size()<=0){
			logger.debug("get file and property by url info:查询到的fileLibraryList为空");
			return JsonMapper.toJsonString(new Echos(Constants.ERROR));
		}
		return JsonMapper.toJsonString(new Echos(Constants.SUCCESS,list.get(0)));
	}
}

