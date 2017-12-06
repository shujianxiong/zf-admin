package com.chinazhoufan.admim.test;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.chinazhoufan.admin.common.qiniu.FileManager;
import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.util.StringMap;

public class Test {


		public static void main(String args[]) {
			/*WhProduce w = new WhProduce();
	        System.out.println(w.getStockSafe());
	        System.out.println(String.valueOf(w.getStockSafe()));
	        System.out.println(StringUtils.isBlank(String.valueOf(w.getStockSafe())));
	        System.out.println((!StringUtils.isBlank(String.valueOf(w.getStockStandard()))&& !StringUtils.isBlank(String.valueOf(w.getStockSafe()))&& !StringUtils.isBlank(String.valueOf(w.getStockWarning()))));*/
	    
			
			
			FileManager fm = new FileManager();
			try {
				Response rs = fm.upload("D://50.jpg", "pretty girl");
				
				
				System.out.println(rs.statusCode+"======="+rs.jsonToMap());
				StringMap smap = rs.jsonToMap();
				System.out.println(smap.get("hash"));
			} catch (QiniuException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		
		}
	
	    public static int compare_date(String DATE1, String DATE2) {
	       
	       
	        DateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm");
	        try {
	            Date dt1 = df.parse(DATE1);
	            Date dt2 = df.parse(DATE2);
	            if (dt1.getTime() > dt2.getTime()) {
	                System.out.println("dt1 在dt2后");
	                return 1;
	            } else if (dt1.getTime() < dt2.getTime()) {
	                System.out.println("dt1在dt2前");
	                return -1;
	            } else {
	                return 0;
	            }
	        } catch (Exception exception) {
	            exception.printStackTrace();
	        }
	        return 0;
	    }
}
