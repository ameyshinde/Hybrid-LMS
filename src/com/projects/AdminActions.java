package com.projects;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.Dao;
import com.dao.DaoImpl;
import com.attendance.DatabaseConnection;
import com.bean.MyProject;

/**
 * Servlet implementation class AdminAction
 */
@WebServlet(urlPatterns = { "/pending", "/approved", "/rejected", "/update", "/viewproject", "/showallprojects",
		"/allocateguide", "/showspecificguidesprojects" })
public class AdminActions extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Dao dao = new DaoImpl();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = request.getRequestURI();
		HttpSession session = request.getSession();
		List<MyProject> list = null;
		String status = null;
		if (url.endsWith("pending")) {
			status = "pending";
			list = dao.getProjectsByStatus(status);
			session.setAttribute("status", status);
			request.setAttribute("projects", list);
			RequestDispatcher rd = request.getRequestDispatcher("admin_pending_projects.jsp");
			rd.forward(request, response);
		} else if (url.endsWith("approved")) {
			status = "approved";
			list = dao.getProjectsByStatus(status);
			session.setAttribute("status", status);
			request.setAttribute("projects", list);
			RequestDispatcher rd = request.getRequestDispatcher("admin_approved_projects.jsp");
			rd.forward(request, response);
		} else if (url.endsWith("rejected")) {
			status = "rejected";
			list = dao.getProjectsByStatus(status);
			session.setAttribute("status", status);
			request.setAttribute("projects", list);
			RequestDispatcher rd = request.getRequestDispatcher("admin_rejected_projects.jsp");
			rd.forward(request, response);
		} else if (url.endsWith("viewproject")) {
			int id = Integer.parseInt(request.getParameter("id"));
			session.setAttribute("id", id);
			MyProject project = dao.getProjectByID(id);
			request.setAttribute("p", project);
			RequestDispatcher rd = request.getRequestDispatcher("admin_project_review.jsp");
			rd.forward(request, response);

		} else if (url.endsWith("update")) {
			int id = Integer.parseInt(session.getAttribute("id").toString());
			status = request.getParameter("status").toUpperCase();
			String feedback = request.getParameter("feedback");
			String tname = (String) session.getAttribute("TeacherName");
			System.out.println(tname);
			if (tname != null && !tname.equals("admin")) {
				if (dao.updateProject(id, status, feedback)) {
					session.setAttribute("msg", "Project Updates Sent successfully");
					response.sendRedirect("showspecificguidesprojects");
				} else {
					session.setAttribute("msg", "Something went wrong");
					response.sendRedirect("showspecificguidesprojects");
				}
			} else {
				if (dao.updateProject(id, status, feedback)) {
					session.setAttribute("msg", "Project Updates Sent successfully");
					response.sendRedirect("showallprojects");
				} else {
					session.setAttribute("msg", "Something went wrong");
					response.sendRedirect("showallprojects");
				}
			}
		} else if (url.endsWith("showallprojects")) {
			list = dao.getAllProjects();
			session.setAttribute("status", "All");
			request.setAttribute("projects", list);
			RequestDispatcher rd = request.getRequestDispatcher("admin_showall_projects.jsp");
			rd.forward(request, response);
		} else if (url.endsWith("showspecificguidesprojects")) {
			String allocated_guide = (String) session.getAttribute("TeacherName");
			list = dao.getSpecificeGuideProject(allocated_guide);
			session.setAttribute("status", "All");
			request.setAttribute("projects", list);
			RequestDispatcher rd = request.getRequestDispatcher("faculty_show_guide_projects.jsp");
			rd.forward(request, response);
		}

		else if (url.endsWith("allocateguide")) {
			Connection con = null;
			try {
				con = DatabaseConnection.getConnection();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int projectId = Integer.parseInt(request.getParameter("projectId"));
			System.out.println("the recieved proj id" + projectId);

			String guideName = request.getParameter("facultyName");
			String sql = "UPDATE projectinfo set Allocated_guide=? where pid=?";
			try {
				PreparedStatement pst = con.prepareStatement(sql);
				pst.setString(1, guideName);
				pst.setInt(2, projectId);
				int count = pst.executeUpdate();
				if (count > 1) {
					session.setAttribute("msg", "Project Guide Allocated successfully");
					response.sendRedirect("admin_allocated_project_guides.jsp");
				} else {
					session.setAttribute("msg", "Something went wrong");
					response.sendRedirect("admin_allocated_project_guides.jsp");
				}
			} catch (SQLException e) {

				e.printStackTrace();
			}
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
