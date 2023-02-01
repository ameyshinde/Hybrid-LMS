package com.teacher;

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

@WebServlet("/deleteQuiz")
public class deleteQuiz extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		

		try {
			if (request.getParameter("delete") != null) {
			    session.setAttribute("delete", request.getParameter("delete"));
			    int del = Integer.parseInt((String)session.getAttribute("delete"));
			    Connection connection = DatabaseConnection.getConnection();
			    String query = "delete from quiz where quiz_no=?";
			    PreparedStatement ps = connection.prepareStatement(query);
			    ps.setInt(1,del);
			    int deletequiz = ps.executeUpdate();
			    connection.close();
			    System.out.println("Question deleted!!");
			    session.removeAttribute("delete");
			    response.sendRedirect("quizmanagement.jsp");
			    
			    if(deletequiz>0)
				{
			    	String deleteupdate = "Question deleted sucess.";
					session.setAttribute("quiz-updates", deleteupdate);
					response.sendRedirect("quizmanagement.jsp");
				}
			} 
			else {
			    System.out.println("No question selected for deletion.");
			}
			

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
