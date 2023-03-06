package com.attendance;

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

/**
 * Servlet implementation class StudentFeedback
 */
@WebServlet("/StudentFeedback")
public class StudentFeedback extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int fid = 0;
		HttpSession session = request.getSession();
		String uname = (String) session.getAttribute("uname");
		String full_name = (String) session.getAttribute("StudentName");
		String mobile = (String) session.getAttribute("StudentNumber");
		String feedback = request.getParameter("message");
		Enumeration<String> attributes = request.getSession().getAttributeNames();
		while (attributes.hasMoreElements()) {
		    String attribute = (String) attributes.nextElement();
		    System.out.println(attribute+" : "+request.getSession().getAttribute(attribute));
		}
		try {
			Connection connection = DatabaseConnection.getConnection();
			Statement statement = connection.createStatement();
			int addfeedback = statement
					.executeUpdate("insert into student_feedback(fid,full_name,mobile,feedback,uname) values('" + fid
							+ "','" + full_name + "','" + mobile + "','" + feedback + "','" + uname + "')");
			if (addfeedback > 0) {
				String message = "Feedback submitted successfully.";
				session.setAttribute("student-feedback", message);
				response.sendRedirect("student_feedback.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
