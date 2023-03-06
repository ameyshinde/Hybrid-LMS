package com.notes;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.attendance.DatabaseConnection;
@WebServlet("/DeleteServlet")

public class DeleteServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String filePath = request.getParameter("fileName");
		
		File fileToDelete = new File(getServletContext().getRealPath("") + "files" + File.separator + filePath);
		System.out.println(fileToDelete);
		if(fileToDelete.exists()) {
			fileToDelete.delete();
			response.sendRedirect("add_notes.jsp");
		} else {
			response.getWriter().println("File not found!");
		}
		
		try {
			Connection connection = DatabaseConnection.getConnection();
			
			PreparedStatement ps = connection.prepareStatement("delete from uploads where FileName=?");
			ps.setString(1,filePath);
			int i = ps.executeUpdate();
			if (i == 1) {
				session.setAttribute("lmsg", "Notes deleted successfully");
				response.sendRedirect("add_notes.jsp");
			}
			else
			{
				session.setAttribute("lmsg", "Something went wrong");
				response.sendRedirect("add_notes.jsp");
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}
}
