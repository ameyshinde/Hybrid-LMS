<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark navbar-fixed-top">
<%
		if (session.getAttribute("uname") != null && session.getAttribute("uname") != "") {
		
%>
	<!-- Brand -->
	<img src="images/newlogo.png" width="200px" height="50px" />
	<a class="navbar-brand" href="after_studentLogin.jsp"><span class="glyphicon glyphicon-home"></span>&nbsp;Dashboard</a>
	<!-- Links -->
	<ul class="navbar-nav">
	<li class="nav-item dropdown"><a class="nav-link dropdown-toggle"
			href="#" id="navbardrop" data-toggle="dropdown"> Students
				Course Details </a>
			<div class="dropdown-menu">
				<a class="dropdown-item" href="students_announcement.jsp">Student Announcement/Notification</a>
				<a class="dropdown-item" href="checkoutquiz.jsp">Student Available Test</a>
				<a class="dropdown-item" href="show_available_Quiz.jsp">Students Activation / Deactivation</a>
				<a class="dropdown-item" href="">Remove Student / Multiple Students</a> 
				<a class="dropdown-item" href="">Student Notifications</a>
				<a class="dropdown-item" href="">Student Feedbacks</a>
				<a class="dropdown-item" href="">All Students Password Generation</a> 
				<a class="dropdown-item" href="">Students Password Generation Individually</a>
				<a class="dropdown-item" href="">Send User Name & Password to Students</a>
			</div>
		</li>
		<li class="nav-item"><a class="nav-link" href="student_profile.jsp">Student Profile</a></li>
		<li class="nav-item"><a class="nav-link" href="change_student_password.jsp">Change Password</a></li>
		<li class="nav-item"><a class="nav-link" href="check_own_attendance.jsp">Attendance Report</a></li>
		<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">Inquiry/Updation</a>
			<div class="dropdown-menu">
				<a class="dropdown-item" href="student_inquiry.jsp">Student Complaint/Any Updation</a>
				<a class="dropdown-item" href="complaint_issue_result.jsp">Complaint Or Issue Result</a>
			</div>
		</li>
		<li class="nav-item dropdown"><a class="nav-link dropdown-toggle"
			href="#" id="navbardrop" data-toggle="dropdown">Leave Section</a>
			<div class="dropdown-menu">
				<a class="dropdown-item" href="apply_for_leave.jsp">Apply For Leave</a> 
				<a class="dropdown-item" href="leave_status_report.jsp">Leave Status Report</a>
			</div>
		</li>
		<li class="nav-item"><a class="nav-link"
			href="student_feedback.jsp">Feedback</a></li>
		
		<li class="nav-item dropdown"><a class="nav-link dropdown-toggle"
			href="#" id="navbardrop" data-toggle="dropdown"><span class="glyphicon glyphicon-user"></span> <%=session.getAttribute("uname")%></a>
			<div class="dropdown-menu">
				<a class="dropdown-item" href="logout.jsp">Logout</a>
			</div></li>
		<!-- Dropdown -->
	</ul>
</nav><br><br><br><%
} else {
	response.sendRedirect("student_login.jsp");
}
%>