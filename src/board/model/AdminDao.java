package board.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.concurrent.locks.Lock;

import com.mysql.jdbc.Statement;

public class AdminDao {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public AdminDao() throws SQLException {
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
	public ArrayList<AdminVO> selectAdminList(String searchKeyword, int pageno, int totalcnt, String[] checked) throws SQLException {
		ArrayList<AdminVO> list = new ArrayList<AdminVO>();
		
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
			}	
		}else if(searchKeyword.length() > 0){
			sql.append("AND (ADMIN_NAME LIKE CONCAT('%',?,'%')		\n");
			sql.append("OR ADMIN_ID LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR ADMIN_EMAIL LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR ADMIN_PHONE LIKE CONCAT('%',?,'%'))				\n");
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
				}	
		}else if(searchKeyword.length() > 0){
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
				AdminVO vo = new AdminVO();
				vo.setSeqNo(rs.getInt("SEQ_NO"));
				vo.setAdminId(rs.getString("ADMIN_ID"));
				vo.setAdminPw(rs.getString("ADMIN_PW"));
				vo.setAdminName(rs.getString("ADMIN_NAME"));
				vo.setAdminPhone(rs.getString("ADMIN_PHONE"));
				vo.setAdminEmail(rs.getString("ADMIN_EMAIL"));
				vo.setAdminRole(rs.getInt("ADMIN_ROLE"));
				vo.setCrtDate(rs.getString("CRT_DATE"));
				vo.setUdtDate(rs.getString("UDT_DATE"));

				list.add(vo);
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

	public AdminVO selectAdminInfo(int no) throws SQLException {
		AdminVO vo = new AdminVO();

		StringBuffer sql = new StringBuffer();
		sql.append("SELECT SEQ_NO, ADMIN_ID, ADMIN_PW, ADMIN_NAME, ADMIN_PHONE, ADMIN_EMAIL, ADMIN_ROLE					\n");
		sql.append("	, date_format(CRT_DATE, '%Y.%m.%d') as CRT_DATE					\n");
		sql.append("	, date_format(UDT_DATE, '%Y.%m.%d') as UDT_DATE					\n");
		sql.append("	, ADMIN_BRANCH					\n");
		sql.append("FROM TB_ADMIN													\n");
		sql.append("WHERE SEQ_NO = ?														\n");
		
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, no);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo.setSeqNo(rs.getInt("SEQ_NO"));
				vo.setAdminId(rs.getString("ADMIN_ID"));
				vo.setAdminPw(rs.getString("ADMIN_PW"));
				vo.setAdminName(rs.getString("ADMIN_NAME"));
				vo.setAdminPhone(rs.getString("ADMIN_PHONE"));
				vo.setAdminEmail(rs.getString("ADMIN_EMAIL"));
				vo.setAdminRole(rs.getInt("ADMIN_ROLE"));
				vo.setCrtDate(rs.getString("CRT_DATE"));
				vo.setUdtDate(rs.getString("UDT_DATE"));
				vo.setAdminBranch(rs.getString("ADMIN_BRANCH"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}

		return vo;
	}

	public int insertAdmin(String adminId, String adminPw,
			String adminName, String adminPhone, String adminEmail,
			int adminRole, String branchCode) throws SQLException {
		StringBuffer sql = new StringBuffer();
		int result = 0;

		sql.append("INSERT INTO TB_ADMIN(ADMIN_ID, ADMIN_PW, ADMIN_NAME, ADMIN_PHONE, ADMIN_EMAIL, ADMIN_ROLE, ADMIN_BRANCH			\n");
		sql.append("	, CRT_DATE)														\n");
		sql.append("	   SELECT ?, ?, ?, ?, ?, ?, ?, now() FROM DUAL					\n");
		sql.append("WHERE NOT EXISTS(SELECT ADMIN_ID FROM TB_ADMIN WHERE ADMIN_ID=?)	\n");
		
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, adminId);
			pstmt.setString(2, adminPw);
			pstmt.setString(3, adminName);
			pstmt.setString(4, adminPhone);
			pstmt.setString(5, adminEmail);
			pstmt.setInt(6, adminRole);
			pstmt.setString(7, branchCode);
			pstmt.setString(8, adminId);

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
			int adminRole, int no, String branchCode) throws SQLException {
		StringBuffer sql = new StringBuffer();
		int result = 0;
		sql.append("UPDATE TB_ADMIN														\n");
		sql.append("SET ADMIN_ID = ?, ADMIN_PW = ?, ADMIN_NAME = ?, ADMIN_PHONE = ?, ADMIN_EMAIL = ?, ADMIN_ROLE = ?, ADMIN_BRANCH = ? 		\n");
		sql.append("	, UDT_DATE = now() 												\n");
		sql.append("WHERE SEQ_NO = ?													\n");
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, adminId);
			pstmt.setString(2, adminPw);
			pstmt.setString(3, adminName);
			pstmt.setString(4, adminPhone);
			pstmt.setString(5, adminEmail);
			pstmt.setInt(6, adminRole);
			pstmt.setString(7, branchCode);
			pstmt.setInt(8, no);

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
			int adminRole, int no, String branchCode) throws SQLException {
		StringBuffer sql = new StringBuffer();
		int result = 0;
		sql.append("UPDATE TB_ADMIN														\n");
		sql.append("SET ADMIN_ID = ?, ADMIN_NAME = ?, ADMIN_PHONE = ?, ADMIN_EMAIL = ?, ADMIN_ROLE = ?, ADMIN_BRANCH = ? 		\n");
		sql.append("	, UDT_DATE = now() 												\n");
		sql.append("WHERE SEQ_NO = ?													\n");
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, adminId);
			pstmt.setString(2, adminName);
			pstmt.setString(3, adminPhone);
			pstmt.setString(4, adminEmail);
			pstmt.setInt(5, adminRole);
			pstmt.setString(6, branchCode);
			pstmt.setInt(7, no);

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

	public AdminVO loginAdmin(String adminId, String adminPw) throws SQLException {
		AdminVO vo = new AdminVO();

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
				vo.setSeqNo(rs.getInt("SEQ_NO"));
				vo.setAdminRole(rs.getInt("ADMIN_ROLE"));
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}

		return vo;
	}
	/*
	 * 2015-07-16 ksy 留ㅼ옣�슜 cms 濡쒓렇�씤
	 */

	public AdminVO loginBranchCmsAdmin(String adminId, String adminPw) throws SQLException {
		AdminVO vo = new AdminVO();

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
				vo.setSeqNo(rs.getInt("SEQ_NO"));
				vo.setAdminRole(rs.getInt("ADMIN_ROLE"));
				vo.setAdminBranch(rs.getString("ADMIN_BRANCH"));
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}

		return vo;
	}
	
	public ArrayList<AdminVO> selectAdminListExcel(String searchKeyword, int pageno, int totalcnt, String[] checked) throws SQLException {
		ArrayList<AdminVO> list = new ArrayList<AdminVO>();
		
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

		sql.append("SELECT SEQ_NO, ADMIN_NAME, ADMIN_ID, ADMIN_EMAIL, ADMIN_PHONE					\n");
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
			}	
		}else if(searchKeyword.length() > 0){
			sql.append("AND (ADMIN_NAME LIKE CONCAT('%',?,'%')		\n");
			sql.append("OR ADMIN_ID LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR ADMIN_EMAIL LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR ADMIN_PHONE LIKE CONCAT('%',?,'%'))				\n");
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
				}	
		}else if(searchKeyword.length() > 0){
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
				AdminVO vo = new AdminVO();
				vo.setSeqNo(rs.getInt("SEQ_NO"));
				vo.setAdminName(rs.getString("ADMIN_NAME"));
				vo.setAdminId(rs.getString("ADMIN_ID"));
				vo.setAdminEmail(rs.getString("ADMIN_EMAIL"));
				vo.setAdminPhone(rs.getString("ADMIN_PHONE"));
				vo.setCrtDate(rs.getString("CRT_DATE"));
				vo.setUdtDate(rs.getString("UDT_DATE"));

				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		
		return list;
	}
}
