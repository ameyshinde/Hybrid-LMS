package com.teacher;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.attendance.DatabaseConnection;

@WebServlet("/Announcements")
public class Announcements extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = 0;
		HttpSession session = request.getSession();
		//String name = (String) session.getAttribute("uname");
		//String sender = name;
		String subject = request.getParameter("subject");
		String notice = request.getParameter("notice");
		String sender = (String) session.getAttribute("TeacherName");
		
		try {
			Connection connection = DatabaseConnection.getConnection();
			Statement statement = connection.createStatement();
			int addnotice = statement.executeUpdate(
					"insert into notice(notice_id,subject,notice,sender,notice_date) values('"
							+ id + "','" + subject + "','" + notice + "','" + sender + "',CURDATE())");
			if (addnotice > 0) {
				String sentnotice = "Notice sent sucess.";
				session.setAttribute("notice-apply", sentnotice);
				response.sendRedirect("add_announcements.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
