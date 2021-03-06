package com.itheima.bos.dao.base.impl;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.itheima.bos.dao.base.IBaseDao;

/**
 * 持久层通用实现类
 * @author sky
 *
 * @param <T>
 */
public class BaseDaoImpl<T> extends HibernateDaoSupport implements IBaseDao<T> {
	
	/**
	 * 代表的是某个实体的类型
	 */
	private Class<T> entityClass;
	
	/**
	 * 在父类BaseDaoImpl的构造方法中获得entityClass
	 */
	public BaseDaoImpl() {
		ParameterizedType superclass = (ParameterizedType) this.getClass().getGenericSuperclass();
		//获得父类上声明的泛型数组
		Type[] actualTypeArguments = superclass.getActualTypeArguments();
		//取出
		entityClass = (Class<T>) actualTypeArguments[0];
	}
	
	/**
	 * 根据类型注入spring工厂中的会话工厂对象sessionFactory
	 * @param sessionFactory
	 */
	@Resource
	public void setMySessionFactory(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}

	@Override
	public void save(T entity) {
		this.getHibernateTemplate().save(entity);
		
	}

	@Override
	public void delete(T entity) {
		this.getHibernateTemplate().delete(entity);
		
	}

	@Override
	public void update(T entity) {
		this.getHibernateTemplate().update(entity);
		
	}

	@Override
	public T findById(Serializable id) {
		return this.getHibernateTemplate().get(entityClass, id);
	}

	@Override
	public List<T> findAll() {
		String hql = "FROM" + entityClass.getSimpleName();
		return (List<T>) this.getHibernateTemplate().find(hql);
	}

}
