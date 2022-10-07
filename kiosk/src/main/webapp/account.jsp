<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="kiosk.*" %>
    <%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%
	DAO dao = new DAO(application);
	
	Map<String, Object> param = new HashMap<String, Object>();
	String category = request.getParameter("category");
	String foodname = request.getParameter("foodname");
	if(foodname != null){
		param.put("category", category);
		param.put("foodname", foodname);
	}
	
	List<DTO> lists = dao.selectList(param);
	dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<title>Insert title here</title>
</head>
<body>
 <div class="container">
    <div class="row">
      <div class="col">
        <div class="d-grid gap-2 d-md-block">
          <button class="btn btn-outline-secondary" type="button" name ="daily">일매출</button>
        </div>
      </div>

      <div class="col">
        <input type="button" name="monthly" value ="monthly" class="btn btn-outline-secondary">
      </div>
      <div class="col">
        <input type="button" name="cancel" value ="결재취소" class="btn btn-outline-primary">
      </div>
      <div class="col">
        <input type="button" name="daily" value ="나가기" class="btn btn-outline-danger">
      </div>
    </div>
    <div class="row">
      <div class="col">
        매출 표
      </div>
      <form method="get">
      <div class="col">
        <p><input type="date" name="init" id="">부터 <input type="date" name="init" id="">까지</p>
        <select name="category" id="">
          <option value="">카테고리</option>
        </select>
        <input type="text" name ="foodname">
        <input type="submit" value="search">
      </div>
      </form>
    </div>
    
    <div class="row">
      <table class="table table-striped">
        <tr>
          <th >순서</th>
          <th>일시</th>
          <th>주문번호</th>
          <th>테이블 번호</th>
          <th>주문내역</th>
          <th>수량</th>
          <th>합계</th>
        </tr>
        <%for(DTO dto : lists){ %>
        <tr>
          <td></td>
          <td><%=dto.getDate() %></td>
          <td><%=dto.getOrder_num() %></td>
          <td><%=dto.getTable_num() %></td>
          <td><%=dto.getFood_name() %></td>
          <td><%=dto.getQuat() %></td>
          <td><%=dto.getPrice() %></td>
        </tr>
        <%} %>
      </table>
    </div>
  </div>
</body>
</html>