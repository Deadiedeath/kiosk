<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "board.BoardDAO" %>
<%@ page import = "board.boardDTO" %>
<%@ page import = "board.JSFunction" %>
<%@ include file = "isLoggedin.jsp" %>

<%
	//일련번호 num 받기
	String num = request.getParameter("num");
	//DTO객체 생성
	boardDTO dto = new boardDTO();
	//DAO객체 생성
	BoardDAO dao = new BoardDAO(application);
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
	

%>