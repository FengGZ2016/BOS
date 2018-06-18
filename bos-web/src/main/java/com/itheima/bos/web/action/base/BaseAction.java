package com.itheima.bos.web.action.base;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 表现层通用实现
 * @author sky
 *
 */
public class BaseAction<T> extends ActionSupport implements  ModelDriven<T>{

	//模型对象
	private T model;
	
	/**
	 * 在构造方法中动态获取实体对象类型，再通过反射创建model对象
	 */
	public BaseAction() {
		ParameterizedType superclass = (ParameterizedType) this.getClass().getGenericSuperclass();
		//获取父类上声明的泛型数组
		Type[] actualTypeArguments = superclass.getActualTypeArguments();
		//取出其中的一个
		Class<T> entityClass = (Class<T>) actualTypeArguments[0];
		
		//通过反射创建model对象
		try {
			model = entityClass.newInstance();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Override
	public T getModel() {
		return model;
	}

}
