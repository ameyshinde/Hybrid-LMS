<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<nav
	class="navbar navbar-expand-sm bg-dark navbar-dark navbar-fixed-top">
	<%
	if (session.getAttribute("uname") != null && session.getAttribute("uname") != "") {
	%>
	<!-- Brand -->
	<img src="images/newlogo.png" width="200px" height="50px" /> <a
		class="navbar-brand" href="after_adminLogin.jsp"><span
		class="glyphicon glyphicon-home"></span>&nbsp;Dashboard</a>
	<!-- Links -->
	<ul class="navbar-nav">
		<li class="nav-item dropdown"><a class="nav-link dropdown-toggle"
			href="#" id="navbardrop" data-toggle="dropdown"> Students
				Activity </a>
			<div class="dropdown-menu">
				<a class="dropdown-item" href="student_registration.jsp">Student
					System Registration</a> <a class="dropdown-item"
					href="students_data.jsp">Edit Students Information</a> <a
					class="dropdown-item" href="manage_students.jsp">Students
					Activation / Deactivation</a> <a class="dropdown-item"
					href="remove_students.jsp">Remove Student / Multiple Students</a> <a
					class="dropdown-item" href="students_notification.jsp">Student
					Notifications</a> <a class="dropdown-item"
					href="student_feedback_informations.jsp">Student Feedbacks</a> <a
					class="dropdown-item"
					href="students_password_change_dynamically.jsp">All Students
					Password Generation</a> <a class="dropdown-item"
					href="student_password_generation_individually.jsp">Students
					Password Generation Individually</a> <a class="dropdown-item"
					href="send_user_name_and_password_to_student_in_mail.jsp">Send
					User Name & Password to Students</a>
			</div></li>
		<li class="nav-item dropdown"><a class="nav-link dropdown-toggle"
			href="#" id="navbardrop" data-toggle="dropdown"> Faculty Activity
		</a>
			<div class="dropdown-menu">
				<a class="dropdown-item" href="faculty_registration.jsp">Faculty
					System Registration</a> <a class="dropdown-item"
					href="faculty_data.jsp">Edit Faculty Information</a> <a
					class="dropdown-item" href="manage_faculty.jsp">Faculty
					Activation / Deactivation</a> <a class="dropdown-item"
					href="remove_faculty.jsp">Remove Faculty / Multiple Faculty</a> <a
					class="dropdown-item" href="faculty_feedback_informations.jsp">Faculty
					Feedbacks</a> <a class="dropdown-item" href="faculty_password_view.jsp">All
					Faculty Password Generation</a> <a class="dropdown-item"
					href="faculty_individual_password_generation.jsp">Faculty
					Password Generation Individually</a> <a class="dropdown-item"
					href="send_usrname_pass_to_faculty_in_mail.jsp">Send User Name
					& Password to Faculty</a>
			</div></li>
		<li class="nav-item dropdown"><a class="nav-link dropdown-toggle"
			href="#" id="navbardrop" data-toggle="dropdown"> Admin Actions </a>
			<div class="dropdown-menu">
				<a class="dropdown-item" href="add_admin_announcements.jsp">Add
					Announcements</a> <a class="dropdown-item" href="allocate_faculty.jsp">Allocate
					Faculty</a> <a class="dropdown-item" href="fee_data.jsp"> Student
					Fee Details</a>
			</div></li>

		<!--  	<li class="nav-item dropdown"><a class="nav-link dropdown-toggle"
			href="#" id="navbardrop" data-toggle="dropdown">Attendance
				Reports</a>
			<div class="dropdown-menu">
				<a class="dropdown-item" href="attendance_report.jsp">Attendance Report</a> 
				<a class="dropdown-item" href="check_daily_attendance.jsp">Daily Attendance Report</a>
			    <a class="dropdown-item" href="monthly_attendance_report.jsp">Monthly Attendance Report</a>
			</div>
		</li> -->

		<li class="nav-item dropdown"><a class="nav-link dropdown-toggle"
			href="#" id="navbardrop" data-toggle="dropdown">Leave Management</a>
			<div class="dropdown-menu">
				<a class="dropdown-item" href="manage_student_leaves.jsp">New
					Leave Request</a> <a class="dropdown-item"
					href="approved_student_leave_request.jsp">Approved Request</a> <a
					class="dropdown-item" href="rejected_student_leave_request.jsp">Rejected
					Request</a>
			</div></li>
		<li class="nav-item dropdown"><a class="nav-link dropdown-toggle"
			href="#" id="navbardrop" data-toggle="dropdown">Project
				Management</a>
			<div class="dropdown-menu">
				<a class="dropdown-item" href="pending">Show Pending Project
					Approvals</a> <a class="dropdown-item" href="approved">Show
					Approved Projects</a> <a class="dropdown-item" href="rejected">Show
					Rejected Projects</a> <a class="dropdown-item" href="showallprojects">Show
					All Projects</a> <a class="dropdown-item"
					href="admin_allocated_project_guides.jsp">Show Guide Allocated
					Projects </a> <a class="dropdown-item"
					href="admin_unallocated_project_guides.jsp">Show Guide
					UnAllocated Project </a>
			</div></li>
		<li class="nav-item"><a class="nav-link"
			href="all_sas_pdf_report.jsp">Reports</a></li>
		<li class="nav-item dropdown"><a class="nav-link dropdown-toggle"
			href="#" id="navbardrop" data-toggle="dropdown"><span
				class="glyphicon glyphicon-user"></span>&nbsp;<%=session.getAttribute("uname")%></a>
			<div class="dropdown-menu">
				<a class="dropdown-item" href="adminProfile.jsp"><span
					class="glyphicon glyphicon-user"></span> My Profile</a> <a
					class="dropdown-item" href="admin_change_password.jsp"><span
					class="glyphicon glyphicon-edit"></span> Change Password</a> <a
					class="dropdown-item" href="logout.jsp"><span
					class="glyphicon glyphicon-log-out"></span> Logout</a>
			</div></li>
	</ul>
</nav>
<br>
<br>
<br>
<%
} else {
response.sendRedirect("index.jsp");
}
%>