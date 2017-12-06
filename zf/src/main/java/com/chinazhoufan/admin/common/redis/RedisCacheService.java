package com.chinazhoufan.admin.common.redis;

import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.serializer.RedisSerializer;
import org.springframework.stereotype.Service;

import com.chinazhoufan.admin.common.persistence.BaseEntity;
import com.chinazhoufan.admin.common.warning.exception.RedisPingException;
import com.chinazhoufan.admin.common.warning.exception.RedisSelectException;
import com.google.common.collect.Lists;

/**
 * @author  杨晓辉
 * @date 创建时间：2016年8月13日 上午9:48:26 
 * @version 2.0.0 
 */
//保持为service 方便事务控制,String类型key和配置文件序列化器保持一致
@Service
@SuppressWarnings("hiding")
public class RedisCacheService<K,V> {
	
	public static final String REDIS_ERROR_STR	= "-1";
	public static final long REDIS_ERROR_LONG	= -1;
	
	/**手持端用户loginName缓存标记（以“字符串_loginName”为key，保存用户会话的sessionID。当loginName再次登录时，删除之前的sessionID,生成新的sessionID并缓存，用以实现单点登录）**/
	public static final String MOBILE_LOGINNAME	= "MOBILE_LOGINNAME_%S";
	/**手持端用户session缓存标记（以“字符串_sessionID”为key，保存登录用户的UserDTO。拦截器验证判断时使用，用以维持手持端回话）**/
	public static final String MOBILE_SESSION	= "MOBILE_SESSION_%S";
	/** 业务参数Config的缓存key，Config新增修改时更新或清除缓存 */
	public static final String CONFIG_MAP_KEY = "configMap";
	/** zf-index项目缓存的区域Area的key，Area新增修改时更新或清除缓存 */
	public static final String AREA_LIST_KEY = "areaList";
	
	protected transient Log logger = LogFactory.getLog(getClass());
	
	@Autowired(required=false)
	@Qualifier("redisTemplate")
	public RedisTemplate<K, V> redisTemplate;
	
	
	/**
	 * 根据Key删除缓存对象
	 * @param keys
	 * @return
	 */
	public long del(final K... keys) throws RedisPingException,DataAccessException{
		return redisTemplate.execute(new RedisCallback<Long>() {
            public Long doInRedis(RedisConnection connection) throws DataAccessException {
                long result = 0;
                RedisSerializer<K> keySerializer=(RedisSerializer<K>) redisTemplate.getKeySerializer();
                for (int i = 0; i < keys.length; i++) {
                    result = connection.del(keySerializer.serialize(keys[i]));
                }
                return result;
            }
        });
	}
	
	/**
	 * 更新失效时间
	 * @param k 
	 * @param liveTime
	 * @return
	 * @throws RedisPingException
	 * @throws DataAccessException
	 */
	public String updateLiveTime(final K k,final long liveTime)throws RedisPingException,DataAccessException{
		if(liveTime<=0)
			return BaseEntity.FALSE_FLAG;
		return redisTemplate.execute(new RedisCallback<String>() {
            public String doInRedis(RedisConnection connection) throws DataAccessException {
            	RedisSerializer<K> keySerializer=(RedisSerializer<K>) redisTemplate.getKeySerializer();
                connection.expire(keySerializer.serialize(k), liveTime);
				return BaseEntity.TRUE_FLAG;
            }
        });
	}
	
	/**
	 * 保存字符串类型缓存
	 * @param key
	 * @param val
	 * @param liveTime 失效时间 ，单位秒
	 * @return
	 * @throws RedisPingException
	 * @throws DataAccessException
	 */
	public String setStr(final String key,final String val, final long liveTime)throws RedisPingException,DataAccessException{
		if(liveTime<=0)
			return BaseEntity.FALSE_FLAG;
		return redisTemplate.execute(new RedisCallback<String>() {
            public String doInRedis(RedisConnection connection) throws DataAccessException {
                connection.set(key.getBytes(), val.getBytes());
                connection.expire(key.getBytes(), liveTime);
				return BaseEntity.TRUE_FLAG;
            }
        });
	}
	
	/**
	 * 保存字符串类型缓存
	 * @param key
	 * @param val
	 * @return
	 * @throws RedisPingException
	 * @throws DataAccessException
	 */
	public String setStr(final String key,final String val)throws RedisPingException,DataAccessException{
		return redisTemplate.execute(new RedisCallback<String>() {
            public String doInRedis(RedisConnection connection) throws DataAccessException {
                connection.set(key.getBytes(), val.getBytes());
				return BaseEntity.TRUE_FLAG;
            }
        });
	}
	
	/**
	 * 根据key获取缓存
	 * @param key
	 * @return
	 */
	public String getStr(final String key) throws RedisPingException,DataAccessException {
		return redisTemplate.execute(new RedisCallback<String>() {
            public String doInRedis(RedisConnection connection) throws DataAccessException {
            	return (String)redisTemplate.getStringSerializer().deserialize(connection.get(key.getBytes()));
            }
        });
	}
	
	/**
	 * 保存缓存，并设置存活时间
	 * @param key
	 * @param v
	 * @param liveTime 单位秒
	 */
	public String set(final K key,final V v, final long liveTime)throws RedisPingException,DataAccessException{
		if(liveTime<=0)
			return BaseEntity.FALSE_FLAG;
		return redisTemplate.execute(new RedisCallback<String>() {
            public String doInRedis(RedisConnection connection) throws DataAccessException {
            	RedisSerializer<K> keySerializer=(RedisSerializer<K>) redisTemplate.getKeySerializer();
    			RedisSerializer<V> valSerializer=(RedisSerializer<V>) redisTemplate.getValueSerializer();
            	byte[] byteK=keySerializer.serialize(key);
                connection.set(byteK, valSerializer.serialize(v));
                connection.expire(byteK, liveTime);
				return BaseEntity.TRUE_FLAG;
            }
        });
		
	}
	
