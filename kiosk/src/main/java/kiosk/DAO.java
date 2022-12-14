package kiosk;

import java.util.List;
import java.util.Map;
import java.util.Vector;


import javax.servlet.ServletContext;

public class DAO extends JDBConnect {

	
	public DAO(ServletContext application) {
		super(application);
	}
		
	//게시물 수 확인
	public int selectCount(Map<String, Object> map) {
		int totalcount =0;
		//쿼리문 작성
		String query = "select count(*) from restaurant_order";
		
	if((map.get("init") != null  && map.get("end") != null)) {
			
			if((map.get("init") != ""  && map.get("end") !=  "")) {
				
				query += " where order_date between '" + map.get("init") + "' and '" + map.get("end") + "'";
				
				if( map.get("foodname") != null)
				{
					if( map.get("foodname") != "") {
						
					query += ", foodname "+  "like '%" + map.get("foodname") + "%'";}
					
				}
				}
			
		else {
						
			if(map.get("foodname") != null)
				
			{
				
				if(map.get("foodname") != "") {
					
				 query += " where foodname like '%" + map.get("foodname") + "%'";
				 
				}
				
			}
			}
	}
		//쿼리문 생성
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next(); //커서를 첫번째 행으로 이동
			rs.getInt(1); //첫번째 컬럼값을 가져옴
			totalcount = rs.getInt(1);//첫번째 컬럼값을 가져옴
			
		} catch (Exception e) {
			System.out.println("오류 오류 문제가 발생");
			e.printStackTrace();
		}
		
		
		
		return totalcount;
	}
	
	
	//조건에 맞는 DB검색 문
	public List<DTO> selectList(Map<String,Object> map){
		List<DTO> list = new Vector<DTO>();
		
		String query = "select * from restaurant_order ";
		
	if((map.get("init") != null  && map.get("end") != null)) {
			
			if((map.get("init") != ""  && map.get("end") !=  "")) {
				
				query += " where order_date between '" + map.get("init") + "' and '" + map.get("end") + "'";
				
				if( map.get("foodname") != null)
				{
					if( map.get("foodname") != "") {
						
					query += ", foodname "+  "like '%" + map.get("foodname") + "%'";}
					
				}
				}
			
		else {
						
			if(map.get("foodname") != null)
				
			{
				
				if(map.get("foodname") != "") {
					
				 query += " where foodname like '%" + map.get("foodname") + "%'";
				 
				}
				
			}
			}
	}
		System.out.println(query);
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()) {
				DTO dto = new DTO();
				dto.setOrderDate(rs.getString("order_date"));
				dto.setFoodName(rs.getString("food_name"));
				dto.setOrderNumber(rs.getString("order_number"));
				dto.setPrice(rs.getString("price"));
				dto.setQuantitiy(rs.getString("quantity"));
				dto.setTableNumber(rs.getString("table_number"));
				list.add(dto);
			}
			
		} catch (Exception e) {
			System.out.println("장부를 불러오는중 오류");
			e.printStackTrace();
		}
				
		return list;
	}
	
	
	public int deletePost(String num) {
		int result =0;
		
		String query = "delete from restaurant_order where ORDER_NUMBER = ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("삭제중 오류");
			e.printStackTrace();
		}
		
		
		return result;
		
		
	}
}
