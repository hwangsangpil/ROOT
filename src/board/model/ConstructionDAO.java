package board.model;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.concurrent.locks.Lock;

import com.mysql.jdbc.Statement;

public class ConstructionDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public ConstructionDAO() throws SQLException {
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
	
	/*
	 * 占쏙옙占� 占쏙옙占쏙옙트 占쌀뤄옙占쏙옙占쏙옙 占쌨소듸옙
	 */
	public int cntTotalMember(String searchKeyword) throws SQLException {
		int result = 0;
		int cnt = 0;
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT COUNT(*)	cnt										\n");
		sql.append("FROM TB_CONSTRUCTION 											\n");
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
	public ArrayList<ConstructionDTO> selectConstructionList(String searchKeyword, int pageno) throws SQLException {
		ArrayList<ConstructionDTO> list = new ArrayList<ConstructionDTO>();
		int nCnt = 1;
		int startRow =0;
		if(searchKeyword.length() <= 0){
			startRow = (pageno - 1) * 10;
		}
		int endRow = 10;
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT 					\n");
		sql.append("CONSTRUCTION_NUM , CONSTRUCTION_NAME, CONSTRUCTION_WAY, CONSTRUCTION_AREA, CONSTRUCTION_PRICE, CONSTRUCTION_LOWER, CONSTRUCTION_OPENING, CONSTRUCTION_INSTITUTION, CONSTRUCTION_PERCENT, CRT_DATE 														\n");
		sql.append("FROM 														\n");
		sql.append("TB_CONSTRUCTION 														\n");
		sql.append("WHERE DEL_YN <> 'Y' 														\n");
		/*if(searchKeyword.length() > 0){
			sql.append("AND ( MEMBER_ID LIKE CONCAT('%',?,'%')  OR MEMBER_NAME LIKE CONCAT('%',?,'%')  OR MEMBER_PHONE LIKE CONCAT('%',?,'%'))	\n");
		}*/
		sql.append("ORDER BY CONSTRUCTION_NUM DESC												\n");
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
				ConstructionDTO vo = new ConstructionDTO();
				vo.setConstNum(rs.getInt("CONSTRUCTION_NUM"));
				vo.setConstName(rs.getString("CONSTRUCTION_NAME"));
				vo.setConstWay(rs.getString("CONSTRUCTION_WAY"));
				vo.setConstArea(rs.getString("CONSTRUCTION_AREA"));
				vo.setConstPrice(rs.getString("CONSTRUCTION_PRICE"));
				vo.setConstLower(rs.getString("CONSTRUCTION_LOWER"));
				vo.setConstOpening(rs.getString("CONSTRUCTION_OPENING"));
				vo.setConstInstitution(rs.getString("CONSTRUCTION_INSTITUTION"));
				vo.setConstPercent(rs.getString("CONSTRUCTION_PERCENT"));
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
	
	
	/*
	 * 공사 리스트 가져오기
	 */
	public ArrayList<ConstructionDTO> selectConstructionList()throws SQLException{
		ArrayList<ConstructionDTO> list = new ArrayList<ConstructionDTO>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT																								\n");
		sql.append("		CONSTRUCTION_NAME, CONSTRUCTION_NUM									\n");
		sql.append("FROM																								\n");
		sql.append("		TB_CONSTRUCTION																	\n");
		
		try{
			pstmt = conn.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			while(rs.next()){
				ConstructionDTO vo = new ConstructionDTO();
				vo.setConstName(rs.getString("CONSTRUCTION_NAME"));
				vo.setConstNum(rs.getInt("CONSTRUCTION_NUM"));
				list.add(vo);
			}
		}catch (Exception e) {
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
	
}