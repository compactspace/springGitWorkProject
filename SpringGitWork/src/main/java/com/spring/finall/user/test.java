package com.spring.finall.user;

import org.mindrot.jbcrypt.BCrypt;

//여기는 각종 문법 테스트 용도 메인 클레스 임
public class test {

	public static void main(String[] args) {
//		 HashMap<String, Integer> map = new HashMap<>();
//	        map.put("A", 3);
//	        map.put("B", 4); // map에 Key, Value 삽입
//
//	        System.out.println("map->>>"+map);
//	        
//	        for(HashMap<String, Integer> x : map) {
//	            System.out.println("entry.getKey() : " + entry.getKey());
//	            System.out.println("entry.getvalue() : " + entry.getValue());
//	        }
//	        
//	        
//	        
//	        
//	        
//	        System.out.println("map.entrySet()->>>"+map.entrySet());
//	        for(Map.Entry<String, Integer> entry : map.entrySet()) {
//	            System.out.println("entry.getKey() : " + entry.getKey());
//	            System.out.println("entry.getvalue() : " + entry.getValue());
//	        }
//	        
//	        HashSet<String> hset = new HashSet<String>(); 
//	        hset.add("d");
//	        System.out.println(hset);
//
////	        System.out.println( map.entrySet().stream()
////	                                          .map(Map.Entry<String, Integer>::getKey)
////	                                          .collect(Collectors.toList())
////	                          );
//
//	}
//암호
		String pw1 = BCrypt.hashpw("12345", BCrypt.gensalt());
		System.out.println(pw1);
		String pw2 = BCrypt.hashpw("12345", BCrypt.gensalt());
		System.out.println(pw2);
		
		
}
	
}
