<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@page import = "kiosk.DAO" %>
    <%@page import = "kiosk.DTO" %>
    <%@ page import = "com.oreilly.servlet.*" %>
    <%@ page import = "com.oreilly.servlet.multipart.*" %>
    <%@ page import = "java.util.*" %>
    <%@ page import = "java.io.*" %>
	<%@ page import="java.text.SimpleDateFormat"%>
  
  
  <%
  //이미지 업로드
  String saveDirectory = application.getRealPath("/Uploads"); 
  int maxPostSize = 10 * 1024 * 1000;
  String encoding = "UTF-8";
  
  try{
	    MultipartRequest mr = new MultipartRequest(request, saveDirectory,
                									maxPostSize, encoding);
	  
	  String fileName = mr.getFilesystemName("img");
	  String ext = fileName.substring(fileName.lastIndexOf("."));
	  String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
	  String newFilename = now + ext;
	  
	  File oldFile = new File(saveDirectory + File.separator + fileName);
	  File newFile = new File(saveDirectory + File.separator + newFilename);
	  oldFile.renameTo(newFile);
	  
	  
	  String category = mr.getParameter("category");
	  String foodName = mr.getParameter("foodName");
	  String price = mr.getParameter("price");
	  String explain = mr.getParameter("explain");
	  
	  
	  
	  DTO dto = new DTO();
	  
	  dto.setCategory(category);
	  dto.setFoodName(foodName);
	  dto.setPrice(price);	 
	  dto.setExplain(explain);
	  dto.setoFile(fileName);
	  dto.setsFile(newFilename);
	  
	  
	  DAO dao = new DAO();
	  dao.manager_menu_insertmenu(dto);
	  dao.close();
	  
	  
	  
	  response.sendRedirect("menumana.jsp");
	  
	  
	  
  }catch(Exception e){
	  e.printStackTrace();
	  request.setAttribute("errorMessage", "메뉴 업로드 오류");
	  request.getRequestDispatcher("menumodi.jsp").forward(request,response);
	  
  } 
  
  
  %>  
  
  
  
  

  
  
