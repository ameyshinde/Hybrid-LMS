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

@WebServlet("/StudentRegistration")
public class StudentRegistration extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		int student_id = 0;
		int status = 0;
		String sname = request.getParameter("sname");
		String cname = request.getParameter("collegeName");
		String mobile = request.getParameter("mobile");
		String address = request.getParameter("address");
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
		String branchName = request.getParameter("branchName");
		HttpSession hs = request.getSession();
		try {
			Connection con = DatabaseConnection.getConnection();
			Statement st = con.createStatement();
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM students WHERE uname = ?");
			stmt.setString(1, uname);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				String message = "Username Already Exist";
				hs.setAttribute("duplicate-message", message);
				response.sendRedirect("student_registration.jsp");
			} else {
				int i = st.executeUpdate(
						"insert into students(student_id,stud_name,college_name,branch,mobile,address,email,uname,password,status) values('"
								+ student_id + "','" + sname + "','" + cname + "','" + branchName + "','" + mobile
								+ "','" + address + "','" + email + "','" + uname + "','" + hashedPassword + "','"
								+ status + "')");
				if (i > 0) {
					String message = "Student register successfully.";
					hs.setAttribute("success-message", message);
					response.sendRedirect("student_registration.jsp");
				} else {
					String message = "Student registration fail";
					hs.setAttribute("fail-message", message);
					response.sendRedirect("student_registration.jsp");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
