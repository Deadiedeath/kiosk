package kiosk;

import java.sql.SQLException;
import java.util.*;
import common.DBConnPool;

public class DAO extends DBConnPool {

	// 공통메뉴화면_게시물 개수 반환
	public Integer common_selectCount(Map<String, Object> map) {
		int totalCount = 0;
		String query = "select count(*) from food where category = ";
		if (map.get("category") == null) {
			query += "'MAIN' ";
		} else {
			query += "'" + map.get("category") + "' ";
		}
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			totalCount = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("공통메뉴화면_게시물 개수 반환 오류 발생");
			e.printStackTrace();
		}
		return totalCount;
	}

	// 공통메뉴화면_food 전체 추출_미사용
	public List<DTO> common_selectAllMenu(Map<String, Object> map) {
		List<DTO> bbs = new Vector<DTO>();
		String query = "select * from food order by category";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);

			if (rs.next()) {
				DTO dto = new DTO();
				dto.setCategory(rs.getString(1));
				dto.setFoodName(query);
				dto.setPrice(rs.getString(3));
				dto.setExplain(rs.getString(4));
				bbs.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("공통메뉴화면_food 전체 추출 오류 발생");
			e.printStackTrace();
		}
		return bbs;
	}

	// 공통메뉴화면_카테고리별 목록을 반환하는 페이징 지원
	public List<DTO> common_selectCategory(Map<String, Object> map) {
		List<DTO> bbs = new Vector<DTO>();
		String query = "select * from (select Tb.*, rownum rNum from " + "(select * from food where category =";
		if (map.get("category") == null) {
			query += "'MAIN'";
		} else {
			query += "'" + map.get("category") + "' ";
		}
		query += "order by food_name asc )Tb) where rNum between ? and ?";

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();

			while (rs.next()) {
				DTO dto = new DTO();
				dto.setCategory(rs.getString(1));
				dto.setFoodName(rs.getString(2));
				dto.setPrice(rs.getString(3));
				dto.setExplain(rs.getString(4));
				bbs.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("공통메뉴화면_카테고리별 목록 오류 발생");
			e.printStackTrace();
		}
		return bbs;
	}

	// 공통메뉴화면_결제 후 order 입력
	public int insertOrder(List<DTO> orderlist) {
		int result = 0;
		try {
			for (DTO order : orderlist) {
				String query = "insert into RESTAURANT_ORDER values (" + "seq_order_num.nextval, ?, sysdate, ?, ?, ?)";
				psmt = con.prepareStatement(query);
				psmt.setString(1, order.getTableNumber());
				psmt.setString(2, order.getFoodName());
				psmt.setString(3, order.getQuantitiy());
				psmt.setString(4, order.getPrice());
				result = psmt.executeUpdate();
			}
		} catch (Exception e) {
			System.out.println("공통메뉴화면_결제 후 order 입력 부분 오류 발생");
			e.printStackTrace();
		}
		return result;
	}

	// 관리자화면_매출_게시물 수 확인
	public int manager_sales_selectCount(Map<String, Object> map) {
		int totalcount = 0;
		// 관리자화면_매출_게시물 수 확인_쿼리문 작성
		String query = "select count(*) from restaurant_order";
		if ((map.get("init") != null && map.get("end") != null)) {
			if ((map.get("init") != "" && map.get("end") != "")) {
				query += "where order_date between '" + map.get("init") + "' and '" + map.get("end") + "'";
				if (map.get("foodname") != null) {
					if (map.get("foodname") != "") {
						query += ", foodname " + "like '%" + map.get("foodname") + "%'";
					}
				}
			} else {
				if (map.get("foodname") != null) {
					if (map.get("foodname") != "") {
						query += " where foodname like '%" + map.get("foodname") + "%'";
					}
				}
			}
		}
		// 관리자화면_매출_게시물 수 확인_쿼리문 생성
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next(); // 커서를 첫번째 행으로 이동
			rs.getInt(1); // 첫번째 컬럼값을 가져옴
			totalcount = rs.getInt(1);// 첫번째 컬럼값을 가져옴

		} catch (Exception e) {
			System.out.println("관리자화면_매출_게시물 수 확인 오류 발생");
			e.printStackTrace();
		}
		return totalcount;
	}

	// 관리자화면_매출_조건에 맞는 DB검색문
	public List<DTO> manager_sales_selectList(Map<String, Object> map) {
		List<DTO> list = new Vector<DTO>();
		String query = "select * from restaurant_order ";
		if ((map.get("init") != null && map.get("end") != null)) {
			if ((map.get("init") != "" && map.get("end") != "")) {
				query += "where order_date between '" + map.get("init") + "' and '" + map.get("end") + "'";
				if (map.get("foodname") != null) {
					if (map.get("foodname") != "") {
						query += ", foodname " + "like '%" + map.get("foodname") + "%'";
					}
				}
			} else {
				if (map.get("foodname") != null) {
					if (map.get("foodname") != "") {
						query += " where foodname like '%" + map.get("foodname") + "%'";
					}
				}
			}
		}
		System.out.println(query);

		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				DTO dto = new DTO();
				dto.setOrderDate(rs.getString("order_date"));
				dto.setFoodName(rs.getString("food_id"));
				dto.setOrderNumber(rs.getString("order_number"));
				dto.setPrice(rs.getString("price"));
				dto.setQuantitiy(rs.getString("quantity"));
				dto.setTableNumber(rs.getString("table_number"));
				list.add(dto);
			}

		} catch (Exception e) {
			System.out.println("관리자화면_매출_조건에 맞는 DB검색문 오류 발생");
			e.printStackTrace();
		}

		return list;
	}

	// 관리자화면_메뉴_전체 추출
	public List<DTO> selectAllMenu(Map<String, Object> map) {
		List<DTO> bbs = new Vector<DTO>();
		String query = "select * from food ";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				DTO dto = new DTO();
				dto.setCategory(rs.getString(1));
				dto.setFoodName(rs.getString(2));
				dto.setPrice(rs.getString(3));
				dto.setExplain(rs.getString(4));
				bbs.add(dto);
			}
		} catch (Exception e) {
			System.out.println("관리자화면_메뉴_전체 추출 오류 발생");
			e.printStackTrace();
		}
		return bbs;
	}

	// 관리자화면_메뉴_새 메뉴 입력하기
	public int manager_menu_insertmenu(DTO dto) {
		int result = 0;

		try {
			String query = " insert into food " + " (  category, food_name, price, explain, ofile, sfile )  "
					+ " values ( ?, ?, ?, ?, ?, ? ) ";

			psmt = con.prepareStatement(query);

			psmt.setString(1, dto.getCategory());
			psmt.setString(2, dto.getFoodName());
			psmt.setString(3, dto.getPrice());
			psmt.setString(4, dto.getExplain());
			psmt.setString(5, dto.getoFile());
			psmt.setString(6, dto.getsFile());

			result = psmt.executeUpdate();

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("관리자화면_메뉴_새 메뉴 입력하기 오류 발생");
			e.printStackTrace();
		}

		return result;
	}

	// 관리자화면_메뉴_메뉴 수정
	public int updatemenu(DTO dto) {
		int result = 0;

		try {
			String query = " update food set "
					+ " category=?, food_name=?, price=?, explain=?, ofile=?, sfile=? where food_name=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getCategory());
			psmt.setString(2, dto.getFoodName());
			psmt.setString(3, dto.getPrice());
			psmt.setString(4, dto.getExplain());
			psmt.setString(5, dto.getoFile());
			psmt.setString(6, dto.getsFile());
			psmt.setString(7, dto.getFoodName());

			result = psmt.executeUpdate();

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("관리자화면_메뉴_메뉴 수정 오류 발생");
			e.printStackTrace();

		}
		return result;
	}
}
