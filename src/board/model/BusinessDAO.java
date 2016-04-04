package board.model;
import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.concurrent.locks.Lock;

import com.mysql.jdbc.Statement;

public class BusinessDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public BusinessDAO() throws SQLException {
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
	
	/*
	 * 占쏙옙占� 占쏙옙占쏙옙트 占쌀뤄옙占쏙옙占쏙옙 占쌨소듸옙
	 */
	public int cntTotalMember(String searchKeyword) throws SQLException {
		int result = 0;
		int cnt = 0;
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT COUNT(*)	cnt										\n");
		sql.append("FROM TB_BUSINESS 											\n");
		sql.append("WHERE DEL_YN <> 'Y' 														\n");
		/*if(searchKeyword.length() > 0){
			sql.append("AND ( MEMBER_ID LIKE CONCAT('%',?,'%')  OR MEMBER_NAME LIKE CONCAT('%',?,'%')  OR MEMBER_PHONE LIKE CONCAT('%',?,'%'))	\n");
		}*/
		try {
			pstmt = conn.prepareStatement(sql.toString());
			/*if(searchKeyword.length() > 0){
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
			}*/
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt("cnt");
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		return result;
	}
	
	/*
	 * 占쏙옙占� 占쏙옙占쏙옙트 占쏙옙占쏙옙 占쌀뤄옙占쏙옙占쏙옙
	 */
	public ArrayList<BusinessDTO> selectBusinessList(String searchKeyword, int pageno) throws SQLException {
		ArrayList<BusinessDTO> list = new ArrayList<BusinessDTO>();
		int nCnt = 1;
		int startRow =0;
		if(searchKeyword.length() <= 0){
			startRow = (pageno - 1) * 10;
		}
		int endRow = 10;
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT 					\n");
		sql.append("BUSINESS_NUM, BUSINESS_NAME, BUSINESS_OPENING, BUSINESS_PRICE, BUSINESS_PERCENT, BUSINESS_WAY, BUSINESS_AREA, CRT_DATE 														\n");
		sql.append("FROM 														\n");
		sql.append("TB_BUSINESS 														\n");
		sql.append("WHERE DEL_YN <> 'Y' 														\n");
		/*if(searchKeyword.length() > 0){
			sql.append("AND ( MEMBER_ID LIKE CONCAT('%',?,'%')  OR MEMBER_NAME LIKE CONCAT('%',?,'%')  OR MEMBER_PHONE LIKE CONCAT('%',?,'%'))	\n");
		}*/
		sql.append("ORDER BY BUSINESS_NUM DESC												\n");
		sql.append("LIMIT ?, ?															\n");
		
		try {
			pstmt = conn.prepareStatement(sql.toString());
			/*if(searchKeyword.length() > 0){
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
			}*/
			pstmt.setInt(nCnt++, startRow);
			pstmt.setInt(nCnt++, endRow);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				BusinessDTO vo = new BusinessDTO();
				vo.setBusiNum(rs.getInt("BUSINESS_NUM"));
				vo.setBusiName(rs.getString("BUSINESS_NAME"));
				vo.setBusiOpening(rs.getString("BUSINESS_OPENING"));
				vo.setBusiPrice(rs.getString("BUSINESS_PRICE"));
				vo.setBusiPercent(rs.getString("BUSINESS_PERCENT"));
				vo.setBusiWay(rs.getString("BUSINESS_WAY"));
				vo.setBusiArea(rs.getString("BUSINESS_AREA"));
				vo.setCrtDate(rs.getString("CRT_DATE"));

				list.add(vo);
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		return list;
	}
	
	public int insertBusinessAdd(int constNum, String busiName, String busiOpening,
			 String busiPrice, String busiPercent, String busiWay,
			String busiArea) throws SQLException {
		
		StringBuffer sql = new StringBuffer();
		int result = 0;
		sql.append("INSERT INTO TB_BUSINESS(CONSTRUCTION_NUM, BUSINESS_NAME, BUSINESS_OPENING, BUSINESS_PRICE, BUSINESS_PERCENT, BUSINESS_WAY, BUSINESS_AREA			\n");
		sql.append("	, CRT_DATE)										\n");
		sql.append("	   VALUES(?, ?, ?, ?, ?, ?, ?, now()) 					\n");
		try {
			pstmt = conn.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS);
			
			pstmt.setInt(1, constNum);
			pstmt.setString(2, busiName);
			pstmt.setString(3, busiOpening);
			pstmt.setString(4, busiPrice);
			pstmt.setString(5, busiPercent);
			pstmt.setString(6, busiWay);
			pstmt.setString(7, busiArea);
			
			result = pstmt.executeUpdate();
			
			if (result > 0) {
				result = -1;
				try {
					rs = pstmt.getGeneratedKeys();
					if (rs.next())
						result = rs.getInt(1);
				} catch (SQLException e) {
					result = -1;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);

		}
		return result;
	}
	
	/*
	 * 비지니스 삭제
	 */
	public int deleteBusiness(int no) throws SQLException {
		StringBuffer sql = new StringBuffer();
		int result = 0;
		sql.append("UPDATE TB_BUSINESS														\n");
		sql.append("SET 														\n");
		sql.append("	DEL_YN = 'Y' 												\n");
		sql.append("WHERE BUSINESS_NUM = ?													\n");
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
	
}