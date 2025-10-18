//package com.spring.finall.view.controller;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.data.redis.core.RedisTemplate;
//import org.springframework.data.redis.serializer.StringRedisSerializer;
//
//@Configuration
//public class RedisTemple {
//	
//	@Bean
//	  public RedisTemplate<?, ?> redisTemplate() {
//	    RedisTemplate<?, ?> redisTemplate = new RedisTemplate<>();
//	    redisTemplate.setConnectionFactory(redisConnectionFactory());
//	    redisTemplate.setKeySerializer(new StringRedisSerializer());
//	    redisTemplate.setValueSerializer(new StringRedisSerializer());
//	    return redisTemplate;
//	  }
//	
//
//}
