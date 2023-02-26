package com.email;

import java.io.IOException;
import java.sql.*;
import java.util.Properties;

import javax.print.*;
import java.io.PrintWriter;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.attendance.DatabaseConnection;

@WebServlet("/FacultyEmailSendingServlet")
public class FacultyEmailSendingServlet extends HttpServlet {
	private String host;
	private String port;
	private String user;
	private String pass;

	public void init() {
		// reads SMTP server setting from web.xml file
		ServletContext context = getServletContext();
		host = context.getInitParameter("host");
		port = context.getInitParameter("port");
		user = context.getInitParameter("user");
		pass = context.getInitParameter("pass");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// reads form fields

		Connection con = null;
		Statement statement = null;
		ResultSet resultset = null;
		int teacher_id = Integer.parseInt(request.getParameter("teacher_id"));
		String email = "";
		String uname = "";
		String password = "";
		String uname_password = "";
		try {
			con = DatabaseConnection.getConnection();
			statement = con.createStatement();
			resultset = statement
					.executeQuery("select email,uname,password from faculty where teacher_id='" + teacher_id + "'");
			while (resultset.next()) {
				email = resultset.getString(1);
				uname = resultset.getString(2);
				password = resultset.getString(3);
				uname_password = "Hi " + uname + "," + System.lineSeparator() + System.lineSeparator()
						+ "Your Faculty Login Portal" + System.lineSeparator() + "User Name: " + uname
						+ System.lineSeparator() + "Password: " + password + System.lineSeparator()
						+ System.lineSeparator() + "Thank you." + System.lineSeparator() + "Hybrid LMS Team.";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		String message = "Hybrid Learning Management System.";
		// String content = request.getParameter("content");
		String resultMessage = "";

		PrintWriter out = response.getWriter();
		try {
			EmailUtility.sendEmail(host, port, user, pass, email, message,
					uname_password);
			HttpSession session = request.getSession();
			resultMessage = "Faculty credentials user name & password send successfully via email.";
			session.setAttribute("mail-success", resultMessage);

		} catch (Exception ex) {
			ex.printStackTrace();
			resultMessage = "There were an error: " + ex.getMessage();
		} finally {
			// request.setAttribute("Message", resultMessage);
			response.sendRedirect("send_usrname_pass_to_faculty_in_mail.jsp");
		}
	}
}