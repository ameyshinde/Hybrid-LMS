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

@WebServlet("/result")
public class result extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = 0;
		HttpSession session = request.getSession();
		String uname = (String) session.getAttribute("uname");
		//int uid = (int) session.getAttribute("uid");
		String selectedAnswer = request.getParameter("optionsRadios");
		String selectedAnswerId = request.getParameter("question_id");
		try {
			Connection connection = DatabaseConnection.getConnection();
			Statement statement = connection.createStatement();
			int addquiz = statement.executeUpdate(
					"insert into quiz_selected(question_id,user_id,user_name,answer_id,answer_selected) values('" + id
							+ "','" + id + "','" + uname + "','" + selectedAnswerId + "','" + selectedAnswer + "')");
			if (addquiz > 0) {
				String sentquiz = "Question selected sucess.";
				session.setAttribute("quiz-apply", sentquiz);
				response.sendRedirect("take_Quiz.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
