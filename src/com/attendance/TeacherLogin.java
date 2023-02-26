package com.attendance;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class TeacherLogin
 */
@WebServlet("/TeacherLogin")
public class TeacherLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uname = request.getParameter("uname");
		String pass = request.getParameter("password");
		try {
			HttpSession hs = request.getSession();
			Connection con = DatabaseConnection.getConnection();
			Statement st = con.createStatement();
			ResultSet resultset = st
					.executeQuery("select teacher_id,uname,password,status,teacher_name from faculty where uname='"
							+ uname + "' and password='" + pass + "'");
			if (resultset.next()) {
				if (resultset.getInt(4) == 1) {
					hs.setAttribute("uname", uname);
					hs.setAttribute("TeacherName", resultset.getString(2));
					hs.setAttribute("student_id", resultset.getInt(1));
					response.sendRedirect("after_facultyLogin.jsp");
				} else {
					String message = "Account not activated please inform admin to activate account.";
					hs.setAttribute("account-activation", message);
					response.sendRedirect("faculty_login.jsp");
				}
			} else {
				String message = "You have enter wrong credentials";
				hs.setAttribute("credential", message);
				response.sendRedirect("faculty_login.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}

