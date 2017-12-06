package com.chinazhoufan.admin.common.redis;

import org.redisson.Redisson;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.redisson.config.Config;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.io.IOException;
import java.util.concurrent.TimeUnit;

/**
 * Created by sxj on 2017/7/31.
 */
@Component
public class RedissonUtil {

    private static final String LOCK_TITLE = "redisLock_";

    @Autowired
    private RedissonClient redissonClient;

    public RLock getLock(String lockName){
        return redissonClient.getLock(LOCK_TITLE+lockName);
    }

}
