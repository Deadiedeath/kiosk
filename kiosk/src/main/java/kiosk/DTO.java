package kiosk;

import java.sql.Date;

public class DTO {

	//멤버 변수
	
	private String category;	//카테고리
	private String foodName;	//음식 이름
	private String price;		//음식 가격
	private String explain;		//음식 설명
	private String oFile;		//원래 파일명
	private String sFile;		//저장 파일명
	
	private String orderNumber;	//주문 번호
	private String tableNumber;	//테이블 번호
	private String orderDate;		//일자
	private String quantitiy;	//음식 수량
	
	private String pw;			//처음 비밀번호

	
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getFoodName() {
		return foodName;
	}

	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getExplain() {
		return explain;
	}

	public void setExplain(String explain) {
		this.explain = explain;
	}

	public String getoFile() {
		return oFile;
	}

	public void setoFile(String oFile) {
		this.oFile = oFile;
	}

	public String getsFile() {
		return sFile;
	}

	public void setsFile(String sFile) {
		this.sFile = sFile;
	}

	public String getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}

	public String getTableNumber() {
		return tableNumber;
	}

	public void setTableNumber(String tableNumber) {
		this.tableNumber = tableNumber;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public String getQuantitiy() {
		return quantitiy;
	}

	public void setQuantitiy(String quantitiy) {
		this.quantitiy = quantitiy;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}
	
	
	
}
