package com.assignments;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import com.model.Assignment;


/**
 * Servlet implementation class LecturerAssignServlet
 */
@WebServlet("/lhome")
public class LecturerAssignmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final String UPLOAD_DIRECTORY =  "/Users/ameyshinde/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/StudentAttendanceSystem/uploads/" + "assignments";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LecturerAssignmentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("uname") == null) {
			response.sendRedirect("index.jsp");
			return;
		}
		
		
		if(request.getParameter("assign-delete") != null) {
			String res = null;
			try {
				int id = Integer.parseInt(request.getParameter("assign-delete"));
				File file = new File(UPLOAD_DIRECTORY + File.separator + AssignmentDAO.getAssignment(id).getUpload_file());
				file.delete();
				res = AssignmentDAO.deleteAssignment(id);
				session.setAttribute("delemsg", res);
			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("fdelemsg", "Assignment is not deleted");
				
			}
			 // redirect the client to a new URL without the "assign-delete" parameter
		    response.sendRedirect(request.getContextPath() + "/add_assignments.jsp");
		    return; // add this to prevent any further processing of the request
		}
		
		ArrayList<Assignment> assignment = new ArrayList<>();
		
		try {
			int teacher_id = (int) session.getAttribute("teacher_id");
			assignment = AssignmentDAO.getLecturerAssignment(teacher_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("assignment", assignment);
		
		request.getRequestDispatcher("add_assignments.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("uname") == null) {
			response.sendRedirect("index.jsp");
			return;
		}
		request.removeAttribute("msg");
		
	
		int teacher_id = (int) session.getAttribute("teacher_id");
		String title = null;
		String subject = (String) session.getAttribute("Subject");
		int year = -99;
		int semester = -99;
		String due_date = null;
		String upload_file = null;
		
        if(ServletFileUpload.isMultipartContent(request)){
            try {
                List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                
                               for(FileItem item : multiparts){
                	
                    if(!item.isFormField()){
                    	if(item.getName() != null && !item.getName().trim().equals("")) {
	                    	upload_file = new File("VIMEET" + "_Assignment_" +item.getName()).getName();
	                    	String upload_file2 = item.getName();
	                    	System.out.println(upload_file2);
	        				System.out.println(UPLOAD_DIRECTORY);
	        				File file = new File(UPLOAD_DIRECTORY);
	                       item.write(new File(UPLOAD_DIRECTORY + File.separator + upload_file));
	                        System.out.println("The File is Successfully Added to server");
                    	}
                    } else {
                    	if(item.getFieldName().equals("title"))
                    		title = item.getString();
                    	else if(item.getFieldName().equals("subject"))
                    		subject = item.getString();
                    	else if(item.getFieldName().equals("year"))
                    		year = Integer.parseInt(item.getString());
                    	else if(item.getFieldName().equals("semester"))
                    		semester = Integer.parseInt(item.getString());
                    	else if(item.getFieldName().equals("due_date"))
                    		due_date = item.getString();
                    }
                }
            } catch (Exception ex) {
               ex.getStackTrace();
            }          
        }
        
        
        boolean status = true;
        try {
            Date date = new SimpleDateFormat("yyyy-MM-dd").parse(due_date);
            Date today = new Date();

            if (date.before(today)) {
                status = false;
            }
        } catch (ParseException e1) {
            e1.printStackTrace();
        }
		if (title == null || title.trim().equals("")) {
			status = false;
		}
		if (subject == null || subject.trim().equals("")) {
			status = false;
		}
		if (year < 1 || year > 4) {
			status = false;
		}
		if (semester < 1 || semester > 8) {
			status = false;
		}
		if (due_date == null) {
			status = false;
		}
        String subject2 = (String) session.getAttribute("Subject");
        if(status) {
			try {
				Assignment assignment = new Assignment(title, subject2, year, semester, new Date(),new SimpleDateFormat("yyyy-MM-dd").parse(due_date) , upload_file, teacher_id);

				String res = null;
				String update_id = request.getParameter("assign-update");
				if (update_id != null && !update_id.trim().equals("")) {
					assignment.setId(Integer.parseInt(update_id));
					if(upload_file == null) {
						upload_file = AssignmentDAO.getAssignment(Integer.parseInt(update_id)).getUpload_file();
						assignment.setUpload_file(upload_file);
					}
					res = AssignmentDAO.updateAssignment(assignment);
				} else {
					res = AssignmentDAO.insertAssignment(assignment);
				}
				session.setAttribute("msg", res);
				response.sendRedirect("add_assignments.jsp");
			} catch (Exception e) {
				e.printStackTrace();
				session.setAttribute("lmsg", "Assignment is not inserted");
				response.sendRedirect("add_assignments.jsp");
			}
        } else {
        	session.setAttribute("fmsg", "Please Enter All the Fields  Correctly ");
        	response.sendRedirect("add_assignments.jsp");
        }
        
	}

}
