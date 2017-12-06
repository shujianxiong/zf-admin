package com.chinazhoufan.admin.test.service;

import com.zf.quartzSDK.event.TaskEvent;
import com.zf.quartzSDK.listener.AbstractTaskListener;
import org.springframework.stereotype.Service;

@Service
public class Test1 extends AbstractTaskListener {
    public void doTask(TaskEvent event) {
        System.out.println("test1 get");
    }
}
