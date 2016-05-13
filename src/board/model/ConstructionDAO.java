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
	public int cntTotalMember(String searchKeyword, String[] checked) throws SQLException {
		int result = 0;
		int cnt=0;
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT COUNT(*)	cnt										\n");
		sql.append("FROM TB_CONSTRUCTION 											\n");
		sql.append("WHERE DEL_YN <> 'Y' 														\n");
		if(checked != null){
			for(int i=0; i<checked.length; i++){
				if(checked[i].equals("1")){
					sql.append("AND CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("2")){
					sql.append("AND CONSTRUCTION_WAY LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("3")){
					sql.append("AND CONSTRUCTION_AREA LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("4")){
					sql.append("AND CONSTRUCTION_PRICE LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("5")){
					sql.append("AND CONSTRUCTION_LOWER LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("6")){
					sql.append("AND CONSTRUCTION_OPENING LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("7")){
					sql.append("AND CONSTRUCTION_INSTITUTION LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("8")){
					sql.append("AND CONSTRUCTION_PERCENT LIKE CONCAT('%',?,'%')			\n");
				}
			}	
		}else if(searchKeyword.length() > 0){
			sql.append("AND ( CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')  OR CONSTRUCTION_WAY LIKE CONCAT('%',?,'%')	\n");
			sql.append("OR CONSTRUCTION_AREA LIKE CONCAT('%',?,'%')  OR CONSTRUCTION_PRICE LIKE CONCAT('%',?,'%')  OR CONSTRUCTION_LOWER LIKE CONCAT('%',?,'%')	\n");
			sql.append("OR CONSTRUCTION_OPENING LIKE CONCAT('%',?,'%')  OR CONSTRUCTION_INSTITUTION LIKE CONCAT('%',?,'%')  OR CONSTRUCTION_PERCENT LIKE CONCAT('%',?,'%'))	\n");
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
					if(checked[i].equals("5")){
						pstmt.setString(++cnt, searchKeyword);
					}
					if(checked[i].equals("6")){
						pstmt.setString(++cnt, searchKeyword);
					}
					if(checked[i].equals("7")){
						pstmt.setString(++cnt, searchKeyword);
					}
					if(checked[i].equals("8")){
						pstmt.setString(++cnt, searchKeyword);
					}
				}	
		}else if(searchKeyword.length() > 0){
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
			}
			//System.out.println("Con Cnt selectpstmt:   "+pstmt.toString());
			
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt("cnt");
			}
			//System.out.println("con result:  "+result);
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		return result;
	}
	
	public int cntTotalDelConstruction(String searchKeyword, String[] checked) throws SQLException {
		int result = 0;
		int cnt=0;
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT COUNT(*)	cnt										\n");
		sql.append("FROM TB_CONSTRUCTION 											\n");
		sql.append("WHERE DEL_YN = 'Y' 														\n");
		if(checked != null){
			for(int i=0; i<checked.length; i++){
				if(checked[i].equals("1")){
					sql.append("AND CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("2")){
					sql.append("AND CONSTRUCTION_WAY LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("3")){
					sql.append("AND CONSTRUCTION_AREA LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("4")){
					sql.append("AND CONSTRUCTION_PRICE LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("5")){
					sql.append("AND CONSTRUCTION_LOWER LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("6")){
					sql.append("AND CONSTRUCTION_OPENING LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("7")){
					sql.append("AND CONSTRUCTION_INSTITUTION LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("8")){
					sql.append("AND CONSTRUCTION_PERCENT LIKE CONCAT('%',?,'%')			\n");
				}
			}	
		}else if(searchKeyword.length() > 0){
			sql.append("AND ( CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')  OR CONSTRUCTION_WAY LIKE CONCAT('%',?,'%')	\n");
			sql.append("OR CONSTRUCTION_AREA LIKE CONCAT('%',?,'%')  OR CONSTRUCTION_PRICE LIKE CONCAT('%',?,'%')  OR CONSTRUCTION_LOWER LIKE CONCAT('%',?,'%')	\n");
			sql.append("OR CONSTRUCTION_OPENING LIKE CONCAT('%',?,'%')  OR CONSTRUCTION_INSTITUTION LIKE CONCAT('%',?,'%')  OR CONSTRUCTION_PERCENT LIKE CONCAT('%',?,'%'))	\n");
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
					if(checked[i].equals("5")){
						pstmt.setString(++cnt, searchKeyword);
					}
					if(checked[i].equals("6")){
						pstmt.setString(++cnt, searchKeyword);
					}
					if(checked[i].equals("7")){
						pstmt.setString(++cnt, searchKeyword);
					}
					if(checked[i].equals("8")){
						pstmt.setString(++cnt, searchKeyword);
					}
				}	
		}else if(searchKeyword.length() > 0){
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
			}
			//System.out.println("Con Cnt selectpstmt:   "+pstmt.toString());
			
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt("cnt");
			}
			//System.out.println("con result:  "+result);
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
	public ArrayList<ConstructionDTO> selectConstructionList(String searchKeyword, int pageno, int totalcnt, String[] checked) throws SQLException {
		ArrayList<ConstructionDTO> list = new ArrayList<ConstructionDTO>();
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
		}*/
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT 					\n");
		sql.append("CONSTRUCTION_NUM , CONSTRUCTION_NAME, CONSTRUCTION_WAY, CONSTRUCTION_AREA, CONSTRUCTION_PRICE, CONSTRUCTION_LOWER, CONSTRUCTION_OPENING, CONSTRUCTION_INSTITUTION, CONSTRUCTION_PERCENT, date_format(CRT_DATE, '%Y.%m.%d') as CRT_DATE, date_format(UDT_DATE, '%Y.%m.%d') as UDT_DATE 	\n");
		sql.append("FROM 														\n");
		sql.append("TB_CONSTRUCTION 														\n");
		sql.append("WHERE DEL_YN <> 'Y' 														\n");
		if(checked != null){
			for(int i=0; i<checked.length; i++){
				if(checked[i].equals("1")){
					sql.append("AND CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("2")){
					sql.append("AND CONSTRUCTION_WAY LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("3")){
					sql.append("AND CONSTRUCTION_AREA LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("4")){
					sql.append("AND CONSTRUCTION_PRICE LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("5")){
					sql.append("AND CONSTRUCTION_LOWER LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("6")){
					sql.append("AND CONSTRUCTION_OPENING LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("7")){
					sql.append("AND CONSTRUCTION_INSTITUTION LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("8")){
					sql.append("AND CONSTRUCTION_PERCENT LIKE CONCAT('%',?,'%')			\n");
				}
			}	
		}else if(searchKeyword.length() > 0){
			sql.append("AND ( CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR CONSTRUCTION_WAY LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR CONSTRUCTION_AREA LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR CONSTRUCTION_PRICE LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR CONSTRUCTION_LOWER LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR CONSTRUCTION_OPENING LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR CONSTRUCTION_INSTITUTION LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR CONSTRUCTION_PERCENT LIKE CONCAT('%',?,'%'))					\n");
		}
		sql.append("ORDER BY CONSTRUCTION_NUM DESC												\n");
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
					if(checked[i].equals("6")){
						pstmt.setString(nCnt++, searchKeyword);
					}
					if(checked[i].equals("7")){
						pstmt.setString(nCnt++, searchKeyword);
					}
					if(checked[i].equals("8")){
						pstmt.setString(nCnt++, searchKeyword);
					}
				}	
		}else if(searchKeyword.length() > 0){
				
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
			}
			pstmt.setInt(nCnt++, startRow);
			pstmt.setInt(nCnt++, endRow);
			//System.out.println("Con selectpstmt:   "+pstmt.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ConstructionDTO dto = new ConstructionDTO();
				dto.setConstNum(rs.getInt("CONSTRUCTION_NUM"));
				dto.setConstName(rs.getString("CONSTRUCTION_NAME"));
				dto.setConstWay(rs.getString("CONSTRUCTION_WAY"));
				dto.setConstArea(rs.getString("CONSTRUCTION_AREA"));
				dto.setConstPrice(rs.getString("CONSTRUCTION_PRICE"));
				dto.setConstLower(rs.getString("CONSTRUCTION_LOWER"));
				dto.setConstOpening(rs.getString("CONSTRUCTION_OPENING"));
				dto.setConstInstitution(rs.getString("CONSTRUCTION_INSTITUTION"));
				dto.setConstPercent(rs.getString("CONSTRUCTION_PERCENT"));
				dto.setCrtDate(rs.getString("CRT_DATE"));
				dto.setUdtDate(rs.getString("UDT_DATE"));

				list.add(dto);
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		return list;
	}
	
	
	public ArrayList<ConstructionDTO> selectConstructionDelList(String searchKeyword, int pageno, int totalcnt, String[] checked) throws SQLException {
		ArrayList<ConstructionDTO> list = new ArrayList<ConstructionDTO>();
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
		}*/
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT 					\n");
		sql.append("CONSTRUCTION_NUM , CONSTRUCTION_NAME, CONSTRUCTION_WAY, CONSTRUCTION_AREA, CONSTRUCTION_PRICE, CONSTRUCTION_LOWER, CONSTRUCTION_OPENING, CONSTRUCTION_INSTITUTION, CONSTRUCTION_PERCENT, date_format(CRT_DATE, '%Y.%m.%d') as CRT_DATE, date_format(UDT_DATE, '%Y.%m.%d') as UDT_DATE 	\n");
		sql.append("FROM 														\n");
		sql.append("TB_CONSTRUCTION 														\n");
		sql.append("WHERE DEL_YN = 'Y' 														\n");
		if(checked != null){
			for(int i=0; i<checked.length; i++){
				if(checked[i].equals("1")){
					sql.append("AND CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("2")){
					sql.append("AND CONSTRUCTION_WAY LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("3")){
					sql.append("AND CONSTRUCTION_AREA LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("4")){
					sql.append("AND CONSTRUCTION_PRICE LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("5")){
					sql.append("AND CONSTRUCTION_LOWER LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("6")){
					sql.append("AND CONSTRUCTION_OPENING LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("7")){
					sql.append("AND CONSTRUCTION_INSTITUTION LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("8")){
					sql.append("AND CONSTRUCTION_PERCENT LIKE CONCAT('%',?,'%')			\n");
				}
			}	
		}else if(searchKeyword.length() > 0){
			sql.append("AND ( CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR CONSTRUCTION_WAY LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR CONSTRUCTION_AREA LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR CONSTRUCTION_PRICE LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR CONSTRUCTION_LOWER LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR CONSTRUCTION_OPENING LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR CONSTRUCTION_INSTITUTION LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR CONSTRUCTION_PERCENT LIKE CONCAT('%',?,'%'))					\n");
		}
		sql.append("ORDER BY CONSTRUCTION_NUM DESC												\n");
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
					if(checked[i].equals("6")){
						pstmt.setString(nCnt++, searchKeyword);
					}
					if(checked[i].equals("7")){
						pstmt.setString(nCnt++, searchKeyword);
					}
					if(checked[i].equals("8")){
						pstmt.setString(nCnt++, searchKeyword);
					}
				}	
		}else if(searchKeyword.length() > 0){
				
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
			}
			pstmt.setInt(nCnt++, startRow);
			pstmt.setInt(nCnt++, endRow);
			//System.out.println("Con selectpstmt:   "+pstmt.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ConstructionDTO dto = new ConstructionDTO();
				dto.setConstNum(rs.getInt("CONSTRUCTION_NUM"));
				dto.setConstName(rs.getString("CONSTRUCTION_NAME"));
				dto.setConstWay(rs.getString("CONSTRUCTION_WAY"));
				dto.setConstArea(rs.getString("CONSTRUCTION_AREA"));
				dto.setConstPrice(rs.getString("CONSTRUCTION_PRICE"));
				dto.setConstLower(rs.getString("CONSTRUCTION_LOWER"));
				dto.setConstOpening(rs.getString("CONSTRUCTION_OPENING"));
				dto.setConstInstitution(rs.getString("CONSTRUCTION_INSTITUTION"));
				dto.setConstPercent(rs.getString("CONSTRUCTION_PERCENT"));
				dto.setCrtDate(rs.getString("CRT_DATE"));
				dto.setUdtDate(rs.getString("UDT_DATE"));

				list.add(dto);
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
		sql.append("		TB_CONSTRUCTION															\n");
		sql.append("WHERE DEL_YN <> 'Y'														\n");
		try{
			pstmt = conn.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			while(rs.next()){
				ConstructionDTO dto = new ConstructionDTO();
				dto.setConstName(rs.getString("CONSTRUCTION_NAME"));
				dto.setConstNum(rs.getInt("CONSTRUCTION_NUM"));
				list.add(dto);
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
			if (rs != null){
				rs.close();
			}
			if (pstmt != null){
				pstmt.close();
			}
			if (conn != null){
				conn.close();
			}
		}
		return list;
	}
	
	public int insertConstructionAdd(String constName, String constWay, String constArea,
			 String constPrice, String constLower, String constOpening,
			String constInstitution, String constPercent) throws SQLException {
		
		StringBuffer sql = new StringBuffer();
		int result = 0;
		sql.append("INSERT INTO TB_CONSTRUCTION(CONSTRUCTION_NAME, CONSTRUCTION_WAY, CONSTRUCTION_AREA, CONSTRUCTION_PRICE, CONSTRUCTION_LOWER, CONSTRUCTION_OPENING, CONSTRUCTION_INSTITUTION			\n");
		sql.append("	, CONSTRUCTION_PERCENT, CRT_DATE)										\n");
		sql.append("	   SELECT ?, ?, ?, ?, ?, ?, ?,?, now() FROM DUAL				\n");
		sql.append("WHERE NOT EXISTS(SELECT CONSTRUCTION_NAME FROM TB_CONSTRUCTION WHERE CONSTRUCTION_NAME=?)				\n");
		try {
			pstmt = conn.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS);
			
			pstmt.setString(1, constName);
			pstmt.setString(2, constWay);
			pstmt.setString(3, constArea);
			pstmt.setString(4, constPrice);
			pstmt.setString(5, constLower);
			pstmt.setString(6, constOpening);
			pstmt.setString(7, constInstitution);
			pstmt.setString(8, constPercent);
			pstmt.setString(9, constName);
			
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
	
	public int totalInsert(String sql) throws SQLException {
		
		//StringBuffer sql = new StringBuffer();
		int result = 0;

		System.out.println("sql:   "+sql);
		
		try {
			pstmt = conn.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS);
			
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
	 * 공고 삭제
	 */
	public int deleteConstruction(int ConstNum) throws SQLException {
		StringBuffer sql = new StringBuffer();
		int result = 0;
		sql.append("UPDATE TB_CONSTRUCTION													\n");
		sql.append("SET										\n");
		sql.append("DEL_YN = 'Y' 												\n");
		sql.append("WHERE TB_CONSTRUCTION.CONSTRUCTION_NUM = ?								\n");
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, ConstNum);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		return result;
	}
	
	public int deleteConstructionView(int ConstNum) throws SQLException {
		StringBuffer sql = new StringBuffer();
		int result = 0;
		sql.append("UPDATE TB_CONSTRUCTION JOIN TB_BUSINESS												\n");
		sql.append("ON TB_CONSTRUCTION.CONSTRUCTION_NUM = TB_BUSINESS.CONSTRUCTION_NUM			\n");
		sql.append("SET TB_BUSINESS.DEL_YN = 'Y' 												\n");
		sql.append("WHERE TB_BUSINESS.CONSTRUCTION_NUM = ?								\n");
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, ConstNum);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		return result;
	}
	
	/*
	 * 공고 영구 삭제
	 */
	public int deleteConstruction2(int ConstNum) throws SQLException {
		StringBuffer sql = new StringBuffer();
		int result = 0;
		/*	두개 이상 삭제 할 때
		sql.append("DELETE TB_CONSTRUCTION, TB_BUSINESS FROM													\n");
		sql.append("TB_CONSTRUCTION	JOIN TB_BUSINESS								\n");
		sql.append("ON TB_CONSTRUCTION.DEL_YN = TB_BUSINESS.DEL_YN 												\n");
		sql.append("WHERE TB_CONSTRUCTION.DEL_YN='Y' AND (TB_CONSTRUCTION.CONSTRUCTION_NUM = ?) OR (TB_CONSTRUCTION.CONSTRUCTION_NUM = ? AND TB_BUSINESS.CONSTRUCTION_NUM = ?)					\n");
		*/
		
		sql.append("DELETE FROM													\n");
		sql.append("TB_CONSTRUCTION								\n");
		sql.append("WHERE DEL_YN='Y' AND CONSTRUCTION_NUM = ?				\n");
		
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, ConstNum);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		return result;
	}
	
	public int restoreConstruction(int ConstNum) throws SQLException {
		StringBuffer sql = new StringBuffer();
		int result = 0;
		sql.append("UPDATE TB_CONSTRUCTION													\n");
		sql.append("SET										\n");
		sql.append("DEL_YN = 'N' 												\n");
		sql.append("WHERE TB_CONSTRUCTION.CONSTRUCTION_NUM = ?								\n");
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, ConstNum);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		return result;
	}
	
	public ArrayList<ConstructionDTO> selectConstructionListExcel(String searchKeyword, int pageno, int totalcnt, String[] checked) throws SQLException {
		ArrayList<ConstructionDTO> list = new ArrayList<ConstructionDTO>();
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
		sql.append("SELECT 					\n");
		sql.append("CONSTRUCTION_NUM , CONSTRUCTION_NAME, CONSTRUCTION_WAY, CONSTRUCTION_AREA, CONSTRUCTION_PRICE, CONSTRUCTION_LOWER, CONSTRUCTION_OPENING, CONSTRUCTION_INSTITUTION, CONSTRUCTION_PERCENT, date_format(CRT_DATE, '%Y.%m.%d') as CRT_DATE, date_format(UDT_DATE, '%Y.%m.%d') as UDT_DATE 	\n");
		sql.append("FROM 														\n");
		sql.append("TB_CONSTRUCTION 														\n");
		sql.append("WHERE DEL_YN <> 'Y' 														\n");
		if(checked != null){
			for(int i=0; i<checked.length; i++){
				if(checked[i].equals("1")){
					sql.append("AND CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("2")){
					sql.append("AND CONSTRUCTION_WAY LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("3")){
					sql.append("AND CONSTRUCTION_AREA LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("4")){
					sql.append("AND CONSTRUCTION_PRICE LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("5")){
					sql.append("AND CONSTRUCTION_LOWER LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("6")){
					sql.append("AND CONSTRUCTION_OPENING LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("7")){
					sql.append("AND CONSTRUCTION_INSTITUTION LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("8")){
					sql.append("AND CONSTRUCTION_PERCENT LIKE CONCAT('%',?,'%')			\n");
				}
			}	
		}else if(searchKeyword.length() > 0){
			sql.append("AND ( CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR CONSTRUCTION_WAY LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR CONSTRUCTION_AREA LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR CONSTRUCTION_PRICE LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR CONSTRUCTION_LOWER LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR CONSTRUCTION_OPENING LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR CONSTRUCTION_INSTITUTION LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR CONSTRUCTION_PERCENT LIKE CONCAT('%',?,'%'))					\n");
		}
		sql.append("ORDER BY CONSTRUCTION_NUM DESC												\n");
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
					if(checked[i].equals("6")){
						pstmt.setString(nCnt++, searchKeyword);
					}
					if(checked[i].equals("7")){
						pstmt.setString(nCnt++, searchKeyword);
					}
					if(checked[i].equals("8")){
						pstmt.setString(nCnt++, searchKeyword);
					}
				}	
		}else if(searchKeyword.length() > 0){
				
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
				pstmt.setString(nCnt++, searchKeyword);
			}
			pstmt.setInt(nCnt++, startRow);
			pstmt.setInt(nCnt++, endRow);
			//System.out.println("Con selectpstmt:   "+pstmt.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ConstructionDTO dto = new ConstructionDTO();
				dto.setConstNum(rs.getInt("CONSTRUCTION_NUM"));
				dto.setConstName(rs.getString("CONSTRUCTION_NAME"));
				dto.setConstWay(rs.getString("CONSTRUCTION_WAY"));
				dto.setConstArea(rs.getString("CONSTRUCTION_AREA"));
				dto.setConstPrice(rs.getString("CONSTRUCTION_PRICE"));
				dto.setConstLower(rs.getString("CONSTRUCTION_LOWER"));
				dto.setConstOpening(rs.getString("CONSTRUCTION_OPENING"));
				dto.setConstInstitution(rs.getString("CONSTRUCTION_INSTITUTION"));
				dto.setConstPercent(rs.getString("CONSTRUCTION_PERCENT"));
				dto.setCrtDate(rs.getString("CRT_DATE"));
				dto.setUdtDate(rs.getString("UDT_DATE"));

				list.add(dto);
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		return list;
	}
	
	public ConstructionDTO selectConstructionInfo(int ConstNum) throws SQLException {
		ConstructionDTO dto = new ConstructionDTO();

		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT 					\n");
		sql.append("CONSTRUCTION_NUM , CONSTRUCTION_NAME, CONSTRUCTION_WAY, CONSTRUCTION_AREA, CONSTRUCTION_PRICE, CONSTRUCTION_LOWER, CONSTRUCTION_OPENING, CONSTRUCTION_INSTITUTION, CONSTRUCTION_PERCENT, date_format(CRT_DATE, '%Y.%m.%d') as CRT_DATE, date_format(UDT_DATE, '%Y.%m.%d') as UDT_DATE 	\n");
		sql.append("FROM 														\n");
		sql.append("TB_CONSTRUCTION 														\n");
		sql.append("WHERE CONSTRUCTION_NUM = ?													\n");
		
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, ConstNum);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setConstNum(rs.getInt("CONSTRUCTION_NUM"));
				dto.setConstName(rs.getString("CONSTRUCTION_NAME"));
				dto.setConstWay(rs.getString("CONSTRUCTION_WAY"));
				dto.setConstArea(rs.getString("CONSTRUCTION_AREA"));
				dto.setConstPrice(rs.getString("CONSTRUCTION_PRICE"));
				dto.setConstLower(rs.getString("CONSTRUCTION_LOWER"));
				dto.setConstOpening(rs.getString("CONSTRUCTION_OPENING"));
				dto.setConstInstitution(rs.getString("CONSTRUCTION_INSTITUTION"));
				dto.setConstPercent(rs.getString("CONSTRUCTION_PERCENT"));
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
	
	public int updateConstruction(int ConstNum, String constWay, String constArea, String constPrice, String constLower, String constOpening, String constInstitution, String constPercent) throws SQLException {
		StringBuffer sql = new StringBuffer();
		int result = 0;
		sql.append("UPDATE TB_CONSTRUCTION															  \n");
		sql.append("SET CONSTRUCTION_WAY = ?, CONSTRUCTION_AREA = ?,			  \n");
		sql.append("CONSTRUCTION_PRICE = ?, CONSTRUCTION_LOWER = ?, CONSTRUCTION_OPENING = ?, 		  \n");
		sql.append("CONSTRUCTION_INSTITUTION = ?, CONSTRUCTION_PERCENT = ?,	UDT_DATE = now()		  \n");
		sql.append("WHERE CONSTRUCTION_NUM = ?												  	      \n");
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, constWay);
			pstmt.setString(2, constArea);
			pstmt.setString(3, constPrice);
			pstmt.setString(4, constLower);
			pstmt.setString(5, constOpening);
			pstmt.setString(6, constInstitution);
			pstmt.setString(7, constPercent);
			pstmt.setInt(8, ConstNum);

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}

		return result;
	}
}