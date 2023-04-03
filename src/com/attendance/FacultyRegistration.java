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

@WebServlet("/FacultyRegistration")
public class FacultyRegistration extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		int teacher_id = 0;
		int status = 0;
		String tname = request.getParameter("tname");
		String branchName = request.getParameter("branchName");
		String mobile = request.getParameter("mobile");
		String email = request.getParameter("email");
		String uname = request.getParameter("uname");
		String pass = request.getParameter("pass");
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

		HttpSession hs = request.getSession();
		try {
			Connection con = DatabaseConnection.getConnection();
			Statement st = con.createStatement();
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM faculty WHERE uname = ?");
			stmt.setString(1, uname);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				String message = "Username Already Exist";
				hs.setAttribute("duplicate-message", message);
				response.sendRedirect("faculty_registration.jsp");
			} else {
				int i = st.executeUpdate(
						"insert into faculty(teacher_id,teacher_name,mobile,department,email,uname,password,status) values('"
								+ teacher_id + "','" + tname + "','" + mobile + "','" + branchName + "','" + email
								+ "','" + uname + "','" + hashedPassword + "','" + status + "')");
				if (i > 0) {
					String message = "Faculty register successfully.";
					hs.setAttribute("success-message", message);
					response.sendRedirect("faculty_registration.jsp");
				} else {
					String message = "Faculty registration fail";
					hs.setAttribute("fail-message", message);
					response.sendRedirect("faculty_registration.jsp");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
