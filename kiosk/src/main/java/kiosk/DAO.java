package kiosk;

import java.util.List;
import java.util.Map;
import java.util.Vector;
import kiosk.DTO;
import javax.servlet.ServletContext;
import kiosk.JDBConnect;

public class DAO extends JDBConnect {

	
	public DAO(ServletContext application) {
		super(application);
	}
		
	//조건에 맞는 DB검색 문
	public List<DTO> selectList(Map<String,Object> map){
		List<DTO> list = new Vector<DTO>();
		
		String query = "select * from restaurant_order ";
		
		if(map.get("init") !=null  && map.get("end") != null) {
			query += "where order_date between '" + map.get("init") + "' and '" + map.get("end") + "'";
			if(map.get("category") != null || map.get("foodname") != null)
			{
				 query += ", "+ map.get("category") + "like '%" + map.get("foodname") + "%'";
			}
		}else {
			if(map.get("category") != null || map.get("foodname") != null)
			{
				 query += ", "+ map.get("category") + "like '%" + map.get("foodname") + "%'";
			}
			
		}
		System.out.println(query);
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()) {
				DTO dto = new DTO();
				dto.setDate(rs.getString("order_date"));
				dto.setFood_name(rs.getString("food_id"));
				dto.setOrder_num(rs.getString("order_number"));
				dto.setPrice(rs.getString("price"));
				dto.setQuat(rs.getString("quantity"));
				dto.setTable_num(rs.getString("table_number"));
				list.add(dto);
			}
			
		} catch (Exception e) {
			System.out.println("장부를 불러오는중 오류");
			e.printStackTrace();
		}
				
		return list;
	}
}