	/**
	 * 保存缓存
	 * @param key
	 * @param v
	 */
	public String set(final K key,final V v) throws RedisPingException,DataAccessException{
		return redisTemplate.execute(new RedisCallback<String>() {
            public String doInRedis(RedisConnection connection) throws DataAccessException {
            	RedisSerializer<K> keySerializer=(RedisSerializer<K>) redisTemplate.getKeySerializer();
    			RedisSerializer<V> valSerializer=(RedisSerializer<V>) redisTemplate.getValueSerializer();
            	byte[] byteK=keySerializer.serialize(key);
                connection.set(byteK, valSerializer.serialize(v));
				return BaseEntity.TRUE_FLAG;
            }
        });
	}
	
	/**
	 * 根据key获取缓存
	 * @param key
	 * @return
	 */
	public V get(final K key) throws RedisPingException,DataAccessException {
		return redisTemplate.execute(new RedisCallback<V>() {
            public V doInRedis(RedisConnection connection) throws DataAccessException {
            	
            	RedisSerializer<K> keySerializer=(RedisSerializer<K>) redisTemplate.getKeySerializer();
            	byte[] bytes= keySerializer.serialize(key);
            	bytes= connection.get(bytes);
            	V v=(V)redisTemplate.getValueSerializer().deserialize(bytes);
            	return v;
            }
        });
	}
	
	/**
	 * 判断key是否存在
	 * @param key
	 * @return
	 */
	public boolean exists(final K key) throws RedisPingException,DataAccessException{
		return redisTemplate.execute(new RedisCallback<Boolean>() {
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
            	RedisSerializer<K> keySerializer=(RedisSerializer<K>) redisTemplate.getKeySerializer();
                return connection.exists(keySerializer.serialize(key));
            }
        });
	}
	
	/**
	 * 清空redis所有数据
	 * @return 
	 * @return
	 */
	public String flushDB() {
		if(REDIS_ERROR_STR.equals(ping()))
			return BaseEntity.FALSE_FLAG;
		return redisTemplate.execute(new RedisCallback<String>(){
            public String doInRedis(RedisConnection connection) throws DataAccessException {
				try{
					connection.flushDb();
					return BaseEntity.TRUE_FLAG;
            	}catch(DataAccessException d){
            		logger.error("redis server is close");
        			d.printStackTrace();
        			return BaseEntity.FALSE_FLAG;
            	}
            }
        });
		
	}
	
	/**
	 * 查看redis有多少数据
	 * @return -1代表 error
	 */
	public long dbSize(){
		if(REDIS_ERROR_STR.equals(ping()))
			return REDIS_ERROR_LONG;
		return redisTemplate.execute(new RedisCallback<Long>() {
            public Long doInRedis(RedisConnection connection){
                try{
                	return connection.dbSize();
            	}catch(DataAccessException d){
            		logger.error("redis server is close");
        			d.printStackTrace();
        			return REDIS_ERROR_LONG;
            	}
            }
        });
	}
	
	/**
	 * 检查是否连接成功
	 * @return -1代表异常
	 */
	public String ping() throws RedisPingException{
		String ping=redisTemplate.execute(new RedisCallback<String>() {
            public String doInRedis(RedisConnection connection) {
            	try{
            		return connection.ping();
            	}catch(DataAccessException d){
            		logger.error("redis server is close");
        			d.printStackTrace();
        			return BaseEntity.FALSE_FLAG;
            	}catch(Exception e){
            		logger.error("redis ping error");
            		e.printStackTrace();
            		return BaseEntity.FALSE_FLAG;
            	}
            }
        });
		System.out.println("[redis] redis ping is "+ping);
//		if(StringUtils.isEmpty(ping)||BaseEntity.FALSE_FLAG.equals(ping))
//			throw new RedisPingException("exists error by redis ping is error,connection is null");
		return ping;
	}
	
	/**
	 * 切换redis 缓存库
	 * @param dbIndex   			缓存库标记
	 * @return
	 * @throws RedisPingException
	 */
	public void select(final int dbIndex) throws RedisSelectException{
		redisTemplate.execute(new RedisCallback<String>() {
            public String doInRedis(RedisConnection connection) {
            	try{
            		connection.select(dbIndex);
            		return BaseEntity.TRUE_FLAG;
            	}catch(Exception e){
            		e.getStackTrace();
            		throw new RedisSelectException("redis cache select db"+dbIndex+" error");
            	}
            }
        });
	}
	
	/**
	 * 根据正则匹配对应的key
	 * @param pattern   			正则
	 * @return
	 * @throws RedisPingException
	 */
	public List<K> keys(final String pattern) throws DataAccessException{
		return redisTemplate.execute(new RedisCallback<List<K>>() {
            public List<K> doInRedis(RedisConnection connection) {
            	RedisSerializer<String> strSerializer=redisTemplate.getStringSerializer();
            	Set<byte[]> keys=connection.keys(strSerializer.serialize(pattern));
            	RedisSerializer<K> keySerializer=(RedisSerializer<K>) redisTemplate.getKeySerializer();
            	Iterator<byte[]> iterator= keys.iterator();
            	List<K> list=Lists.newArrayList();
            	while (iterator.hasNext()) {
            		byte[] key = iterator.next();
            		keySerializer.deserialize(key);
            		list.add(keySerializer.deserialize(key));
				}
        		return list;
            }
        });
	}
}
