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
import java.util.ArrayList; 
import com.attendance.DatabaseConnection;
import com.bean.Question;

@WebServlet("/saveQuiz")
public class saveQuiz extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		Integer time = (Integer) session.getAttribute("time");
		if (time == null) {
		      time = Integer.parseInt(request.getParameter("time"));
		    } else {
		      time--;
		    }
		    session.setAttribute("time", time);
		    if (time <= 0) {
		      response.sendRedirect("quiz_submit_result.jsp");
		      return;
		    }
		String uname = (String) session.getAttribute("uname");
		int sno = (Integer) session.getAttribute("sno");
		System.out.println("The username "+ uname +" is on the question " +sno);
		String atmt_ans = request.getParameter("myradio");
		String correct = request.getParameter("correct");

		try {
			Connection connection = DatabaseConnection.getConnection();
			String query = "insert into quiz_answers values(?,?,?,?)";
			String e = "";
			PreparedStatement st = connection.prepareStatement(query);
			if (((String) request.getParameter("myradio")) == null) {
				e = "Not Attempted";
				st.setInt(1, sno);
				st.setString(2,uname);
				st.setString(3, e);
				st.setString(4, correct);
			} else {
				e = atmt_ans;
				st.setInt(1, sno);
				st.setString(2,uname);
				st.setString(3, e);
				st.setString(4, correct);
			}
			st.executeUpdate();
			ArrayList<Integer> list = new ArrayList<>();
			list = (ArrayList) session.getAttribute("dbdata");
			System.out.println("Current Number of questions in DB " +list.size());
			if (sno == list.size()) {
				request.getRequestDispatcher("quiz_submit_result.jsp").forward(request, response);
			}
			connection.close();
			request.getRequestDispatcher("answersubmit.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
