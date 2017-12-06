package com.chinazhoufan.admin.common.utils;

import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.UUID;

import net.coobird.thumbnailator.Thumbnails;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class Base64Util {
	
	public static final int IMG_TYPE_HEADER=0;//头像
	public static final int IMG_TYPE_MINICAST=1;//小咖秀
	public static final int IMG_TYPE_FEEDBACK=2;//反馈图片
	public static final String DEFAULT_IMG_TYPE=".jpg";//默认转换图片类型
	
	//针对七牛云   2016-10-24
	public static final String TEMP_FILE_PATH="uploadTemp";
	
	/**
	 * 图片转base64字符串
	 * @param imgFilePath 文件路径
	 * @return 图片base64编码
	 */
    public synchronized static String GetImageStr(String imgFilePath)
    {//将图片文件转化为字节数组字符串，并对其进行Base64编码处理
        InputStream in = null;
        byte[] data = null;
        //读取图片字节数组
        try{
            in = new FileInputStream(imgFilePath);        
            data = new byte[in.available()];
            in.read(data);
            in.close();
        } 
        catch (IOException e){
            e.printStackTrace();
        }
        //对字节数组Base64编码
        BASE64Encoder encoder = new BASE64Encoder();
        return encoder.encode(data);//返回Base64编码过的字节数组字符串
    }
    
    /**
     * base64字符串转图片
     * @param usercode  注册账号名
     * @param imgStr 图片base64数据
     * @param type 图片类型 ：0 头像 1小咖秀
     * @param scale 缩放比 0-1
     * @return 图片存放路径
     */
    public synchronized static String GenerateImage(String usercode,String imgStr,int type,float scale)
    {   //对字节数组字符串进行Base64解码并生成图片
        if (imgStr == null) //图像数据为空
            return "";
        BASE64Decoder decoder = new BASE64Decoder();
        try{
            //Base64解码
            byte[] b = decoder.decodeBuffer(imgStr);
            for(int i=0;i<b.length;++i)
            {
                if(b[i]<0)
                {//调整异常数据
                    b[i]+=256;
                }
            }
            //生成jpeg图片
            String fileName=getFileName(usercode);
            String webFilePath = Base64Util.getImgSavePath(type,fileName);
            String imgFilePath = SystemPath.getSysPath()+""+ webFilePath;//新生成的图片
            InputStream inputStream=new ByteArrayInputStream(b);
            Thumbnails.of(inputStream).scale(scale).toFile(imgFilePath);
            return webFilePath;
        }catch (Exception e){
        	e.printStackTrace();
            return "";
        }
    }
    
    private static String getImgSavePath(int type,String fileName){
    	switch (type) {
			case IMG_TYPE_HEADER:
				return "memberfiles/headerImg/"+fileName;
			case IMG_TYPE_MINICAST:
				return "memberfiles/minicast/"+fileName;
			case IMG_TYPE_FEEDBACK:
				return "memberfiles/feedback/"+fileName;
			default: 
				break;
		}
    	return "";
    }
    
    private static String getFileName(String nickName){
    	String uuid=UUID.randomUUID().toString();
    	uuid=uuid.replace("-","");
    	return nickName+"-"+uuid+""+DEFAULT_IMG_TYPE;
    }
   
    /*public static void main(String[] args){
    	try {
    		//带水印
			Thumbnails.of("D:\\1.jpg").scale(0.5f).watermark(Positions.BOTTOM_RIGHT,ImageIO.read(new File("D:\\sy.png")),0.5f).toFile("D:\\2.jpg");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }*/
    
    
    /**
     * 针对七牛云，上传图片  接口
     * base64字符串转图片
     * @param imgStr 图片base64数据
     * @param type 图片类型 ：0 头像 1小咖秀
     * @param scale 缩放比 0-1
     * @return 图片路径
     */
    public synchronized static String GenerateImage(String imgStr)
    {   //对字节数组字符串进行Base64解码并生成图片
        if (imgStr == null) //图像数据为空
            return "";
        imgStr=imgStr.replace("data:image/jpeg;base64,", "");
        BASE64Decoder decoder = new BASE64Decoder();
        try{
            //Base64解码
            byte[] b = decoder.decodeBuffer(imgStr);
            for(int i=0;i<b.length;++i)
            {
                if(b[i]<0)
                {//调整异常数据
                    b[i]+=256;
                }
            }
            //生成jpeg图片
            String fileName=UUID.randomUUID().toString().replace("-","")+DEFAULT_IMG_TYPE;
            String imgFilePath = SystemPath.getSysPath()+""+ TEMP_FILE_PATH+"\\"+fileName;//新生成的图片
            OutputStream out = new FileOutputStream(imgFilePath);      
            out.write(b);  
            out.flush();  
            out.close(); 
            return imgFilePath;
        }catch (Exception e){
        	e.printStackTrace();
            return "";
        }
    }
}
