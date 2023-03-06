package com.notes;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.attendance.DatabaseConnection;

@WebServlet("/UploadServlet")
@MultipartConfig
public class UploadServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int notes_id = 0;
		String uploader = (String) session.getAttribute("TeacherName");
		String Subject_code = (String) session.getAttribute("Subject_code");
		String Subject = (String) session.getAttribute("Subject");
		String Filetype = request.getParameter("filetype");
		Part p = request.getPart("notesfile");
		String remark = request.getParameter("remark");
		String fileName = p.getSubmittedFileName();
		

		

		try {

			Connection con = DatabaseConnection.getConnection();

			PreparedStatement ps = con.prepareStatement("insert into uploads(notes_id,Subject_code,Subject,FileName,remark,Filetype,Upload_date,Uploader) values(?,?,?,?,?,?,?,?)");
			ps.setInt(1, notes_id);
			ps.setString(2, Subject_code);
			ps.setString(3, Subject);
			ps.setString(4, fileName);
			ps.setString(5, remark);
			ps.setString(6, Filetype);
			ps.setDate(7, getCurrentDate());
			ps.setString(8, uploader);

			int i = ps.executeUpdate();

			if (i == 1) {

				String path = getServletContext().getRealPath("") + "files";
				System.out.println(path);

				File file = new File(path);

				p.write(path + File.separator + fileName);

				session.setAttribute("msg", "Notes added successfully");

				response.sendRedirect("add_notes.jsp");

			} else {
				session.setAttribute("msg", "Something went wrong");
				response.sendRedirect("add_notes.jsp");
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	public  java.sql.Date getCurrentDate() {
		java.util.Date today = new java.util.Date();
		return new java.sql.Date(today.getTime());
	}

}
