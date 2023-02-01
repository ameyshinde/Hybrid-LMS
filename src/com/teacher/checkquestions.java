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

@WebServlet("/checkquestions")
public class checkquestions extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = 0;
		HttpSession session = request.getSession();
		String quiz_no = request.getParameter("quiz_no");
		String question = request.getParameter("question");
		String option1 = request.getParameter("option1");
		String option2 = request.getParameter("option2");
		String option3 = request.getParameter("option3");
		String option4 = request.getParameter("option4");
		String correctAnswer = request.getParameter("correctAnswer");
		try {
			Connection connection = DatabaseConnection.getConnection();
			Statement statement = connection.createStatement();
			int addquiz = statement.executeUpdate(
					"insert into quiz(quiz_no,question,option1,option2,option3,option4,correct_option) values('" + quiz_no
							+ "','" + question + "','" + option1 + "','" + option2 + "','" + option3 + "','" + option4
							+ "','" + correctAnswer + "')");
			if (addquiz > 0) {
				String sentquiz = "Question sent sucess.";
				session.setAttribute("quiz-apply", sentquiz);
				response.sendRedirect("add_Quiz.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
