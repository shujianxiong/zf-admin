package com.chinazhoufan.admin.test.entity;

import java.util.ArrayList;
import java.util.List;

public class TestClone {

	public static void main(String[] args){
		CarControl carControl=new CarControl();
		carControl.setColor("RED");
		carControl.setModel(1);
		
		CarWheel carWheel=null;
		List<CarWheel> carWheels=new ArrayList<CarWheel>();
		for(int i=0;i<4;i++){
			carWheel=new CarWheel();
			carWheel.setModel(1);
			carWheel.setSpecifications("米其林");
			carWheels.add(carWheel);
		}
		
		Car carA=new Car();
		carA.setName("汽车A");
		carA.setCode("浙A-FS11051");
		carA.setWeight(1500.23);
		carA.setChairNum(4);
		carA.setCarControl(carControl);
		carA.setCarWheels(carWheels);
		try{
			//克隆后carB属性值应该等同于carA，但carB不等于carA
			Car carB=(Car) carA.clone();
			System.out.println(carB.equals(carA));
			//克隆后改变carA的引用对象的值
			carB.getCarControl().setColor("BLUE");
			carB.getCarWheels().get(0).setSpecifications("虎牌");
			carB.setName("汽车B");
			carB.setChairNum(2);
			
			System.out.println(carA.getName()+" "+carA.getChairNum()+" "+carA.getCarControl().getColor()+" "+carA.getCarWheels().get(0).getSpecifications());
			System.out.println(carB.getName()+" "+carB.getChairNum()+" "+carB.getCarControl().getColor()+" "+carB.getCarWheels().get(0).getSpecifications());
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
	}
}


class Car implements Cloneable{
	private String name;
	private String code;
	private double weight;
	private int chairNum;
	private CarControl carControl;
	private List<CarWheel> carWheels;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public double getWeight() {
		return weight;
	}
	public void setWeight(double weight) {
		this.weight = weight;
	}
	public int getChairNum() {
		return chairNum;
	}
	public void setChairNum(int chairNum) {
		this.chairNum = chairNum;
	}
	public CarControl getCarControl() {
		return carControl;
	}
	public void setCarControl(CarControl carControl) {
		this.carControl = carControl;
	}
	public List<CarWheel> getCarWheels() {
		return carWheels;
	}
	public void setCarWheels(List<CarWheel> carWheels) {
		this.carWheels = carWheels;
	}
	
	@Override
	protected Object clone() throws CloneNotSupportedException {
		Car car=(Car) super.clone();
		// 此部分代码可注释查看浅拷贝效果--begin--
		if(car.getCarControl()!=null)
			car.setCarControl((CarControl)this.getCarControl().clone());
		if(car.getCarWheels()!=null){
			CarWheel carWheel=null;
			for(int i=0;i<this.getCarWheels().size();i++){
				carWheel=this.getCarWheels().get(i);
				car.getCarWheels().set(i, (CarWheel)carWheel.clone());
			}
		}
		// 此部分代码可注释查看浅拷贝效果--end--
		
		return car;
	}
}

class CarWheel implements Cloneable{
	private String specifications;
	private int model;

	public int getModel() {
		return model;
	}

	public void setModel(int model) {
		this.model = model;
	}

	public String getSpecifications() {
		return specifications;
	}

	public void setSpecifications(String specifications) {
		this.specifications = specifications;
	}
	
	@Override
	protected Object clone() throws CloneNotSupportedException {
		// TODO Auto-generated method stub
		return super.clone();
	}
}

class CarControl implements Cloneable{
	private String color;
	private int model;
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public int getModel() {
		return model;
	}
	public void setModel(int model) {
		this.model = model;
	}
	
	@Override
	protected Object clone() throws CloneNotSupportedException {
		// TODO Auto-generated method stub
		return super.clone();
	}
}