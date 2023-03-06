package com.assignments;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.dao.SubmissionDAO;
import com.model.Submission;

/**
 * Servlet implementation class MySubmissionServlet
 */
@WebServlet("/my-submission")
public class MySubmissionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final String UPLOAD_DIRECTORY = "/Users/ameyshinde/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/StudentAttendanceSystem/uploads/"
			+ "submissions";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MySubmissionServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("uname") == null) {
			response.sendRedirect("index.jsp");
			return;
		}

		if (request.getParameter("submission-delete") != null) {
			String res = null;
			try {
				int id = Integer.parseInt(request.getParameter("submission-delete"));
				File file = new File(
						UPLOAD_DIRECTORY + File.separator + SubmissionDAO.getSubmissionById(id).getUpload_file());
				file.delete();
				res = SubmissionDAO.deleteSubmission(id);
			} catch (Exception e) {
				e.printStackTrace();
				res = "Submission is not deleted";
			}
			session.setAttribute("deletemsg", res);
		    response.sendRedirect(request.getContextPath() +  File.separator + "my-submission");
		    return; // add this to prevent any further processing of the request
		}

		ArrayList<Submission> submission = new ArrayList<>();

		try {
			int student_id = (int) session.getAttribute("student_id");
			submission = SubmissionDAO.getSubmission(student_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("submission", submission);
		request.getRequestDispatcher("students_assign_submission.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("uname") == null) {
			response.sendRedirect("index.jsp");
			return;
		}
		request.removeAttribute("msg");

		String upload_file = null;

		if (ServletFileUpload.isMultipartContent(request)) {
			try {
				List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);

				for (FileItem item : multiparts) {
					if (!item.isFormField()) {
						if (item.getName() != null && !item.getName().trim().equals("")) {
							upload_file = new File("VIMEET" + "_Submission_" + item.getName()).getName();
							item.write(new File(UPLOAD_DIRECTORY + File.separator + upload_file));
						}
					}
				}
			} catch (Exception ex) {
				ex.getStackTrace();
			}
		}

		boolean status = true;
		if (upload_file == null) {
			status = false;
		}

		if (status) {
			try {
				String update_id = request.getParameter("submission-update");
				if (update_id != null && !update_id.trim().equals("")) {
					Submission submission = SubmissionDAO.getSubmissionById(Integer.parseInt(update_id));
					if (upload_file != null) {
						submission.setUpload_file(upload_file);
						submission.setSubmit_date(new Date());
					}
					String res = SubmissionDAO.updateSubmission(submission);
					session.setAttribute("msg", res);
					response.sendRedirect("my-submission");
				}
			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("lmsg", "Submission is not updated.");
				response.sendRedirect("my-submission");
			}
		} else {
			session.setAttribute("fmsg", "Updation field can't be empty.");
			response.sendRedirect("my-submission");
		}
	}

}
