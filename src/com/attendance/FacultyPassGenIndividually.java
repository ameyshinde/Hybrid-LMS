package com.attendance;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class  Faculty PasswordGenerationIndividually
 */
@WebServlet("/FacultyPassGenIndividually")
public class FacultyPassGenIndividually extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String teacherId = request.getParameter("facultyId");
		HttpSession hs = request.getSession();
		ResultSet resultset = DatabaseConnection
				.getResultFromSqlQuery("select * from faculty where teacher_id='" + teacherId + "'");
		try {
			while (resultset.next()) {
				String password = DatabaseConnection.randompasswordgeneration();
				DatabaseConnection.insertUpdateFromSqlQuery(
						"update faculty set password='" + password + "' where teacher_id='" + teacherId + "' ");
				String message = "System generated password successfully.";
				hs.setAttribute("message-success", message);
			}
			response.sendRedirect("faculty_individual_password_generation.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
