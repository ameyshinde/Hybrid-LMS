package com.projects;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import java.time.LocalDate;
import java.util.Enumeration;

import com.dao.Dao;
import com.dao.DaoImpl;
import com.attendance.DatabaseConnection;
import com.bean.Notes;
import com.bean.ProjectReport;

/**
 * Servlet implementation class FileActions
 */
@WebServlet(urlPatterns = { "/reportreview", "/addreport", "/getreport", "/viewreport", "/addpmreport",
		"/visualreport" })
@MultipartConfig
public class FileActions extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Dao dao = new DaoImpl();
	public int BUFFER_SIZE = 1024 * 1000; // 100MB

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String url = request.getRequestURI();
		HttpSession session = request.getSession();
		if (url.endsWith("reportreview")) {
			String title = request.getParameter("title");
			session.setAttribute("title", title);
			response.sendRedirect("add_project_reports.jsp");

		} else if (url.endsWith("addreport")) {
			int phase = Integer.parseInt(request.getParameter("phase"));
			String usn = session.getAttribute("student_id").toString();
			String title = session.getAttribute("title").toString();
			final Part filePart = request.getPart("reportfile");
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

				final byte[] report = new byte[pdfFileBytes.available()];
				pdfFileBytes.read(report);

				ProjectReport pr = new ProjectReport(0, usn, phase, title, report);

				if (dao.addReport(pr)) {
					session.setAttribute("msg", "Project report added successfully");
					response.sendRedirect("add_project_reports.jsp");
				} else {
					session.setAttribute("msg", "Something went wrong");
					response.sendRedirect("add_project_reports.jsp");
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
		} else if (url.endsWith("getreport")) {
			String title = request.getParameter("title");
			session.setAttribute("title", title);
			response.sendRedirect("select_projectphase.jsp");
		} else if (url.endsWith("viewreport")) {

			String title = session.getAttribute("title").toString();
			int phase = Integer.parseInt(request.getParameter("phase"));

			ServletOutputStream sos;
			response.setContentType("application/pdf");
			response.setHeader("Content-disposition", "inline; filename=" + title + ".pdf");
			sos = response.getOutputStream();
			ResultSet rs = dao.getReport(phase, title);
			try {
				if (rs.next()) {
					byte[] res = rs.getBytes("report");
					sos.write(res);
				} else {
					session.setAttribute("lmsg", "Project Report not found.");
					response.sendRedirect("select_projectphase.jsp");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				sos.flush();
				sos.close();
			}
		} else if (url.endsWith("addpmreport")) {
			int reportid = 0;
			int phase = Integer.parseInt(request.getParameter("phase"));
			System.out.println(phase);
			String usn = session.getAttribute("student_id").toString();
			String title = session.getAttribute("title").toString();
			final Part filePart = request.getPart("reportfile");
			String fileName = filePart.getSubmittedFileName();
			InputStream pdfFileBytes = null;
			final PrintWriter writer = response.getWriter();

			try {
				Connection con = DatabaseConnection.getConnection();
				PreparedStatement ps = con
						.prepareStatement("insert into reports(USN,phase,report,title) values(?,?,?,?)");
				ps.setString(1, usn);
				ps.setInt(2, phase);
				ps.setString(3, fileName);
				ps.setString(4, title);
				int i = ps.executeUpdate();
				if (i == 1) {
					String path = getServletContext().getRealPath("") + "projectreports";
					System.out.println(path);
					File file = new File(path);
					filePart.write(path + File.separator + fileName);

					session.setAttribute("msg", "Report added successfully");

					response.sendRedirect("add_project_reports.jsp");

				} else {
					session.setAttribute("msg", "Something went wrong");
					response.sendRedirect("add_project_reports.jsp");
				}

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (url.endsWith("visualreport")) {
			int phase = Integer.parseInt(request.getParameter("phase"));
			String projtitle = (String) session.getAttribute("title");
			session.removeAttribute("fileName");
			ResultSet rs = DatabaseConnection.getResultFromSqlQuery(
					"select * from `reports` where `phase` = " + phase + " AND `title` = '" + projtitle + "'");
			try {
				while (rs.next()) {
					String fileName = rs.getString("report");
					System.out.println("fetched from datatbase the fileName"+fileName);
					int curr_phase = rs.getInt("phase");
					session.setAttribute("curr_phase", curr_phase);
					session.setAttribute("fileName", fileName);
				}
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			Object currPhaseObj = session.getAttribute("curr_phase");
			if (currPhaseObj != null) {
			int curr_phase = Integer.parseInt(session.getAttribute("curr_phase").toString());
			//System.out.println("from database fecthed"+curr_phase);
			int phaser = Integer.parseInt(request.getParameter("phase"));
			//System.out.println("from request parameter"+phaser);
			String title = session.getAttribute("title").toString();
			String fileName = (String) session.getAttribute("fileName");
			System.out.println(fileName);
			if (phaser == curr_phase && title != null && fileName != null) {
				System.out.println(fileName);
				String path = getServletContext().getRealPath("") + "projectreports" + File.separator + fileName;
				System.out.println(path);
				File file = new File(path);
				OutputStream os = null;
				ServletOutputStream sos;
				FileInputStream fis = null;

				try {
					if (file.exists()) {
						response.setHeader("Content-Disposition",
								String.format("attachment;filename=\"%s\"", file.getName()));

						response.setContentType("application/octet-stream");

						os = response.getOutputStream();
						fis = new FileInputStream(file);

						byte[] bf = new byte[BUFFER_SIZE];
						int byteRead = -1;
						while ((byteRead = fis.read(bf)) != -1) {
							os.write(bf, 0, byteRead);
						}

					} else {
						session.setAttribute("lmsg", "Project Report not found.");
						response.sendRedirect("select_projectphase.jsp");

						System.out.println("The file is not found" + fileName);
					}

				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if (fis != null) {
						fis.close();
					}
					os.flush();
					if (os != null) {
						os.close();
					}
				}
			} else {
				session.setAttribute("lmsg", "Project Report not found.");
				response.sendRedirect("select_projectphase.jsp");
			}
			}else {
				session.setAttribute("lmsg", "Project Report not found.");
				response.sendRedirect("select_projectphase.jsp");
			}
			// sos = response.getOutputStream();
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}