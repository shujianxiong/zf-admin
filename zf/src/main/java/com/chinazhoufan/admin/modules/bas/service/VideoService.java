package com.chinazhoufan.admin.modules.bas.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.qiniu.FileManager;
import com.chinazhoufan.admin.common.qiniu.QiNiuConfig;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.utils.SystemPath;
import com.chinazhoufan.admin.modules.bas.dao.VideoDao;
import com.chinazhoufan.admin.modules.bas.entity.Video;
import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.qiniu.common.QiniuException;


@Service
@Transactional(readOnly=true)
public class VideoService extends CrudService<VideoDao, Video> {
	

	public static final String TEMP_FILE_PATH="uploadTemp";//上传文件临时目录
	public static final String BAS_VIDEO_CODE="bas_video_code";//上传文件临时目录
	public static final String VIDEO_BUCKETNAME="video";//上传文件临时目录
	
	@Autowired
	private CodeGeneratorService codeGeneratorService;
	
	public Video get(String id) {
		return super.get(id);
	}
	
	public Video getByCode(String code) {
		return dao.getByCode(code);
	}
	
	public List<Video> findList(Video video) {
		return super.findList(video);
	}
	
	public Page<Video> findPage(Page<Video> page, Video video) {
		return super.findPage(page, video);
	}
	
	@Transactional(readOnly = false)
	public void save(Video video) {
		super.save(video);
	}
	
	@Transactional(readOnly = false)
	public void delete(Video video) {
		super.delete(video);
	}
	
	/**
	 * 上传视频
	 * @param video 
	 * @return
	 */
//	@Async
//	@Scheduled(fixedDelay=1000)
	@Transactional(readOnly=false)
	public void uploadVideo(MultipartFile file, Video video) {
		try {
			String fileName = file.getOriginalFilename();
			//fileName为空判定没有修改视频
			if (!StringUtils.isBlank(fileName)) {
				String suffix = fileName.substring(fileName.lastIndexOf("."), fileName.length());
				if (StringUtils.isBlank(suffix)) {
					return;
				}
				String newFileName = UUID.randomUUID().toString();
				String imgFilePath = SystemPath.getSysPath() + "" + TEMP_FILE_PATH + "//" + newFileName + suffix;//新生成的图片
				String qiNiufileName = "";
//			Thread.sleep(100000);
				File imgFile = new File(SystemPath.getSysPath() + "" + TEMP_FILE_PATH);
				if (!imgFile.isDirectory())
					imgFile.mkdirs();
				imgFile = new File(imgFilePath);
				if (!imgFile.exists()) {
					imgFile.createNewFile();
				}
				OutputStream out = new FileOutputStream(imgFile);
				out.write(file.getBytes());
				out.flush();
				out.close();

				FileManager fileManager = new FileManager();
				qiNiufileName = fileManager.uploadByFile(imgFile, QiNiuConfig.bucketName);
				boolean result = imgFile.delete();
				if (!result) {
					System.gc();//系统进行资源强制回收
					imgFile.delete();
				}
				video.setFileUrl(qiNiufileName);
				video.setCode(codeGeneratorService.generateCode(BAS_VIDEO_CODE));
			}
			save(video);
		} catch (QiniuException e) {
			e.printStackTrace();
		}catch (IOException e) {
			e.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
