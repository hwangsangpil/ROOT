package board.model;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.concurrent.locks.Lock;

import com.mysql.jdbc.Statement;

public class AdminDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public AdminDAO() throws SQLException {
		//conn = ConnectionUtil.getConnection(); //2015-12-07 ksy 湲곗〈
		super();
		//conn = ConnectionUtil.getConnection();
		try {
			Class.forName("com.mysql.jdbc.Driver");
		}catch(ClassNotFoundException e) {
			System.out.println("Class not found "+ e);
		}
		conn = DriverManager.getConnection("jdbc:mysql://localhost/hwangsangpil","hwangsangpil","hwangsangpil91");
		//conn = DriverManager.getConnection("jdbc:mysql://hwangsangpil.cafe24.com/hwangsangpil","hwangsangpil","hwangsangpil91");
	}
	public void closeConn() throws SQLException{
		  conn.close();
	}
	public static void closeAll (final Object... things) {
	    for (final Object thing : things) {
	        if (null != thing) {
	            try {
	                if (thing instanceof ResultSet) {
	                    try {
	                        ((ResultSet) thing).close ();
	                    } catch (final SQLException e) {
	                        /* No Op */
	                    }
	                }
	                if (thing instanceof Statement) {
	                    try {
	                        ((Statement) thing).close ();
	                    } catch (final SQLException e) {
	                        /* No Op */
	                    }
	                }
	                if (thing instanceof Connection) {
	                    try {
	                        ((Connection) thing).close ();
	                    } catch (final SQLException e) {
	                        /* No Op */
	                    }
	                }
	                if (thing instanceof Lock) {
	                    try {
	                        ((Lock) thing).unlock ();
	                    } catch (final IllegalMonitorStateException e) {
	                        /* No Op */
	                    }
	                }
	                if (thing instanceof PreparedStatement) {
	                    try {
	                        ((PreparedStatement) thing).close ();
	                    } catch (final SQLException e) {
	                        /* No Op */
	                    }
	                }
	            } catch (final RuntimeException e) {
	                /* No Op */
	            }
	        }
	    }
	}
	public ArrayList<AdminDTO> selectAdminList(String searchKeyword, int pageno, int totalcnt, String[] checked) throws SQLException {
		ArrayList<AdminDTO> list = new ArrayList<AdminDTO>();
		
		int nCnt = 1;
		int startRow =0;
		
		if(searchKeyword.length() <= 0){
			startRow = (pageno - 1) * 10;
		}
		if(searchKeyword.length() > 0 && totalcnt>10){
			if(((pageno -1) * 10) >= totalcnt){
				startRow = 0;
			}else{
				startRow = (pageno - 1) * 10;
			}
		}
		int endRow = 10;
		/*
		if(checked != null){
			for(int i=0; i<checked.length;i++){
			System.out.println("checked[]:    "+checked[i]);
			}
		}
		*/
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT SEQ_NO, ADMIN_ID, ADMIN_PW, ADMIN_NAME, ADMIN_PHONE, ADMIN_EMAIL, ADMIN_ROLE					\n");
		sql.append("	, date_format(CRT_DATE, '%Y.%m.%d') as CRT_DATE					\n");
		sql.append("	, date_format(UDT_DATE, '%Y.%m.%d') as UDT_DATE					\n");
		sql.append("FROM TB_ADMIN 														\n");
		sql.append("WHERE DEL_YN <> 'Y' 														\n");
		if(checked != null){
			for(int i=0; i<checked.length; i++){
				if(checked[i].equals("1")){
					sql.append("AND ADMIN_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("2")){
					sql.append("AND ADMIN_ID LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("3")){
					sql.append("AND ADMIN_EMAIL LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("4")){
					sql.append("AND ADMIN_PHONE LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("5")){
					sql.append("AND ADMIN_ROLE LIKE CONCAT('%',?,'%')			\n");
				}
			}	
		}else if(searchKeyword.length() > 0){
			sql.append("AND (ADMIN_NAME LIKE CONCAT('%',?,'%')		\n");
			sql.append("OR ADMIN_ID LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR ADMIN_EMAIL LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR ADMIN_PHONE LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR ADMIN_ROLE LIKE CONCAT('%',?,'%'))				\n");
		}
		sql.append("ORDER BY SEQ_NO DESC												\n");
		sql.append("LIMIT ?, ?															\n");
		
		try {
			pstmt = conn.prepareStatement(sql.toString());
			if(checked != null){
				for(int i=0; i<checked.length; i++){
					if(checked[i].equals("1")){
						pstmt.setString(nCnt++, searchKeyword);
					}
					if(checked[i].equals("2")){
						pstmt.setString(nCnt++, searchKeyword);
					}
					if(checked[i].equals("3")){
						pstmt.setString(nCnt++, searchKeyword);
					}
					if(checked[i].equals("4")){
						pstmt.setString(nCnt++, searchKeyword);
					}
					if(checked[i].equals("5")){
						pstmt.setString(nCnt++, searchKeyword);
					}
				}	
		}else if(searchKeyword.length() > 0){
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
			}
			pstmt.setInt(nCnt++, startRow);
			pstmt.setInt(nCnt, endRow);
			
			//System.out.println("Admin selectpstmt:   "+pstmt.toString());
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				AdminDTO dto = new AdminDTO();
				dto.setSeqNo(rs.getInt("SEQ_NO"));
				dto.setAdminId(rs.getString("ADMIN_ID"));
				dto.setAdminPw(rs.getString("ADMIN_PW"));
				dto.setAdminName(rs.getString("ADMIN_NAME"));
				dto.setAdminPhone(rs.getString("ADMIN_PHONE"));
				dto.setAdminEmail(rs.getString("ADMIN_EMAIL"));
				dto.setAdminRole(rs.getString("ADMIN_ROLE"));
				dto.setCrtDate(rs.getString("CRT_DATE"));
				dto.setUdtDate(rs.getString("UDT_DATE"));

				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		
		return list;
	}
	
	public ArrayList<AdminDTO> selectAdminDelList(String searchKeyword, int pageno, int totalcnt, String[] checked) throws SQLException {
		ArrayList<AdminDTO> list = new ArrayList<AdminDTO>();
		
		int nCnt = 1;
		int startRow =0;
		
		if(searchKeyword.length() <= 0){
			startRow = (pageno - 1) * 10;
		}
		if(searchKeyword.length() > 0 && totalcnt>10){
			if(((pageno -1) * 10) >= totalcnt){
				startRow = 0;
			}else{
				startRow = (pageno - 1) * 10;
			}
		}
		int endRow = 10;
		/*
		if(checked != null){
			for(int i=0; i<checked.length;i++){
			System.out.println("checked[]:    "+checked[i]);
			}
		}
		*/
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT SEQ_NO, ADMIN_ID, ADMIN_PW, ADMIN_NAME, ADMIN_PHONE, ADMIN_EMAIL, ADMIN_ROLE					\n");
		sql.append("	, date_format(CRT_DATE, '%Y.%m.%d') as CRT_DATE					\n");
		sql.append("	, date_format(UDT_DATE, '%Y.%m.%d') as UDT_DATE					\n");
		sql.append("FROM TB_ADMIN 														\n");
		sql.append("WHERE DEL_YN = 'Y' 														\n");
		if(checked != null){
			for(int i=0; i<checked.length; i++){
				if(checked[i].equals("1")){
					sql.append("AND ADMIN_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("2")){
					sql.append("AND ADMIN_ID LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("3")){
					sql.append("AND ADMIN_EMAIL LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("4")){
					sql.append("AND ADMIN_PHONE LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("5")){
					sql.append("AND ADMIN_ROLE LIKE CONCAT('%',?,'%')			\n");
				}
			}	
		}else if(searchKeyword.length() > 0){
			sql.append("AND (ADMIN_NAME LIKE CONCAT('%',?,'%')		\n");
			sql.append("OR ADMIN_ID LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR ADMIN_EMAIL LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR ADMIN_PHONE LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR ADMIN_ROLE LIKE CONCAT('%',?,'%'))				\n");
		}
		sql.append("ORDER BY SEQ_NO DESC												\n");
		sql.append("LIMIT ?, ?															\n");
		
		try {
			pstmt = conn.prepareStatement(sql.toString());
			if(checked != null){
				for(int i=0; i<checked.length; i++){
					if(checked[i].equals("1")){
						pstmt.setString(nCnt++, searchKeyword);
					}
					if(checked[i].equals("2")){
						pstmt.setString(nCnt++, searchKeyword);
					}
					if(checked[i].equals("3")){
						pstmt.setString(nCnt++, searchKeyword);
					}
					if(checked[i].equals("4")){
						pstmt.setString(nCnt++, searchKeyword);
					}
					if(checked[i].equals("5")){
						pstmt.setString(nCnt++, searchKeyword);
					}
				}	
		}else if(searchKeyword.length() > 0){
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
			}
			pstmt.setInt(nCnt++, startRow);
			pstmt.setInt(nCnt, endRow);
			
			//System.out.println("Admin selectpstmt:   "+pstmt.toString());
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				AdminDTO dto = new AdminDTO();
				dto.setSeqNo(rs.getInt("SEQ_NO"));
				dto.setAdminId(rs.getString("ADMIN_ID"));
				dto.setAdminPw(rs.getString("ADMIN_PW"));
				dto.setAdminName(rs.getString("ADMIN_NAME"));
				dto.setAdminPhone(rs.getString("ADMIN_PHONE"));
				dto.setAdminEmail(rs.getString("ADMIN_EMAIL"));
				dto.setAdminRole(rs.getString("ADMIN_ROLE"));
				dto.setCrtDate(rs.getString("CRT_DATE"));
				dto.setUdtDate(rs.getString("UDT_DATE"));

				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		
		return list;
	}
	

	public int cntTotalAdmin(String searchKeyword, String[] checked) throws SQLException {
		int result = 0;
		int cnt=0;
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT COUNT(*)	cnt										\n");
		sql.append("FROM TB_ADMIN 											\n");
		sql.append("WHERE DEL_YN <> 'Y' 														\n");
		if(checked != null){
			for(int i=0; i<checked.length; i++){
				if(checked[i].equals("1")){
					sql.append("AND ADMIN_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("2")){
					sql.append("AND ADMIN_ID LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("3")){
					sql.append("AND ADMIN_EMAIL LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("4")){
					sql.append("AND ADMIN_PHONE LIKE CONCAT('%',?,'%')			\n");
				}
			}	
		}else if(searchKeyword.length() > 0){
			sql.append("AND (ADMIN_NAME LIKE CONCAT('%',?,'%')		\n");
			sql.append("OR ADMIN_ID LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR ADMIN_EMAIL LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR ADMIN_PHONE LIKE CONCAT('%',?,'%'))				\n");
		}
		try {
			pstmt = conn.prepareStatement(sql.toString());
			if(checked != null){
				for(int i=0; i<checked.length; i++){
					if(checked[i].equals("1")){
						pstmt.setString(++cnt, searchKeyword);
					}
					if(checked[i].equals("2")){
						pstmt.setString(++cnt, searchKeyword);
					}
					if(checked[i].equals("3")){
						pstmt.setString(++cnt, searchKeyword);
					}
					if(checked[i].equals("4")){
						pstmt.setString(++cnt, searchKeyword);
					}
				}	
		}else if(searchKeyword.length() > 0){
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
			}
			//System.out.println("Admin Cnt selectpstmt:   "+pstmt.toString());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt("cnt");
			}
			//System.out.println("Admin Cnt result:  "+result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}

		return result;
	}

	public int cntTotalDelAdmin(String searchKeyword, String[] checked) throws SQLException {
		int result = 0;
		int cnt=0;
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT COUNT(*)	cnt										\n");
		sql.append("FROM TB_ADMIN 											\n");
		sql.append("WHERE DEL_YN = 'Y' 														\n");
		if(checked != null){
			for(int i=0; i<checked.length; i++){
				if(checked[i].equals("1")){
					sql.append("AND ADMIN_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("2")){
					sql.append("AND ADMIN_ID LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("3")){
					sql.append("AND ADMIN_EMAIL LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("4")){
					sql.append("AND ADMIN_PHONE LIKE CONCAT('%',?,'%')			\n");
				}
			}	
		}else if(searchKeyword.length() > 0){
			sql.append("AND (ADMIN_NAME LIKE CONCAT('%',?,'%')		\n");
			sql.append("OR ADMIN_ID LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR ADMIN_EMAIL LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR ADMIN_PHONE LIKE CONCAT('%',?,'%'))				\n");
		}
		try {
			pstmt = conn.prepareStatement(sql.toString());
			if(checked != null){
				for(int i=0; i<checked.length; i++){
					if(checked[i].equals("1")){
						pstmt.setString(++cnt, searchKeyword);
					}
					if(checked[i].equals("2")){
						pstmt.setString(++cnt, searchKeyword);
					}
					if(checked[i].equals("3")){
						pstmt.setString(++cnt, searchKeyword);
					}
					if(checked[i].equals("4")){
						pstmt.setString(++cnt, searchKeyword);
					}
				}	
		}else if(searchKeyword.length() > 0){
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
			}
			//System.out.println("Admin Cnt selectpstmt:   "+pstmt.toString());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt("cnt");
			}
			//System.out.println("Admin Cnt result:  "+result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}

		return result;
	}
	
	public AdminDTO selectAdminInfo(int no) throws SQLException {
		AdminDTO dto = new AdminDTO();

		StringBuffer sql = new StringBuffer();
		sql.append("SELECT SEQ_NO, ADMIN_ID, ADMIN_PW, ADMIN_NAME, ADMIN_PHONE, ADMIN_EMAIL, ADMIN_ROLE					\n");
		sql.append("	, date_format(CRT_DATE, '%Y.%m.%d') as CRT_DATE					\n");
		sql.append("	, date_format(UDT_DATE, '%Y.%m.%d') as UDT_DATE					\n");
		sql.append("FROM TB_ADMIN													\n");
		sql.append("WHERE SEQ_NO = ?														\n");
		
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, no);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setSeqNo(rs.getInt("SEQ_NO"));
				dto.setAdminId(rs.getString("ADMIN_ID"));
				dto.setAdminPw(rs.getString("ADMIN_PW"));
				dto.setAdminName(rs.getString("ADMIN_NAME"));
				dto.setAdminPhone(rs.getString("ADMIN_PHONE"));
				dto.setAdminEmail(rs.getString("ADMIN_EMAIL"));
				dto.setAdminRole(rs.getString("ADMIN_ROLE"));
				dto.setCrtDate(rs.getString("CRT_DATE"));
				dto.setUdtDate(rs.getString("UDT_DATE"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}

		return dto;
	}

	public int insertAdmin(String adminId, String adminPw,
			String adminName, String adminPhone, String adminEmail,
			String adminRole) throws SQLException {
		StringBuffer sql = new StringBuffer();
		int result = 0;

		sql.append("INSERT INTO TB_ADMIN(ADMIN_ID, ADMIN_PW, ADMIN_NAME, ADMIN_PHONE, ADMIN_EMAIL, ADMIN_ROLE			\n");
		sql.append("	, CRT_DATE)														\n");
		sql.append("	   SELECT ?, ?, ?, ?, ?, ?, now() FROM DUAL					\n");
		sql.append("WHERE NOT EXISTS(SELECT ADMIN_ID FROM TB_ADMIN WHERE ADMIN_ID=?)	\n");
		
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, adminId);
			pstmt.setString(2, adminPw);
			pstmt.setString(3, adminName);
			pstmt.setString(4, adminPhone);
			pstmt.setString(5, adminEmail);
			pstmt.setString(6, adminRole);
			pstmt.setString(7, adminId);

			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}

		return result;
	}

	public int updateAdmin(String adminId, String adminPw,
			String adminName, String adminPhone, String adminEmail,
			String adminRole, int no) throws SQLException {
		StringBuffer sql = new StringBuffer();
		int result = 0;
		sql.append("UPDATE TB_ADMIN														\n");
		sql.append("SET ADMIN_ID = ?, ADMIN_PW = ?, ADMIN_NAME = ?, ADMIN_PHONE = ?, ADMIN_EMAIL = ?, ADMIN_ROLE = ? 		\n");
		sql.append("	, UDT_DATE = now() 												\n");
		sql.append("WHERE SEQ_NO = ?													\n");
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, adminId);
			pstmt.setString(2, adminPw);
			pstmt.setString(3, adminName);
			pstmt.setString(4, adminPhone);
			pstmt.setString(5, adminEmail);
			pstmt.setString(6, adminRole);
			pstmt.setInt(7, no);

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}

		return result;
	}

	public int updateAdmin(String adminId, 
			String adminName, String adminPhone, String adminEmail,
			String adminRole, int no) throws SQLException {
		StringBuffer sql = new StringBuffer();
		int result = 0;
		sql.append("UPDATE TB_ADMIN														\n");
		sql.append("SET ADMIN_ID = ?, ADMIN_NAME = ?, ADMIN_PHONE = ?, ADMIN_EMAIL = ?, ADMIN_ROLE = ? 		\n");
		sql.append("	, UDT_DATE = now() 												\n");
		sql.append("WHERE SEQ_NO = ?													\n");
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, adminId);
			pstmt.setString(2, adminName);
			pstmt.setString(3, adminPhone);
			pstmt.setString(4, adminEmail);
			pstmt.setString(5, adminRole);
			pstmt.setInt(6, no);

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}

		return result;
	}
	
	public int deleteAdmin(int no) throws SQLException {
		StringBuffer sql = new StringBuffer();
		int result = 0;
		sql.append("UPDATE TB_ADMIN			\n");
		sql.append("SET DEL_YN = 'Y'			\n");
		sql.append("WHERE SEQ_NO = ?			\n");
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, no);

			result = pstmt.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}

		return result;
	}

	public int deleteAdmin2(int adminNum) throws SQLException {
		StringBuffer sql = new StringBuffer();
		int result = 0;
		sql.append("DELETE FROM TB_ADMIN			\n");
		sql.append("WHERE DEL_YN = 'Y'			\n");
		sql.append("AND SEQ_NO = ?			\n");
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, adminNum);

			result = pstmt.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}

		return result;
	}
	
	public int restoreAdmin(int adminNum) throws SQLException {
		StringBuffer sql = new StringBuffer();
		int result = 0;
		sql.append("UPDATE TB_ADMIN			\n");
		sql.append("SET DEL_YN = 'N'			\n");
		sql.append("WHERE SEQ_NO = ?			\n");
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, adminNum);

			result = pstmt.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}

		return result;
	}
	
	public AdminDTO loginAdmin(String adminId, String adminPw) throws SQLException {
		AdminDTO dto = new AdminDTO();

		StringBuffer sql = new StringBuffer();
		//System.out.println("id:"+adminId+"pw:"+adminPw);
		sql.append("SELECT SEQ_NO, ADMIN_ID, ADMIN_PW, ADMIN_ROLE 	\n");
		sql.append("FROM TB_ADMIN  								\n");
		sql.append("WHERE ADMIN_ID = ? AND ADMIN_PW = ? AND ADMIN_ROLE <> 4 AND DEL_YN='N'		\n");
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, adminId);
			pstmt.setString(2, adminPw);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setSeqNo(rs.getInt("SEQ_NO"));
				dto.setAdminRole(rs.getString("ADMIN_ROLE"));
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}

		return dto;
	}
	/*
	 * 2015-07-16 ksy 留ㅼ옣�슜 cms 濡쒓렇�씤
	 */

	public AdminDTO loginBranchCmsAdmin(String adminId, String adminPw) throws SQLException {
		AdminDTO dto = new AdminDTO();

		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT SEQ_NO, ADMIN_ID, ADMIN_PW, ADMIN_ROLE, ADMIN_BRANCH 	\n");
		sql.append("FROM TB_ADMIN  								\n");
		sql.append("WHERE ADMIN_ID = ? AND ADMIN_PW = ? AND ADMIN_ROLE = 4				\n");
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, adminId);
			pstmt.setString(2, adminPw);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setSeqNo(rs.getInt("SEQ_NO"));
				dto.setAdminRole(rs.getString("ADMIN_ROLE"));
				dto.setAdminBranch(rs.getString("ADMIN_BRANCH"));
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}

		return dto;
	}
	
	public ArrayList<AdminDTO> selectAdminListExcel(String searchKeyword, int pageno, int totalcnt, String[] checked) throws SQLException {
		ArrayList<AdminDTO> list = new ArrayList<AdminDTO>();
		
		int nCnt = 1;
		int startRow =0;
		
		if(searchKeyword.length() <= 0){
			startRow = (pageno - 1) * 10;
		}
		if(searchKeyword.length() > 0 && totalcnt>10){
			if(((pageno -1) * 10) >= totalcnt){
				startRow = 0;
			}else{
				startRow = (pageno - 1) * 10;
			}
		}
		int endRow = 10;
		/*
		if(checked != null){
			for(int i=0; i<checked.length;i++){
			System.out.println("checked[]:    "+checked[i]);
			}
		}
		*/
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT SEQ_NO, ADMIN_NAME, ADMIN_ID, ADMIN_EMAIL, ADMIN_PHONE, ADMIN_ROLE					\n");
		sql.append("	, date_format(CRT_DATE, '%Y.%m.%d') as CRT_DATE					\n");
		sql.append("	, date_format(UDT_DATE, '%Y.%m.%d') as UDT_DATE					\n");
		sql.append("FROM TB_ADMIN 														\n");
		sql.append("WHERE DEL_YN <> 'Y' 														\n");
		if(checked != null){
			for(int i=0; i<checked.length; i++){
				if(checked[i].equals("1")){
					sql.append("AND ADMIN_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("2")){
					sql.append("AND ADMIN_ID LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("3")){
					sql.append("AND ADMIN_EMAIL LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("4")){
					sql.append("AND ADMIN_PHONE LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("5")){
					sql.append("AND ADMIN_ROLE LIKE CONCAT('%',?,'%')			\n");
				}
			}	
		}else if(searchKeyword.length() > 0){
			sql.append("AND (ADMIN_NAME LIKE CONCAT('%',?,'%')		\n");
			sql.append("OR ADMIN_ID LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR ADMIN_EMAIL LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR ADMIN_PHONE LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR ADMIN_ROLE LIKE CONCAT('%',?,'%'))				\n");
		}
		sql.append("ORDER BY SEQ_NO DESC												\n");
		sql.append("LIMIT ?, ?															\n");
		
		try {
			pstmt = conn.prepareStatement(sql.toString());
			if(checked != null){
				for(int i=0; i<checked.length; i++){
					if(checked[i].equals("1")){
						pstmt.setString(nCnt++, searchKeyword);
					}
					if(checked[i].equals("2")){
						pstmt.setString(nCnt++, searchKeyword);
					}
					if(checked[i].equals("3")){
						pstmt.setString(nCnt++, searchKeyword);
					}
					if(checked[i].equals("4")){
						pstmt.setString(nCnt++, searchKeyword);
					}
					if(checked[i].equals("5")){
						pstmt.setString(nCnt++, searchKeyword);
					}
				}	
		}else if(searchKeyword.length() > 0){
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
			}
			pstmt.setInt(nCnt++, startRow);
			pstmt.setInt(nCnt, endRow);
			
			//System.out.println("Admin selectpstmt:   "+pstmt.toString());
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				AdminDTO dto = new AdminDTO();
				dto.setSeqNo(rs.getInt("SEQ_NO"));
				dto.setAdminName(rs.getString("ADMIN_NAME"));
				dto.setAdminId(rs.getString("ADMIN_ID"));
				dto.setAdminEmail(rs.getString("ADMIN_EMAIL"));
				dto.setAdminPhone(rs.getString("ADMIN_PHONE"));
				dto.setAdminRole(rs.getString("ADMIN_ROLE"));
				dto.setCrtDate(rs.getString("CRT_DATE"));
				dto.setUdtDate(rs.getString("UDT_DATE"));

				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		
		return list;
	}
}
