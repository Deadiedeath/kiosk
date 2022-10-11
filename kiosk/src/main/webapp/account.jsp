<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="kiosk.*" %>
    <%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	DAO dao = new DAO(application);


Map<String, Object> param = new HashMap<String, Object>();
String category = request.getParameter("category");
String foodname = request.getParameter("foodname");
String init = request.getParameter("init");
String end = request.getParameter("end");
if(foodname != null){
	param.put("init", init);
	param.put("end", end);
	param.put("category", category);
	param.put("foodname", foodname);
}
int totalCount = dao.selectCount(param);


int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
int pageSize =Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int totalPage = (int)Math.ceil((double)totalCount/pageSize);  //전체페이지 수
int pageNum =1;


	
	List<DTO> lists = dao.selectList(param);
	dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<title>매출 관리</title>
</head>
<body>
 <div class="container">
    <div class="row">
      <div class="col">
        <div class="d-grid gap-2 d-md-block">
          <button class="btn btn-outline-secondary" type="button" name ="daily" id="daily" >일매출</button>
        </div>
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
        <p><input type="date" name="init" id="init">부터 <input type="date" name="end" id="end">까지</p>
        <input type="text" name ="foodname" placeholder="음식이름을 입력하세요">
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
         <form method = "post" class = "table">
        <%
        int virtualNum = 0;
        int countNum =0;
        for(DTO dto : lists){ 
        virtualNum = totalCount - (((pageNum-1)*pageSize) + countNum++);%>
        
       
        <tr>
          <td><%=virtualNum %></td>
          <td><%=dto.getOrderDate() %></td>
          <td class="orderNum"><%=dto.getOrderNumber() %></td>
          <td><%=dto.getTableNumber() %></td>
          <td><%=dto.getFoodName() %></td>
          <td><%=dto.getQuantitiy() %></td>
          <td><%=dto.getPrice() %></td>
          <td><input type = "submit" onclick = deletePost()></td>
        </tr>
         <%} %>
         </form>
        <tr>
        <td><%=boardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI()) %></td>
         </tr>
       
      </table>
      
    </div>
  </div>
  
  <script>
    const today = new Date();
  document.querySelector('#daily').addEventListener('click', ()=>
  {
	 let init = document.querySelector("#init");
   let end = document.querySelector("#end");
   <%String now = new SimpleDateFormat("yyyy-MM-dd").format(new Date()); %>

   
    
   init.setAttribute("value", "<%=now%>");
    end.setAttribute("value","<%=now%>");
  }
  );
  
  let del = document.querySelectorAll(".delete");
  
  let orderNum = document.querySelectorAll(".orderNum");
  for(i=0; i<del.length; i++){
 	 del[i].addEventListener("click", function(){
 		console.log(orderNum[i]);
 	 })
  }
  
  function deletePost() {
	    var confirmed = confirm("정말로 삭제하겠습니까?"); 
	    if (confirmed) {
	        var form = document.writeFrm;       // 이름(name)이 "writeFrm"인 폼 선택
	        form.method = "post";               // 전송 방식 
	        form.action = "DeleteProcess.jsp?num=<%=dt.getNum()%>";  // 전송 경로
	        form.submit();                      // 폼값 전송
	    }
	}
  </script>
</body>
</html>