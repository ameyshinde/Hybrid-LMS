<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.attendance.DatabaseConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page import="java.sql.*"%>
<%
	String teacher_id = request.getParameter("teacher_id");
	String tname = request.getParameter("tname");
	String branch = request.getParameter("branchname");
	String mobile = request.getParameter("mobile");
	String email = request.getParameter("email");
	String subject = request.getParameter("subject");
	String subject_code = request.getParameter("subjectcode");
	if (teacher_id != null) {
		try {
			Connection con = DatabaseConnection.getConnection();
			Statement statement = con.createStatement();
			int updateFaculty = statement.executeUpdate("Update faculty set teacher_name='" + tname+ "',department='" + branch + "',mobile='" + mobile + "',email='"+ email + "',Subject='"+ subject +"',Subject_code='" + subject_code + "' where teacher_id=" + teacher_id);
			if (updateFaculty > 0) {
				String message="Record updated successfully";
				session.setAttribute("update-success-message", message);
				response.sendRedirect("faculty_data.jsp");
			} else {
				out.print("There is a problem in updating Record.");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
%>