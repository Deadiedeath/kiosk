<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "kiosk.*" %>




<%
	//일련번호 num 받기
	String num = request.getParameter("orderNum");
	//DTO객체 생성
	DTO dto = new DTO();
	//DAO객체 생성
	DAO dao = new DAO(application);
	
	int result = dao.deletePost(num);
	dao.close();
	if(result == 1){
		response.sendRedirect("account.jsp");
		
	}
	else{
		return;
	}
	
	/*
	//주어진 일련번호에 해당하는 기존 게시물 얻기
	dto = dao.selectView(num);
	//로그인된 사용자 ID얻기
	String sessionId = session.getAttribute("UserId").toString();
	//만약 작성자가 본인이라면 deletePost(dto) 실행
	if (sessionId.equals(dto.getId())) {      // 본인인지 확인
		dto.setNum(num);
   	 int result = dao.deletePost(dto);
   	 dao.close(); 
		if(result == 1){
			response.sendRedirect("List.jsp");
		}
	}

	//아니면 이전 페이지
	else {      
    JSFunction.alertBack("작성자 본인만 삭제할 수 있습니다.", out);
    return;
	}
	*/

%>