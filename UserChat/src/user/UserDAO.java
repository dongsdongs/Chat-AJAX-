package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.InitialContext;


public class UserDAO {
	//datapull을 위해서
	javax.sql.DataSource dataSource;
	
	public UserDAO() {
		try {
			InitialContext initContext = new InitialContext();
			javax.naming.Context envContext = (javax.naming.Context)initContext.lookup("java:/comp/env");
			dataSource = (javax.sql.DataSource)envContext.lookup("jdbc/UserChat");
		}catch(Exception e){
			
		}
	}
	
	public int login(String userID, String userPassword) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM USER where userID = ? ";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, userID);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("userPassword").equals(userPassword)) {
					return 1;	
				}
				return 2; //비밀번호가 틀림
			}else {
				return 0; // 사용자 존재 X
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	
	public int registerCheck(String userID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM USER where userID = ? ";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs= pstmt.executeQuery();
			if(rs.next() || userID.equals("")) {
				return 0; //이미 존재하는 회웡
			}else {
				return 1; //회원가입 가능
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	
	public int register(String userID, String userPassword, String userName, String userAge, String userGender, String userEmail, String userProfile) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "insert into user values (?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			pstmt.setString(3, userName);
			pstmt.setInt(4, Integer.parseInt(userAge));
			pstmt.setString(5, userGender);
			pstmt.setString(6, userEmail);
			pstmt.setString(7, userProfile);
			return pstmt.executeUpdate();
			/*rs= pstmt.executeQuery();
			if(rs.next() || userID.equals("")) {
				return 0; //이미 존재하는 회웡
			}else {
				return 1; //회원가입 가능
			}*/
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				/*if(rs!=null) rs.close();*/
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	
	
	
}
