package com.attendance;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import java.util.Base64;

@WebServlet("/StudentPasswordChange")
public class StudentPasswordChange extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cpassword = request.getParameter("cpassword");
		MessageDigest digest;
		String hashedCurrentPassword = "";
		try {
			digest = MessageDigest.getInstance("SHA-256");
			byte[] hash = digest.digest(cpassword.getBytes(StandardCharsets.UTF_8));
			hashedCurrentPassword = Base64.getEncoder().encodeToString(hash);
		} catch (NoSuchAlgorithmException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		String password = request.getParameter("password");
		String hashedNewPassword = "";
		try {
			digest = MessageDigest.getInstance("SHA-256");
			byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
			hashedNewPassword = Base64.getEncoder().encodeToString(hash);
		} catch (NoSuchAlgorithmException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		String confpass = request.getParameter("confpass");
		String hashedConfirmPassword = "";
		try {
			digest = MessageDigest.getInstance("SHA-256");
			byte[] hash = digest.digest(confpass.getBytes(StandardCharsets.UTF_8));
			hashedConfirmPassword = Base64.getEncoder().encodeToString(hash);
		} catch (NoSuchAlgorithmException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		String pass = "";
		HttpSession session = request.getSession();
		try {
			Connection con = DatabaseConnection.getConnection();
			Statement statement = con.createStatement();
			ResultSet resultset = statement
					.executeQuery("select password from students where password='" + cpassword + "' OR password='"
							+ hashedCurrentPassword + "' AND uname='" + session.getAttribute("uname") + "'");
			if (resultset.next()) {
				pass = resultset.getString(1);
			}
			if (password.equals(confpass)) {
				if (pass.equals(cpassword) || pass.equals(hashedCurrentPassword)) {
					int i = statement.executeUpdate("update students set password='" + hashedNewPassword + "' where uname='"
							+ session.getAttribute("uname") + "' ");
					String message = "Password change successfully.";
					session.setAttribute("password-change-success", message);
					response.sendRedirect("change_student_password.jsp");
					statement.close();
					con.close();
				} else {
					String message = "Old password does not match.";
					session.setAttribute("password-change-fail", message);
					response.sendRedirect("change_student_password.jsp");
				}
			} else {
				String message = "New password and confirm password does not match.";
				session.setAttribute("password-not-match", message);
				response.sendRedirect("change_student_password.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
