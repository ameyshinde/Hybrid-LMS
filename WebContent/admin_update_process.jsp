<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.attendance.DatabaseConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page import="java.sql.*"%>
<%
String admin_id = request.getParameter("adminID");
String email = request.getParameter("email");

if (admin_id != null) {
	try {
		Connection con = DatabaseConnection.getConnection();
		Statement statement = con.createStatement();
		int updateStudent = statement.executeUpdate("Update admin set email='" + email + "' where id=" + admin_id);
		if (updateStudent > 0) {
	String message = "Record updated successfully";
	session.setAttribute("update-success-message", message);
	response.sendRedirect("adminProfile.jsp");
		} else {
	out.print("There is a problem in updating Record.");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
}
%>