package com.teacher;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.attendance.DatabaseConnection;

/**
 * Servlet implementation class FacultyFeedback
 */
@WebServlet("/FacultyFeedback")
public class FacultyFeedback extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int fid = 0;
		HttpSession session = request.getSession();
		String uname = (String) session.getAttribute("uname");
		String faculty_name = (String) session.getAttribute("TeacherName");
		String mobile = (String) session.getAttribute("TeacherNumber");
		String feedback = request.getParameter("message");
		try {
			Connection connection = DatabaseConnection.getConnection();
			Statement statement = connection.createStatement();
			int addfeedback = statement
					.executeUpdate("insert into faculty_feedback(fid,faculty_name,mobile,feedback,uname) values('" + fid
							+ "','" + faculty_name + "','" + mobile + "','" + feedback + "','" + uname + "')");
			if (addfeedback > 0) {
				String message = "Feedback submitted successfully.";
				session.setAttribute("faculty-feedback", message);
				response.sendRedirect("faculty_feedback.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}

