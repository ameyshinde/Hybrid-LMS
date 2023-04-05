package com.attendance;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class StudentLogin
 */
@WebServlet("/StudentLogin")
public class StudentLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uname = request.getParameter("uname");
		String pass = request.getParameter("password");
		MessageDigest digest;
		String hashedPassword = "";
		try {
			digest = MessageDigest.getInstance("SHA-256");
			byte[] hash = digest.digest(pass.getBytes(StandardCharsets.UTF_8));
			hashedPassword = Base64.getEncoder().encodeToString(hash);
		} catch (NoSuchAlgorithmException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			HttpSession hs = request.getSession();
			Connection con = DatabaseConnection.getConnection();
			PreparedStatement ps = con.prepareStatement(
					"SELECT student_id, uname, password, status, stud_name, mobile, email, branch FROM students WHERE uname=? AND (password=? OR password=?)");
			ps.setString(1, uname);
			ps.setString(2, hashedPassword);
			ps.setString(3, pass);
			ResultSet resultset = ps.executeQuery();
			if (resultset.next()) {
				if (resultset.getInt(4) == 1) {
					hs.setAttribute("uname", uname);
					hs.setAttribute("student_id", resultset.getInt(1));
					hs.setAttribute("StudentName", resultset.getString(5));
					hs.setAttribute("StudentNumber", resultset.getString(6));
					hs.setAttribute("StudentEmail", resultset.getString(7));
					hs.setAttribute("Branch", resultset.getString(8));
					response.sendRedirect("after_studentLogin.jsp");
				} else {
					String message = "Account not activated please inform admin to activate account.";
					hs.setAttribute("account-activation", message);
					response.sendRedirect("student_login.jsp");
				}
			} else {
				String message = "You have entered wrong credentials";
				hs.setAttribute("credential", message);
				response.sendRedirect("student_login.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
