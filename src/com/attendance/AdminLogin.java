package com.attendance;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.Base64;
import java.util.UUID;

/**
 * Servlet implementation class AdminLogin
 */
@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {

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
			String tokens = UUID.randomUUID().toString();
			HttpSession hs = request.getSession();
			Connection con = DatabaseConnection.getConnection();
			Statement st = con.createStatement();
			ResultSet resultset = st.executeQuery("select * from admin where uname='" + uname + "' AND password='"
					+ pass + "' OR password='" + hashedPassword + "'");
			if (resultset.next()) {
				hs.setAttribute("uname", uname);
				hs.setAttribute("TeacherName", resultset.getString(2));
				response.sendRedirect("after_adminLogin.jsp?_tokens='" + tokens + "'");
			} else {
				String message = "You have enter wrong credentials";
				hs.setAttribute("credential", message);
				response.sendRedirect("index.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
