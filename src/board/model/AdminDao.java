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
		//conn = DriverManager.getConnection("jdbc:mysql://localhost/hwangsangpil","hwangsangpil","hwangsangpil91");
		conn = DriverManager.getConnection("jdbc:mysql://hwangsangpil.cafe24.com/hwangsangpil","hwangsangpil","hwangsangpil91");
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
	public ArrayList<AdminVO> selectAdminList(String searchKeyword, int pageno) throws SQLException {
		ArrayList<AdminVO> list = new ArrayList<AdminVO>();
		
		int nCnt = 1;
		int startRow = (pageno - 1) * 10;
		int endRow = 10;

		StringBuffer sql = new StringBuffer();

		sql.append("SELECT SEQ_NO, ADMIN_ID, ADMIN_PW, ADMIN_NAME, ADMIN_PHONE, ADMIN_EMAIL, ADMIN_ROLE					\n");
		sql.append("	, date_format(CRT_DATE, '%Y.%m.%d') as CRT_DATE					\n");
		sql.append("	, date_format(UDT_DATE, '%Y.%m.%d') as UDT_DATE					\n");
		sql.append("FROM TB_ADMIN 														\n");
		sql.append("WHERE DEL_YN <> 'Y' 														\n");
		if(searchKeyword.length() > 0){
			sql.append("AND ( ADMIN_ID LIKE CONCAT('%',?,'%')  OR ADMIN_NAME LIKE CONCAT('%',?,'%')  OR ADMIN_PHONE LIKE CONCAT('%',?,'%')  OR ADMIN_EMAIL LIKE CONCAT('%',?,'%') )		\n");
		}
		sql.append("ORDER BY SEQ_NO DESC												\n");
		sql.append("LIMIT ?, ?															\n");
		
		try {
			pstmt = conn.prepareStatement(sql.toString());
			if(searchKeyword.length() > 0){
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
			}
			pstmt.setInt(nCnt++, startRow);
			pstmt.setInt(nCnt, endRow);

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
			/*if (rs != null){
				rs.close();
			}
			if (pstmt != null){
				pstmt.close();
			}
			if (conn != null){
				conn.close();
			}*/
		}
		
		return list;
	}

	public int cntTotalAdmin() throws SQLException {
		int result = 0;
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT COUNT(*)	cnt										\n");
		sql.append("FROM TB_ADMIN 											\n");
		sql.append("WHERE DEL_YN <> 'Y' 														\n");
		
		try {
			pstmt = conn.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt("cnt");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
			/*if (rs != null){
				rs.close();
			}
			if (pstmt != null){
				pstmt.close();
			}
			if (conn != null){
				conn.close();
			}*/
		}

		return result;
	}

	public AdminVO selectAdminInfo(int no) throws SQLException {
		AdminVO vo = new AdminVO();

		StringBuffer sql = new StringBuffer();
		sql.append("SELECT a.SEQ_NO, ADMIN_ID, ADMIN_PW, ADMIN_NAME, ADMIN_PHONE, ADMIN_EMAIL, ADMIN_ROLE					\n");
		sql.append("	, date_format(CRT_DATE, '%Y.%m.%d') as CRT_DATE					\n");
		sql.append("	, date_format(UDT_DATE, '%Y.%m.%d') as UDT_DATE					\n");
		sql.append("	, BRANCH_NM, ADMIN_BRANCH					\n");
		sql.append("FROM TB_ADMIN a, RPT_BRANCH b														\n");
		sql.append("WHERE a.SEQ_NO = ? AND a.ADMIN_BRANCH = b.BRANCH														\n");
		
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
				StoreVO svo = vo.getStoreVo();
				svo.setBranchName(rs.getString("BRANCH_NM"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
			/*if (rs != null){
				rs.close();
			}
			if (pstmt != null){
				pstmt.close();
			}
			if (conn != null){
				conn.close();
			}*/
		}

		return vo;
	}

	public int insertAdmin(String adminId, String adminPw,
			String adminName, String adminPhone, String adminEmail,
			int adminRole, String branchCode) throws SQLException {
		StringBuffer sql = new StringBuffer();
		int result = 0;
		sql.append("INSERT INTO TB_ADMIN(ADMIN_ID, ADMIN_PW, ADMIN_NAME, ADMIN_PHONE, ADMIN_EMAIL, ADMIN_ROLE, ADMIN_BRANCH			\n");
		sql.append("	, CRT_DATE, UDT_DATE)										\n");
		sql.append("	   VALUES(?, ?, ?, ?, ?, ?, ?, now(), now()) 					\n");
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, adminId);
			pstmt.setString(2, adminPw);
			pstmt.setString(3, adminName);
			pstmt.setString(4, adminPhone);
			pstmt.setString(5, adminEmail);
			pstmt.setInt(6, adminRole);
			pstmt.setString(7, branchCode);

			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
			/*if (rs != null){
				rs.close();
			}
			if (pstmt != null){
				pstmt.close();
			}
			if (conn != null){
				conn.close();
			}*/
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
			/*if (rs != null){
				rs.close();
			}
			if (pstmt != null){
				pstmt.close();
			}
			if (conn != null){
				conn.close();
			}*/
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
			/*if (rs != null){
				rs.close();
			}
			if (pstmt != null){
				pstmt.close();
			}
			if (conn != null){
				conn.close();
			}*/
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
			/*if (rs != null){
				rs.close();
			}
			if (pstmt != null){
				pstmt.close();
			}
			if (conn != null){
				conn.close();
			}*/
		}

		return result;
	}

	public AdminVO loginAdmin(String adminId, String adminPw) throws SQLException {
		AdminVO vo = new AdminVO();

		StringBuffer sql = new StringBuffer();
		//System.out.println("id:"+adminId+"pw:"+adminPw);
		sql.append("SELECT SEQ_NO, ADMIN_ID, ADMIN_PW, ADMIN_ROLE 	\n");
		sql.append("FROM TB_ADMIN  								\n");
		sql.append("WHERE ADMIN_ID = ? AND ADMIN_PW = ? AND ADMIN_ROLE <> 4				\n");
		try {
			//System.out.println("sql:"+sql);
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
			/*if (rs != null){
				rs.close();
			}
			if (pstmt != null){
				pstmt.close();
			}
			if (conn != null){
				conn.close();
			}*/
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
			/*if (rs != null){
				rs.close();
			}
			if (pstmt != null){
				pstmt.close();
			}
			if (conn != null){
				conn.close();
			}*/
		}

		return vo;
	}
}
