package com.chinazhoufan.admim.test;
/**
 * @author 张金俊
 * @version 创建时间：2016年8月6日 下午5:53:37
 * 类说明
 */
public class testMemory {
	
	 /**
     * @param args
     */
   public static void main(String[] args) {
      System. out .println( " 内存信息 :" + toMemoryInfo ());
   }

   /**
     * 获取当前 jvm 的内存信息
     *
     * @return
     */
   public static String toMemoryInfo() {

      Runtime currRuntime = Runtime.getRuntime ();
      int nFreeMemory = ( int ) (currRuntime.freeMemory() / 1024 / 1024);
      int nTotalMemory = ( int ) (currRuntime.totalMemory() / 1024 / 1024);
      return nFreeMemory + "M/" + nTotalMemory + "M(free/total)" ;
   }
	
}
