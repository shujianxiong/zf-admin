package com.chinazhoufan.admin.common.test;

public class MyTest {

	public static void main(String agrs[]){
		A a=new A();
		B b=new B();
		C c=new C();
		System.out.println(b instanceof A);
		System.out.println(b instanceof C);
	}
}

class A{
	
}

class B extends A{
	
}

class C extends B{
	
}