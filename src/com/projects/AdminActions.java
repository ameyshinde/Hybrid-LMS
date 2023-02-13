package com.projects;

import java.io.IOException;
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
import com.bean.MyProject;

/**
 * Servlet implementation class AdminAction
 */
@WebServlet(urlPatterns = { "/pending", "/approved", "/rejected", "/update", "/viewproject", "/showallprojects" })
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
			if (dao.updateProject(id, status, feedback)) {
				session.setAttribute("msg", "Project Updates Sent successfully");
				response.sendRedirect("admin_projects_dashboard.jsp");
			} else {
				session.setAttribute("msg", "Something went wrong");
				response.sendRedirect("admin_projects_dashboard.jsp");
			}
		} else if (url.endsWith("showallprojects")) {
			list = dao.getAllProjects();
			session.setAttribute("status", "All");
			request.setAttribute("projects", list);
			RequestDispatcher rd = request.getRequestDispatcher("admin_showall_projects.jsp");
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}

