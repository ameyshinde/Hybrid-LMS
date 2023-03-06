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

import com.dao.AssignmentDAO;
import com.dao.SubmissionDAO;
import com.model.Assignment;
import com.model.Submission;

/**
 * Servlet implementation class StudentAssignServlet
 */
@WebServlet("/shome")
public class StudentAssignServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final String UPLOAD_DIRECTORY =  "/Users/ameyshinde/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/StudentAttendanceSystem/uploads/" + "submissions";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentAssignServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("uname") == null) {
			response.sendRedirect("student_login.jsp");
			return;
		}
		
		ArrayList<Assignment> assignment = new ArrayList<>();
		try {
			assignment = AssignmentDAO.getAssignment();
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("assignment", assignment);
		
		request.getRequestDispatcher("students_assignments.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("uname") == null) {
			response.sendRedirect("student_login.jsp");
			return;
		}
		request.removeAttribute("msg");
		
		
		int student_id = (int) session.getAttribute("student_id");
		String upload_file = null;
		
        if(ServletFileUpload.isMultipartContent(request)){
            try {
                List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
               
                for(FileItem item : multiparts){
                    if(!item.isFormField()){
                    	if(item.getName() != null && !item.getName().trim().equals("")) {
	                    	upload_file = new File("VIMEET"+"_Submission_" +item.getName()).getName();
	                        item.write(new File(UPLOAD_DIRECTORY + File.separator + upload_file));
                    	}
                    }
                }
            } catch (Exception ex) {
               ex.getStackTrace();
            }          
        }
        
		boolean status = true;
		request.removeAttribute("msg");
		
		if (request.getParameter("add-submission") == null) {
			status = false;
		}
		if (upload_file == null) {
			status = false;
		}
        
        if(status) {
			try {
				Submission submission = new Submission(Integer.parseInt(request.getParameter("add-submission")), student_id , upload_file, new Date());
				String res = SubmissionDAO.insertSubmision(submission);
				session.setAttribute("msg", res);
				response.sendRedirect("students_assignments.jsp");
			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("lmsg", "Submission Failure.");
				response.sendRedirect("students_assignments.jsp");
			}
        } else {
        	session.setAttribute("fmsg", "All fields are required.");
        	response.sendRedirect("students_assignments.jsp");
        }
        
	}

}
