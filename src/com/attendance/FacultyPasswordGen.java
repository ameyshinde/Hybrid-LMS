package com.attendance;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;

/**
 * Servlet implementation class PasswordGeneration
 */
@WebServlet("/facultyPasswordGen")
public class FacultyPasswordGen extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		

		ResultSet rs = DatabaseConnection.getResultFromSqlQuery("select * from faculty");
		try {
			HttpSession hs = request.getSession();
			while (rs.next()) {
				String password = DatabaseConnection.randompasswordgeneration();
				DatabaseConnection.insertUpdateFromSqlQuery("update faculty set password='" + password
						+ "' where teacher_id='" + rs.getInt(1) + "' ");
				String message = "System generated all faculty password successfully.";
				hs.setAttribute("message-success", message);
			}
			response.sendRedirect("faculty_password_view.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
