package com.fees;

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

@WebServlet("/UploadFeeDetail")
@MultipartConfig
public class UploadFeeDetail extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int fee_id = 0;
		String uploader = (String) session.getAttribute("StudentName");
		String branch = (String) session.getAttribute("Branch");
		String Feetype = request.getParameter("feetype");
		int amount =  Integer.parseInt(request.getParameter("amount"));
		System.out.println("the amount entered by student is"+amount);
		String utr = request.getParameter("utr");
		Part p = request.getPart("notesfile");
		String fileName = p.getSubmittedFileName();	

		try {

			Connection con = DatabaseConnection.getConnection();

			PreparedStatement ps = con.prepareStatement("insert into fee_Details(fee_id,StudentName,Branch,FeeType,Amount,UTRNo,FileName,Upload_date,Uploader) values(?,?,?,?,?,?,?,?,?)");
			ps.setInt(1, fee_id);
			ps.setString(2, uploader);
			ps.setString(3, branch);
			ps.setString(4, Feetype);
			ps.setInt(5, amount);
			ps.setString(6, utr);
			ps.setString(7, fileName);
			ps.setDate(8, getCurrentDate());
			ps.setString(9, uploader);

			int i = ps.executeUpdate();

			if (i == 1) {

				String path = getServletContext().getRealPath("") + "fees";
				System.out.println(path);

				File file = new File(path);

				p.write(path + File.separator + fileName);

				session.setAttribute("msg", "Fee Details added successfully");

				response.sendRedirect("add_feeDetails.jsp");

			} else {
				session.setAttribute("msg", "Something went wrong");
				response.sendRedirect("add_feeDetails.jsp");
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
