package com.teacher;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.attendance.DatabaseConnection;


@WebServlet("/demoaddnotes")
public class Notes extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = 0;
		HttpSession session = request.getSession();
		String Subject_code = request.getParameter("subcode");
		String Subject = request.getParameter("subjectName");
		String Filetype = request.getParameter("filetype");
		final Part filePart = request.getPart("notesfile");
		LocalDate date = java.time.LocalDate.now();
		System.out.println(date);
		InputStream pdfFileBytes = null;
		final PrintWriter writer = response.getWriter();
		try {

			if (!filePart.getContentType().equals("application/pdf")) {
				writer.println("<br/> Invalid File");
				return;
			}

			else if (filePart.getSize() > 1048576 * 8) { // 2mb*5
				{
					writer.println("<br/> File size too big");
					return;
				}
			}

			pdfFileBytes = filePart.getInputStream(); // to get the body of the request as binary data

			final byte[] notesfile = new byte[pdfFileBytes.available()];
			pdfFileBytes.read(notesfile);
			try {
				Connection connection = DatabaseConnection.getConnection();
				Statement statement = connection.createStatement();
				int addnotes = statement.executeUpdate(
						"insert into notes(notes_id,Subject_code,Subject,Filetype,Upload_date,file) values('"
								+ id + "','" + Subject_code + "','" + Subject + "','" + Filetype + "', CURDATE(),'" + notesfile + "')");
				if (addnotes > 0) {
					String sentnotes = "Notes sent sucess.";
					session.setAttribute("notes-apply", sentnotes);
					response.sendRedirect("add_notes.jsp");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		} catch (FileNotFoundException fnf) {
			writer.println("You did not specify a file to upload");
			writer.println("<br/> ERROR: " + fnf.getMessage());

		} finally {
			if (pdfFileBytes != null) {
				pdfFileBytes.close();
			}
			if (writer != null) {
				writer.close();
			}

	}
}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
