package com.projects;

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

@WebServlet("/addnewproject")
public class Addnewproject extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = 0;
		HttpSession session = request.getSession();
		int ido = (int) session.getAttribute("student_id");
		String usn = Integer.toString(ido);
		String projectname = request.getParameter("ptitle");
		String projectdomain = request.getParameter("type");
		String abstarct = request.getParameter("abs");
		String team = request.getParameter("team");
		
		
		try {
			Connection connection = DatabaseConnection.getConnection();
			String sql = "INSERT INTO PROJECTINFO (usn,projecttitle,type,abstract,team) values (?,?,?,?,?)";
			PreparedStatement pst = connection.prepareStatement(sql);
			pst.setString(1, usn);
			pst.setString(2, projectname);
			pst.setString(3, projectdomain);
			pst.setString(4, abstarct);
			pst.setString(5, team);
			int count = pst.executeUpdate();
			
			if (count > 0) {
				String sentnotice = "Project sent sucess.";
				session.setAttribute("project-apply", sentnotice);
				response.sendRedirect("add_project_details.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}


