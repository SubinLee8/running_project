package com.itwill.running.service;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/application-context.xml" } )
public class RedisServiceTest {
	@Autowired
	private RedisService redisService;

	//@Test
	public void testRedis() {
		//redisService.saveData("testKey2", "WHATIF?");
		//System.out.println(redisService.getData("testKey")); // "Hello Redis!"
	}

}
