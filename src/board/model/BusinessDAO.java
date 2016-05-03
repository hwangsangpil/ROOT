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
	 * 
	 */
	public int cntTotalMember(String searchKeyword, String[] checked) throws SQLException {
		int result = 0;
		int cnt = 0;
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT COUNT(*)	cnt														\n");
		sql.append("FROM																	\n");
		sql.append("TB_CONSTRUCTION JOIN TB_BUSINESS										\n");
		sql.append("WHERE																	\n");
		sql.append("TB_CONSTRUCTION.CONSTRUCTION_NUM = TB_BUSINESS.CONSTRUCTION_NUM			\n");
		sql.append("AND TB_BUSINESS.DEL_YN <> 'Y' 											\n");
		
		if(checked != null){
			for(int i=0; i<checked.length; i++){
				if(checked[i].equals("1")){
					sql.append("AND TB_CONSTRUCTION.CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("2")){
					sql.append("AND TB_BUSINESS.BUSINESS_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("3")){
					sql.append("AND TB_BUSINESS.BUSINESS_OPENING LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("4")){
					sql.append("AND TB_BUSINESS.BUSINESS_PRICE LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("5")){
					sql.append("AND TB_BUSINESS.BUSINESS_PERCENT LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("6")){
					sql.append("AND TB_BUSINESS.BUSINESS_WAY LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("7")){
					sql.append("AND TB_BUSINESS.BUSINESS_AREA LIKE CONCAT('%',?,'%')			\n");
				}
			}	
		}else if(searchKeyword.length() > 0){
			sql.append("AND (TB_CONSTRUCTION.CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')		\n");
			sql.append("OR TB_BUSINESS.BUSINESS_NAME LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR TB_BUSINESS.BUSINESS_OPENING LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR TB_BUSINESS.BUSINESS_PRICE LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR TB_BUSINESS.BUSINESS_PERCENT LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR TB_BUSINESS.BUSINESS_WAY LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR TB_BUSINESS.BUSINESS_AREA LIKE CONCAT('%',?,'%'))				\n");
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
				}	
		}else if(searchKeyword.length() > 0){
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
			}
			//System.out.println("Busi Cnt selectpstmt:   "+pstmt.toString());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt("cnt");
			}
			//System.out.println("Busi result:  "+result);
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		return result;
	}
	
	public int viewCntTotalMember(String searchKeyword, int ConstNum, String[] checked) throws SQLException {
		//System.out.println("view no:"+ConstNum);
		int result = 0;
		int cnt = 0;
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT COUNT(*)	cnt														\n");
		sql.append("FROM																	\n");
		sql.append("TB_CONSTRUCTION JOIN TB_BUSINESS										\n");
		sql.append("WHERE																	\n");
		sql.append("TB_CONSTRUCTION.CONSTRUCTION_NUM = TB_BUSINESS.CONSTRUCTION_NUM			\n");
		sql.append("AND TB_BUSINESS.DEL_YN <> 'Y' 											\n");
		sql.append("AND TB_BUSINESS.CONSTRUCTION_NUM=?										\n");
		
		if(checked != null){
			for(int i=0; i<checked.length; i++){
				if(checked[i].equals("1")){
					sql.append("AND TB_CONSTRUCTION.CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("2")){
					sql.append("AND TB_BUSINESS.BUSINESS_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("3")){
					sql.append("AND TB_BUSINESS.BUSINESS_OPENING LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("4")){
					sql.append("AND TB_BUSINESS.BUSINESS_PRICE LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("5")){
					sql.append("AND TB_BUSINESS.BUSINESS_PERCENT LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("6")){
					sql.append("AND TB_BUSINESS.BUSINESS_WAY LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("7")){
					sql.append("AND TB_BUSINESS.BUSINESS_AREA LIKE CONCAT('%',?,'%')			\n");
				}
			}	
		}else if(searchKeyword.length() > 0){
			sql.append("AND (TB_CONSTRUCTION.CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')		\n");
			sql.append("OR TB_BUSINESS.BUSINESS_NAME LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR TB_BUSINESS.BUSINESS_OPENING LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR TB_BUSINESS.BUSINESS_PRICE LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR TB_BUSINESS.BUSINESS_PERCENT LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR TB_BUSINESS.BUSINESS_WAY LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR TB_BUSINESS.BUSINESS_AREA LIKE CONCAT('%',?,'%'))				\n");
		}
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(++cnt, ConstNum);
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
				}	
		}else if(searchKeyword.length() > 0){
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
				pstmt.setString(++cnt, searchKeyword);
			}
			//System.out.println("View Cnt selectpstmt:   "+pstmt.toString());
			
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt("cnt");
			}
			//System.out.println("view result:  "+result);
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		return result;
	}
	
	/*
	 * 
	 */
	
	public int constDelCntTotal(int ConstNum) throws SQLException {
		//System.out.println("view no:"+ConstNum);
		int result = 0;
		int cnt = 0;
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT COUNT(*)	cnt														\n");
		sql.append("FROM																	\n");
		sql.append("TB_CONSTRUCTION JOIN TB_BUSINESS										\n");
		sql.append("WHERE																	\n");
		sql.append("TB_CONSTRUCTION.CONSTRUCTION_NUM = TB_BUSINESS.CONSTRUCTION_NUM			\n");
		sql.append("AND TB_BUSINESS.DEL_YN <> 'Y' 											\n");
		sql.append("AND TB_BUSINESS.CONSTRUCTION_NUM=?										\n");
		
		
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(++cnt, ConstNum);
			
			//System.out.println("View Cnt selectpstmt:   "+pstmt.toString());
			
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt("cnt");
			}
			//System.out.println("view result:  "+result);
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		return result;
	}
	
	public ArrayList<BusinessDTO> selectBusinessList(String searchKeyword, int pageno, int totalcnt, String[] checked) throws SQLException {
		ArrayList<BusinessDTO> list = new ArrayList<BusinessDTO>();
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
		
		/*if(checked != null){
			for(int i=0; i<checked.length;i++){
			System.out.println("checked[]:    "+checked[i]);
			}
		}*/
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT 					\n");
		sql.append("TB_BUSINESS.BUSINESS_NUM,TB_BUSINESS.CONSTRUCTION_NUM , TB_CONSTRUCTION.CONSTRUCTION_NAME, TB_BUSINESS.BUSINESS_NAME,			\n");
		sql.append("TB_BUSINESS.BUSINESS_OPENING, TB_BUSINESS.BUSINESS_PRICE, TB_BUSINESS.BUSINESS_PERCENT, TB_BUSINESS.BUSINESS_WAY, TB_BUSINESS.BUSINESS_AREA, date_format(TB_BUSINESS.CRT_DATE, '%Y.%m.%d') as CRT_DATE, date_format(TB_BUSINESS.UDT_DATE, '%Y.%m.%d') as UDT_DATE	\n");
		sql.append("FROM 														\n");
		sql.append("TB_CONSTRUCTION JOIN TB_BUSINESS														\n");
		sql.append("WHERE TB_CONSTRUCTION.CONSTRUCTION_NUM=TB_BUSINESS.CONSTRUCTION_NUM AND TB_BUSINESS.DEL_YN <> 'Y' 														\n");
		if(checked != null){
			for(int i=0; i<checked.length; i++){
				if(checked[i].equals("1")){
					sql.append("AND TB_CONSTRUCTION.CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("2")){
					sql.append("AND TB_BUSINESS.BUSINESS_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("3")){
					sql.append("AND TB_BUSINESS.BUSINESS_OPENING LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("4")){
					sql.append("AND TB_BUSINESS.BUSINESS_PRICE LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("5")){
					sql.append("AND TB_BUSINESS.BUSINESS_PERCENT LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("6")){
					sql.append("AND TB_BUSINESS.BUSINESS_WAY LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("7")){
					sql.append("AND TB_BUSINESS.BUSINESS_AREA LIKE CONCAT('%',?,'%')			\n");
				}
			}	
		}else if(searchKeyword.length() > 0){
			sql.append("AND (TB_CONSTRUCTION.CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')		\n");
			sql.append("OR TB_BUSINESS.BUSINESS_NAME LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR TB_BUSINESS.BUSINESS_OPENING LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR TB_BUSINESS.BUSINESS_PRICE LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR TB_BUSINESS.BUSINESS_PERCENT LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR TB_BUSINESS.BUSINESS_WAY LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR TB_BUSINESS.BUSINESS_AREA LIKE CONCAT('%',?,'%'))				\n");
		}
		sql.append("ORDER BY TB_BUSINESS.BUSINESS_NUM DESC												\n");
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
				}	
		}else if(searchKeyword.length() > 0){
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
			//System.out.println("Busi selectpstmt:   "+pstmt.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BusinessDTO vo = new BusinessDTO();
				vo.setBusiNum(rs.getInt("BUSINESS_NUM"));
				vo.setConstNum(rs.getInt("CONSTRUCTION_NUM"));
				vo.setConstName(rs.getString("TB_CONSTRUCTION.CONSTRUCTION_NAME"));
				vo.setBusiName(rs.getString("BUSINESS_NAME"));
				vo.setBusiOpening(rs.getString("BUSINESS_OPENING"));
				vo.setBusiPrice(rs.getString("BUSINESS_PRICE"));
				vo.setBusiPercent(rs.getString("BUSINESS_PERCENT"));
				vo.setBusiWay(rs.getString("BUSINESS_WAY"));
				vo.setBusiArea(rs.getString("BUSINESS_AREA"));
				vo.setCrtDate(rs.getString("CRT_DATE"));
				vo.setUdtDate(rs.getString("UDT_DATE"));

				list.add(vo);
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		return list;
	}
	
	public ArrayList<BusinessDTO> businessView(int ConstNum, int pageno, String searchKeyword, int totalcnt, String[] checked) throws SQLException {
		ArrayList<BusinessDTO> list = new ArrayList<BusinessDTO>();
		int nCnt = 1;
		int startRow =0;
		/*
		if(Math.ceil(totalcnt/10)<=pageno && (pageno-1)!=0)
		{
			--pageno;
		}
		*/
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
		sql.append("TB_BUSINESS.BUSINESS_NUM,TB_BUSINESS.CONSTRUCTION_NUM , TB_CONSTRUCTION.CONSTRUCTION_NAME, TB_BUSINESS.BUSINESS_NAME,			\n");
		sql.append("TB_BUSINESS.BUSINESS_OPENING, TB_BUSINESS.BUSINESS_PRICE, TB_BUSINESS.BUSINESS_PERCENT, TB_BUSINESS.BUSINESS_WAY, TB_BUSINESS.BUSINESS_AREA, date_format(TB_BUSINESS.CRT_DATE, '%Y.%m.%d') as CRT_DATE, date_format(TB_BUSINESS.UDT_DATE, '%Y.%m.%d') as UDT_DATE	\n");
		sql.append("FROM 														\n");
		sql.append("TB_CONSTRUCTION JOIN TB_BUSINESS														\n");
		sql.append("WHERE TB_CONSTRUCTION.CONSTRUCTION_NUM=TB_BUSINESS.CONSTRUCTION_NUM AND TB_BUSINESS.DEL_YN <> 'Y' AND TB_BUSINESS.CONSTRUCTION_NUM=?										\n");
		if(checked != null){
			for(int i=0; i<checked.length; i++){
				if(checked[i].equals("1")){
					sql.append("AND TB_CONSTRUCTION.CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("2")){
					sql.append("AND TB_BUSINESS.BUSINESS_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("3")){
					sql.append("AND TB_BUSINESS.BUSINESS_OPENING LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("4")){
					sql.append("AND TB_BUSINESS.BUSINESS_PRICE LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("5")){
					sql.append("AND TB_BUSINESS.BUSINESS_PERCENT LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("6")){
					sql.append("AND TB_BUSINESS.BUSINESS_WAY LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("7")){
					sql.append("AND TB_BUSINESS.BUSINESS_AREA LIKE CONCAT('%',?,'%')			\n");
				}
			}	
		}else if(searchKeyword.length() > 0){
			sql.append("AND (TB_CONSTRUCTION.CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')		\n");
			sql.append("OR TB_BUSINESS.BUSINESS_NAME LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR TB_BUSINESS.BUSINESS_OPENING LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR TB_BUSINESS.BUSINESS_PRICE LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR TB_BUSINESS.BUSINESS_PERCENT LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR TB_BUSINESS.BUSINESS_WAY LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR TB_BUSINESS.BUSINESS_AREA LIKE CONCAT('%',?,'%'))				\n");
		}
		sql.append("ORDER BY TB_BUSINESS.BUSINESS_NUM DESC												\n");
		sql.append("LIMIT ?, ?															\n");
		
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(nCnt++, ConstNum);
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
				}	
		}else if(searchKeyword.length() > 0){
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
			
			//System.out.println("View selectpstmt:   "+pstmt.toString());
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BusinessDTO vo = new BusinessDTO();
				vo.setBusiNum(rs.getInt("BUSINESS_NUM"));
				vo.setConstNum(rs.getInt("CONSTRUCTION_NUM"));
				vo.setConstName(rs.getString("TB_CONSTRUCTION.CONSTRUCTION_NAME"));
				vo.setBusiName(rs.getString("BUSINESS_NAME"));
				vo.setBusiOpening(rs.getString("BUSINESS_OPENING"));
				vo.setBusiPrice(rs.getString("BUSINESS_PRICE"));
				vo.setBusiPercent(rs.getString("BUSINESS_PERCENT"));
				vo.setBusiWay(rs.getString("BUSINESS_WAY"));
				vo.setBusiArea(rs.getString("BUSINESS_AREA"));
				vo.setCrtDate(rs.getString("CRT_DATE"));
				vo.setUdtDate(rs.getString("UDT_DATE"));

				list.add(vo);
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		return list;
	}
	
	public int deleteBusinessView(int no) throws SQLException {
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
		}
		return result;
	}
	
	public int insertBusinessAdd(int constNum, String busiName, String busiOpening,
			 String busiPrice, String busiPercent, String busiWay,
			String busiArea) throws SQLException {
		
		StringBuffer sql = new StringBuffer();
		int result = 0;
		sql.append("INSERT INTO TB_BUSINESS(CONSTRUCTION_NUM, BUSINESS_NAME, BUSINESS_OPENING, BUSINESS_PRICE, BUSINESS_PERCENT, BUSINESS_WAY, BUSINESS_AREA			\n");
		sql.append("	, CRT_DATE)										\n");
		sql.append("	  SELECT ?, ?, ?, ?, ?, ?, ?, now() FROM DUAL 					\n");
		sql.append("WHERE NOT EXISTS(SELECT CONSTRUCTION_NUM, BUSINESS_NAME FROM TB_BUSINESS WHERE CONSTRUCTION_NUM=? AND BUSINESS_NAME=?)				\n");
		try {
			pstmt = conn.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS);
			
			pstmt.setInt(1, constNum);
			pstmt.setString(2, busiName);
			pstmt.setString(3, busiOpening);
			pstmt.setString(4, busiPrice);
			pstmt.setString(5, busiPercent);
			pstmt.setString(6, busiWay);
			pstmt.setString(7, busiArea);
			pstmt.setInt(8, constNum);
			pstmt.setString(9, busiName);
			
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
	public int deleteBusiness(int BusiNum) throws SQLException {
		StringBuffer sql = new StringBuffer();
		int result = 0;
		sql.append("UPDATE TB_BUSINESS														\n");
		sql.append("SET 														\n");
		sql.append("	DEL_YN = 'Y' 												\n");
		sql.append("WHERE BUSINESS_NUM = ?													\n");
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, BusiNum);

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		return result;
	}
	
	
	
	public ArrayList<BusinessDTO> selectBusinessListExcel(String searchKeyword, int pageno, int totalcnt, String[] checked) throws SQLException {
		ArrayList<BusinessDTO> list = new ArrayList<BusinessDTO>();
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
		
		/*if(checked != null){
			for(int i=0; i<checked.length;i++){
			System.out.println("checked[]:    "+checked[i]);
			}
		}*/
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT 					\n");
		sql.append("TB_BUSINESS.BUSINESS_NUM,TB_BUSINESS.CONSTRUCTION_NUM , TB_CONSTRUCTION.CONSTRUCTION_NAME, TB_BUSINESS.BUSINESS_NAME,			\n");
		sql.append("TB_BUSINESS.BUSINESS_OPENING, TB_BUSINESS.BUSINESS_PRICE, TB_BUSINESS.BUSINESS_PERCENT, TB_BUSINESS.BUSINESS_WAY, TB_BUSINESS.BUSINESS_AREA, date_format(TB_BUSINESS.CRT_DATE, '%Y.%m.%d') as CRT_DATE, date_format(TB_BUSINESS.UDT_DATE, '%Y.%m.%d') as UDT_DATE	\n");
		sql.append("FROM 														\n");
		sql.append("TB_CONSTRUCTION JOIN TB_BUSINESS														\n");
		sql.append("WHERE TB_CONSTRUCTION.CONSTRUCTION_NUM=TB_BUSINESS.CONSTRUCTION_NUM AND TB_BUSINESS.DEL_YN <> 'Y' 														\n");
		if(checked != null){
			for(int i=0; i<checked.length; i++){
				if(checked[i].equals("1")){
					sql.append("AND TB_CONSTRUCTION.CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("2")){
					sql.append("AND TB_BUSINESS.BUSINESS_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("3")){
					sql.append("AND TB_BUSINESS.BUSINESS_OPENING LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("4")){
					sql.append("AND TB_BUSINESS.BUSINESS_PRICE LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("5")){
					sql.append("AND TB_BUSINESS.BUSINESS_PERCENT LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("6")){
					sql.append("AND TB_BUSINESS.BUSINESS_WAY LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("7")){
					sql.append("AND TB_BUSINESS.BUSINESS_AREA LIKE CONCAT('%',?,'%')			\n");
				}
			}	
		}else if(searchKeyword.length() > 0){
			sql.append("AND (TB_CONSTRUCTION.CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')		\n");
			sql.append("OR TB_BUSINESS.BUSINESS_NAME LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR TB_BUSINESS.BUSINESS_OPENING LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR TB_BUSINESS.BUSINESS_PRICE LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR TB_BUSINESS.BUSINESS_PERCENT LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR TB_BUSINESS.BUSINESS_WAY LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR TB_BUSINESS.BUSINESS_AREA LIKE CONCAT('%',?,'%'))				\n");
		}
		sql.append("ORDER BY TB_BUSINESS.BUSINESS_NUM DESC												\n");
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
				}	
		}else if(searchKeyword.length() > 0){
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
			//System.out.println("Busi selectpstmt:   "+pstmt.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BusinessDTO vo = new BusinessDTO();
				vo.setBusiNum(rs.getInt("BUSINESS_NUM"));
				vo.setConstNum(rs.getInt("CONSTRUCTION_NUM"));
				vo.setConstName(rs.getString("TB_CONSTRUCTION.CONSTRUCTION_NAME"));
				vo.setBusiName(rs.getString("BUSINESS_NAME"));
				vo.setBusiOpening(rs.getString("BUSINESS_OPENING"));
				vo.setBusiPrice(rs.getString("BUSINESS_PRICE"));
				vo.setBusiPercent(rs.getString("BUSINESS_PERCENT"));
				vo.setBusiWay(rs.getString("BUSINESS_WAY"));
				vo.setBusiArea(rs.getString("BUSINESS_AREA"));
				vo.setCrtDate(rs.getString("CRT_DATE"));
				vo.setUdtDate(rs.getString("UDT_DATE"));

				list.add(vo);
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		return list;
	}
	
	
	public ArrayList<BusinessDTO> selectBusinessListViewExcel(int ConstNum, int pageno, String searchKeyword, int totalcnt, String[] checked) throws SQLException {
		ArrayList<BusinessDTO> list = new ArrayList<BusinessDTO>();
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
		sql.append("TB_BUSINESS.BUSINESS_NUM,TB_BUSINESS.CONSTRUCTION_NUM , TB_CONSTRUCTION.CONSTRUCTION_NAME, TB_BUSINESS.BUSINESS_NAME,			\n");
		sql.append("TB_BUSINESS.BUSINESS_OPENING, TB_BUSINESS.BUSINESS_PRICE, TB_BUSINESS.BUSINESS_PERCENT, TB_BUSINESS.BUSINESS_WAY, TB_BUSINESS.BUSINESS_AREA, date_format(TB_BUSINESS.CRT_DATE, '%Y.%m.%d') as CRT_DATE, date_format(TB_BUSINESS.UDT_DATE, '%Y.%m.%d') as UDT_DATE	\n");
		sql.append("FROM 														\n");
		sql.append("TB_CONSTRUCTION JOIN TB_BUSINESS														\n");
		sql.append("WHERE TB_CONSTRUCTION.CONSTRUCTION_NUM=TB_BUSINESS.CONSTRUCTION_NUM AND TB_BUSINESS.DEL_YN <> 'Y' AND TB_BUSINESS.CONSTRUCTION_NUM=?										\n");
		if(checked != null){
			for(int i=0; i<checked.length; i++){
				if(checked[i].equals("1")){
					sql.append("AND TB_CONSTRUCTION.CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("2")){
					sql.append("AND TB_BUSINESS.BUSINESS_NAME LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("3")){
					sql.append("AND TB_BUSINESS.BUSINESS_OPENING LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("4")){
					sql.append("AND TB_BUSINESS.BUSINESS_PRICE LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("5")){
					sql.append("AND TB_BUSINESS.BUSINESS_PERCENT LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("6")){
					sql.append("AND TB_BUSINESS.BUSINESS_WAY LIKE CONCAT('%',?,'%')			\n");
				}
				if(checked[i].equals("7")){
					sql.append("AND TB_BUSINESS.BUSINESS_AREA LIKE CONCAT('%',?,'%')			\n");
				}
			}	
		}else if(searchKeyword.length() > 0){
			sql.append("AND (TB_CONSTRUCTION.CONSTRUCTION_NAME LIKE CONCAT('%',?,'%')		\n");
			sql.append("OR TB_BUSINESS.BUSINESS_NAME LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR TB_BUSINESS.BUSINESS_OPENING LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR TB_BUSINESS.BUSINESS_PRICE LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR TB_BUSINESS.BUSINESS_PERCENT LIKE CONCAT('%',?,'%')				\n");
			sql.append("OR TB_BUSINESS.BUSINESS_WAY LIKE CONCAT('%',?,'%')					\n");
			sql.append("OR TB_BUSINESS.BUSINESS_AREA LIKE CONCAT('%',?,'%'))				\n");
		}
		sql.append("ORDER BY TB_BUSINESS.BUSINESS_NUM DESC												\n");
		sql.append("LIMIT ?, ?															\n");
		
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(nCnt++, ConstNum);
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
				}	
		}else if(searchKeyword.length() > 0){
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
			
			//System.out.println("View selectpstmt:   "+pstmt.toString());
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BusinessDTO vo = new BusinessDTO();
				vo.setBusiNum(rs.getInt("BUSINESS_NUM"));
				vo.setConstNum(rs.getInt("CONSTRUCTION_NUM"));
				vo.setConstName(rs.getString("TB_CONSTRUCTION.CONSTRUCTION_NAME"));
				vo.setBusiName(rs.getString("BUSINESS_NAME"));
				vo.setBusiOpening(rs.getString("BUSINESS_OPENING"));
				vo.setBusiPrice(rs.getString("BUSINESS_PRICE"));
				vo.setBusiPercent(rs.getString("BUSINESS_PERCENT"));
				vo.setBusiWay(rs.getString("BUSINESS_WAY"));
				vo.setBusiArea(rs.getString("BUSINESS_AREA"));
				vo.setCrtDate(rs.getString("CRT_DATE"));
				vo.setUdtDate(rs.getString("UDT_DATE"));

				list.add(vo);
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}
		return list;
	}
	
	public BusinessDTO selectBusinessInfo(int BusiNum) throws SQLException {
		BusinessDTO dto = new BusinessDTO();

		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT 					\n");
		sql.append("TB_BUSINESS.BUSINESS_NUM,TB_BUSINESS.CONSTRUCTION_NUM , TB_CONSTRUCTION.CONSTRUCTION_NAME, TB_BUSINESS.BUSINESS_NAME,			\n");
		sql.append("TB_BUSINESS.BUSINESS_OPENING, TB_BUSINESS.BUSINESS_PRICE, TB_BUSINESS.BUSINESS_PERCENT, TB_BUSINESS.BUSINESS_WAY, TB_BUSINESS.BUSINESS_AREA, date_format(TB_BUSINESS.CRT_DATE, '%Y.%m.%d') as CRT_DATE, date_format(TB_BUSINESS.UDT_DATE, '%Y.%m.%d') as UDT_DATE	\n");
		sql.append("FROM 														\n");
		sql.append("TB_CONSTRUCTION JOIN TB_BUSINESS														\n");
		sql.append("WHERE TB_CONSTRUCTION.CONSTRUCTION_NUM=TB_BUSINESS.CONSTRUCTION_NUM AND TB_BUSINESS.BUSINESS_NUM=?										\n");
		
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, BusiNum);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setBusiNum(rs.getInt("BUSINESS_NUM"));
				dto.setConstNum(rs.getInt("CONSTRUCTION_NUM"));
				dto.setConstName(rs.getString("TB_CONSTRUCTION.CONSTRUCTION_NAME"));
				dto.setBusiName(rs.getString("BUSINESS_NAME"));
				dto.setBusiOpening(rs.getString("BUSINESS_OPENING"));
				dto.setBusiPrice(rs.getString("BUSINESS_PRICE"));
				dto.setBusiPercent(rs.getString("BUSINESS_PERCENT"));
				dto.setBusiWay(rs.getString("BUSINESS_WAY"));
				dto.setBusiArea(rs.getString("BUSINESS_AREA"));
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
	
	public int updateBusiness(int BusiNum, String busiName, String busiOpening, String busiPrice, String busiPercent, String busiWay, String busiArea) throws SQLException {
		StringBuffer sql = new StringBuffer();
		int result = 0;
		sql.append("UPDATE TB_BUSINESS															  \n");
		sql.append("SET BUSINESS_OPENING = ?, BUSINESS_PRICE = ?,			  \n");
		sql.append("BUSINESS_PERCENT = ?, BUSINESS_WAY = ?, BUSINESS_AREA = ?, 		  \n");
		sql.append("UDT_DATE = now()		  \n");
		sql.append("WHERE BUSINESS_NUM = ?												  	      \n");
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, busiOpening);
			pstmt.setString(2, busiPrice);
			pstmt.setString(3, busiPercent);
			pstmt.setString(4, busiWay);
			pstmt.setString(5, busiArea);
			pstmt.setInt(6, BusiNum);

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}

		return result;
	}
	
	public BusinessDTO selectBusinessViewInfo(int BusiNum, int ConstNum) throws SQLException {
		BusinessDTO dto = new BusinessDTO();

		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT 					\n");
		sql.append("TB_BUSINESS.BUSINESS_NUM,TB_BUSINESS.CONSTRUCTION_NUM , TB_CONSTRUCTION.CONSTRUCTION_NAME, TB_BUSINESS.BUSINESS_NAME,			\n");
		sql.append("TB_BUSINESS.BUSINESS_OPENING, TB_BUSINESS.BUSINESS_PRICE, TB_BUSINESS.BUSINESS_PERCENT, TB_BUSINESS.BUSINESS_WAY, TB_BUSINESS.BUSINESS_AREA, date_format(TB_BUSINESS.CRT_DATE, '%Y.%m.%d') as CRT_DATE, date_format(TB_BUSINESS.UDT_DATE, '%Y.%m.%d') as UDT_DATE	\n");
		sql.append("FROM 														\n");
		sql.append("TB_CONSTRUCTION JOIN TB_BUSINESS														\n");
		sql.append("WHERE TB_CONSTRUCTION.CONSTRUCTION_NUM=TB_BUSINESS.CONSTRUCTION_NUM AND TB_BUSINESS.BUSINESS_NUM=? AND TB_BUSINESS.CONSTRUCTION_NUM=?										\n");
		
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setInt(1, BusiNum);
			pstmt.setInt(2, ConstNum);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setBusiNum(rs.getInt("BUSINESS_NUM"));
				dto.setConstNum(rs.getInt("CONSTRUCTION_NUM"));
				dto.setConstName(rs.getString("TB_CONSTRUCTION.CONSTRUCTION_NAME"));
				dto.setBusiName(rs.getString("BUSINESS_NAME"));
				dto.setBusiOpening(rs.getString("BUSINESS_OPENING"));
				dto.setBusiPrice(rs.getString("BUSINESS_PRICE"));
				dto.setBusiPercent(rs.getString("BUSINESS_PERCENT"));
				dto.setBusiWay(rs.getString("BUSINESS_WAY"));
				dto.setBusiArea(rs.getString("BUSINESS_AREA"));
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
	
	public int updateBusinessView(int BusiNum, String busiName, String busiOpening, String busiPrice, String busiPercent, String busiWay, String busiArea) throws SQLException {
		StringBuffer sql = new StringBuffer();
		int result = 0;
		sql.append("UPDATE TB_BUSINESS															  \n");
		sql.append("SET BUSINESS_OPENING = ?, BUSINESS_PRICE = ?,			  \n");
		sql.append("BUSINESS_PERCENT = ?, BUSINESS_WAY = ?, BUSINESS_AREA = ?, 		  \n");
		sql.append("UDT_DATE = now()		  \n");
		sql.append("WHERE BUSINESS_NUM = ?												  	      \n");
		try {
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, busiOpening);
			pstmt.setString(2, busiPrice);
			pstmt.setString(3, busiPercent);
			pstmt.setString(4, busiWay);
			pstmt.setString(5, busiArea);
			pstmt.setInt(6, BusiNum);

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt);
		}

		return result;
	}
	
}