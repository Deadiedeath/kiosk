<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
        <%@ page import="kiosk.*" %>
    <%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import = "java.time.LocalDate" %>
<%DAO dao = new DAO(application);

	Map<String, Object> param = new HashMap<String, Object>();
	String result = request.getParameter("result");
	LocalDate date = LocalDate.now();
	if(result.equals("daily")){
		param.put("init", date);
		param.put("end", date);
		List<DTO> lists = dao.selectList(param);
	}
	else{
		
	}
%>