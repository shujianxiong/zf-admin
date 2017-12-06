package com.chinazhoufan.admin.common.utils;

import java.util.Random;

/**
 * 源文件来源网上，在此基础上更改，直接根据随机长整型的值来生成，而非指定ID
 * 邀请码生成器，算法原理：<br/>
 * 1) 获取id: 1127738 <br/>
 * 2) 使用自定义进制转为：gpm6 <br/>
 * 3) 转为字符串，并在后面加'o'字符：gpm6o <br/>
 * 4）在后面随机产生若干个随机数字字符：gpm6o7 <br/>
 * 转为自定义进制后就不会出现o这个字符，然后在后面加个'o'，这样就能确定唯一性。最后在后面产生一些随机字符进行补全。<br/>
 * @author jiayu.qiu
 */
public class ShareCodeUtil {

	/** 自定义进制(0,1没有加入,容易与o,l混淆) */
    private static final char[] r=new char[]{'q', 'w', 'e', '8', 'a', 's', '2', 'd', 'z', 'x', '9', 'c', '7', 'p', '5', 'i', 'k', '3', 'm', 'j', 'u', 'f', 'r', '4', 'v', 'y', 'l', 't', 'n', '6', 'b', 'g', 'h'};
    
    /** (不能与自定义进制有重复) */
    private static final char b='o';

    /** 进制长度 */
    private static final int binLen=r.length;

    /** 邀请码 */
    public static final int INVITE_CODE_LENGTH = 6;
    public static final String  INVITE_CODE_DATA_TYPE = "U";//UPPER == 大写  LOWER = 小写
    /** 优惠券编码 */
    public static final int COUPON_CODE_LENGTH = 8;
    public static final String  COUPON_CODE_DATA_TYPE = "L";//小写
    
    
    /**
     * 生成字母与数字组成的随机码
     * @param length	要生成的随机码长度
     * @param dtype		随机码中字符的大小写类型（U：大写    L：小写）
     * @return
     */
    public static String generateSerialCode(int length, String dtype) {
    	Random rand = new Random();
    	long id = Math.abs(rand.nextInt(length));
        char[] buf=new char[32];
        int charPos=32;
        
        while((id / binLen) > 0) {
            int ind=(int)(id % binLen);
            // System.out.println(num + "-->" + ind);
            buf[--charPos]=r[ind];
            id /= binLen;
        }
        buf[--charPos]=r[(int)(id % binLen)];
        // System.out.println(num + "-->" + num % binLen);
        String str=new String(buf, charPos, (32 - charPos));
        // 不够长度的自动随机补全
        if(str.length() < length) {
            StringBuilder sb=new StringBuilder();
            sb.append(b);
            Random rnd=new Random();
            for(int i=1; i < length - str.length(); i++) {
            	sb.append(r[rnd.nextInt(binLen)]);
            }
            str+=sb.toString();
        }
        if("U".equals(dtype)) {
        	return str.toUpperCase();
        }
        return str;
    }

    public static long codeToId(String code) {
        char chs[]=code.toCharArray();
        long res=0L;
        for(int i=0; i < chs.length; i++) {
            int ind=0;
            for(int j=0; j < binLen; j++) {
                if(chs[i] == r[j]) {
                    ind=j;
                    break;
                }
            }
            if(chs[i] == b) {
                break;
            }
            if(i > 0) {
                res=res * binLen + ind;
            } else {
                res=ind;
            }
            // System.out.println(ind + "-->" + res);
        }
        return res;
    }
    
    public static void main(String[] args) {
    	System.out.println(ShareCodeUtil.generateSerialCode(8, "U"));
	}
}
