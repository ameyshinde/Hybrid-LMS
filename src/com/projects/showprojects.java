package com.projects;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.MyProject;
import com.dao.Dao;
import com.dao.DaoImpl;

@WebServlet("/showmyprojects")
public class showprojects extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	private Dao dao = new DaoImpl();
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		List<MyProject> list = dao.getStudentProject(session.getAttribute("student_id").toString());
		request.setAttribute("myprojects", list);
		RequestDispatcher rd = request.getRequestDispatcher("myprojects.jsp");
		rd.forward(request, response);
	
	}
}


