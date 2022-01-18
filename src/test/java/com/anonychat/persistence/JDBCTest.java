package com.anonychat.persistence;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTest {
	static {
		
		try {
			Class.forName("oracle.driver.OracleDriver");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}	
	
	@Test
	public void getConnection() {
		
		Connection conn = null;
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "chat";
		String pw = "1234";
		try {
			conn = DriverManager.getConnection(url, id, pw);
			log.info(conn);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
		
}