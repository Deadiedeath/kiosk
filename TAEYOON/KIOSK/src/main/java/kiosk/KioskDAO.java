package kiosk;

import java.util.Vector;
import kiosk.KioskDTO;
import javax.servlet.ServletContext;

import kiosk.JDBConnect;

public class KioskDAO extends JDBConnect {
	
	public KioskDAO(ServletContext application) {
		super(application); //application을 통해 web.xml에 정의해둔 오라클 정보를 가져와 db연동
	}

	public int insertmenu(KioskDTO dto) {
		int result=0;
		
		try {
			String query = " insert into food "
							+ " ( food_id, category, food_name, price, explain )  "
						    +" values (?, ?, ?, ?, ?) ";
			
			psmt=con.prepareStatement(query);
			psmt.setString(1, dto.getFid());
			psmt.setString(2, dto.getCategory());
			psmt.setString(3, dto.getFname());
			psmt.setString(4, dto.getPrice());
			psmt.setString(5, dto.getExplain());
			
			result=psmt.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("메뉴 등록중 뭔가 발생");
			e.printStackTrace();
		}
		
		return result;
		
	}
	
	
	
	
	
	
	
	
}
