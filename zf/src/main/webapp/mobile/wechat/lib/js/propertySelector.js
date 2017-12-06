/**
 * 属性选择器
 */

//属性对象 适配页面
//js中 对象首字母大写，对象内部方法下划线打头
//name 属性名
function Property(name){
	this.name=name;//属性名
	this.selectVal=null;//选中属性值对象
	this.vals=new Array();//属性值集合
	this.add=function(val){//val 属性值
		var propvalue={}
		for(var i=0;i<this.vals.length;i++){
			if(this.vals[i].val==val)//重复属性值不添加
				return;
		}
		propvalue.val=val;//属性值
		propvalue.status=0;//0 可选  1禁止选择
		propvalue.isCheck=false;//是否选中
		this.vals.push(propvalue);
	};
	this.getVal=function(val){//获得属性值对象
		for(var i=0;i<this.vals.length;i++){
			if(val==this.vals[i].val)
				return this.vals[i];
		}
	}
}

//产品对象 适配业务
function Produce(id,goodsId,s,price){
	this.id=id;//产品ID
	this.goodsId=goodsId;
	this.s=s;//库存
	this.price=price;//价格
	this.sellNum=0;//购买数量
	this.data=null;//原始数据
	this.producePropvalues=new Array();//产品组合属性 
	this.add=function(name,val){
		var producePropvalue={}
		producePropvalue.name=name;//属性名
		producePropvalue.propVal=val;//属性值
		this.producePropvalues.push(producePropvalue);
	}
	this.setNum=function(num){
		if(this.s<num)
			return false;
		this.sellNum=num;
	}
}

//商品对象
function Goods(id,jsonData){
	this.id=id;
	this.jsonData=jsonData;
	this.produces=new Array();//商品下所有产品集合
	this.propertys=new Array();//商品下所有决定价格的属性集合
}

//属性选择器
var selectProduce={
		selectProduces:new Array(),//选中产品
		goodsArray:new Array(),//所有商品集合
		selectProperty:new Array(),//已选择属性对象
		init:function(callBack){
			this.goodsArray=new Array();
			this.selectProperty=new Array();
			this.goodsArray=callBack();
		},
		_getPropertyByName:function(name,propertys){
			for(var i=0;i<propertys.length;i++){
				if(propertys[i].name==name)
					return propertys[i]
			}
		},
		_validateProperty:function(val,producePropvalues){
			for(var j=0;j<producePropvalues.length;j++){
				if(val==producePropvalues[j].propVal.val){
					return true;
				}
			}
			return false;
		},
		_getSelectOther:function(name){
			var array=[];
			for(var i=0;i<this.selectProperty.length;i++){
				if(this.selectProperty[i].name==name)
					continue;
				for(var j=0;j<this.selectProperty[i].vals.length;j++){
					if(this.selectProperty[i].vals[j].isCheck)
						array.push(this.selectProperty[i].vals[j])
				}
			}
			return array;
		},
		_getSeletctProduceFilter:function(propertys,produces){//根据已选择属性，获取可选产品
			var array=[];
			for(var i=0;i<produces.length;i++){
				var isAdd=true;
				for(var j=0;j<propertys.length;j++){
					if(!this._validateProperty(propertys[j].val,produces[i].producePropvalues)){
						isAdd=false;
						break;
					}
				}
				if(isAdd){
					array.push(produces[i])
				}
			}
			return array;
		},
		_propertyFilter:function(property,goods){
			var propertyOther=this._getSelectOther(property.name);//获得其它已选择属性
			var produces=this._getSeletctProduceFilter(propertyOther,goods.produces);//根据其它已选择属性获得可选产品
			//将当前属性下所有属性值变更为不可选，排除已选择
			for(var i=0;i<property.vals.length;i++){
				property.vals[i].status=1;
			}
			for(var i=0;i<produces.length;i++){
				for(var j=0;j<produces[i].producePropvalues.length;j++){
					if(produces[i].producePropvalues[j].name==property.name){
						produces[i].producePropvalues[j].propVal.status=0;//可选择
					}
				}
			}
			
		},
		cancelSelect:function(propVal){//取消选中
			//属性值对象 取消选中状态
			propVal.isCheck=false;
			//移除已选中属性值
			for(var i=0;i<this.selectProperty.length;i++){
				if(this.selectProperty[i].selectVal.val==propVal.val){
					this.selectProperty.splice(i,1);
					break;
				}
			}
		},
		select:function(property,propVal){//选中
			//单选模式,将已选择属性值更换为未选择
			for(var i=0;i<property.vals.length;i++){
				if(property.vals[i].val!=propVal.val&&property.vals[i].isCheck){
					this.cancelSelect(property.vals[i])
					break;
				}
			}
			property.selectVal=propVal;
			//属性值对象 变更选中状态
			propVal.isCheck=true;
			this.selectProperty.push(property);
		},
		getProduces:function(produces){//根据所有产品获取当前选择项可选择的产品集合
			var array=[];
			for(var i=0;i<produces.length;i++){
				var isAdd=true;
				for(var j=0;j<this.selectProperty.length;j++){
					if(!this._validateProperty(this.selectProperty[j].selectVal.val,produces[i].producePropvalues)){
						isAdd=false;
						break;
					}
				}
				if(isAdd){
					array.push(produces[i])
				}
			}
			return array;
		},
		getStock:function(){//获取当前可选产品库存
			var stock=0;
			var produces=this.selectProduces;
			for(var i=0;i<produces.length;i++){
				stock=stock+parseInt(produces[i].s);
			}
			return stock;
		},
		changeNum:function(inputId,type){
			var sellNum=$(inputId).val();
			var stock=this.getStock();
			if(type==1){
				if(sellNum>=stock)
					return;
				//加
				sellNum++;
			}else{
				if(sellNum<=1)
					return;
				//减
				sellNum--;
			}
			$(inputId).val(sellNum)
		},
		propertyClick:function(name,val,goods){
			var property=this._getPropertyByName(name,goods.propertys);
			//属性值对象
			var propVal=property.getVal(val)
			//属性取消选中
			if(propVal!=null&&propVal.isCheck)
				this.cancelSelect(propVal)
			else if(propVal!=null)
				this.select(property,propVal)
			//属性点击后,判断每个属性下属性值是否可选
			for(var i=0;i<goods.propertys.length;i++){
				this._propertyFilter(goods.propertys[i],goods);
			}
			this.selectProduces=this.getProduces(goods.produces);
		}
}