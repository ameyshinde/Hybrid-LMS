package com.dao;

import java.sql.ResultSet;
import java.util.List;
import com.bean.MyProject;
import com.bean.Student;
import com.bean.ProjectReport;



public interface Dao {
	boolean signUpStudent(Student student);

	Student getStudent(String usn);

	boolean registerProject(MyProject project);

	List<MyProject> getStudentProject(String usn);

	boolean updateProject(int pid, String status, String feedback);

	MyProject getProjectByID(int pid);

	Student loginStudent(String email, String password);

	List<MyProject> getProjectsByStatus(String status) ;

	List<MyProject> getAllProjects();

	List<MyProject> searchProject(String str);

	boolean addReport(ProjectReport report);

	ResultSet getReport(int phase, String title); 

}

