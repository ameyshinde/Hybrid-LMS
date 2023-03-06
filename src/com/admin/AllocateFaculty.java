package com.admin;


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.attendance.DatabaseConnection;

@WebServlet("/AllocateFaculty")
public class AllocateFaculty extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String subject = request.getParameter("subjectName");
		String subject_code = request.getParameter("subjectCode");
		String allocated_faculty = request.getParameter("facultyName");
		try {
			Connection connection = DatabaseConnection.getConnection();
			PreparedStatement ps = connection.prepareStatement("Update faculty set Subject=? , Subject_code=? where teacher_name=?");
			ps.setString(1, subject);
			ps.setString(2, subject_code);
			ps.setString(3, allocated_faculty);
			int i = ps.executeUpdate();
			if (i > 0) {
				String faculty_allocate = "Faculty Allocated Sucessfully.";
				session.setAttribute("allocation-apply", faculty_allocate);
				response.sendRedirect("allocate_faculty.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}

