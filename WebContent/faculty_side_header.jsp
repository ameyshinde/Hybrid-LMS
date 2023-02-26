<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark navbar-fixed-top">
<%
		if (session.getAttribute("uname") != null && session.getAttribute("uname") != "") {
		
%>
	<!-- Brand -->
	<img src="images/newlogo.png" width="200px" height="50px" /> <a
		class="navbar-brand" href="after_facultyLogin.jsp"><span class="glyphicon glyphicon-home"></span>&nbsp;Dashboard</a>
	<!-- Links -->
	<ul class="navbar-nav">

				<li class="nav-item dropdown"><a class="nav-link dropdown-toggle"
			href="#" id="navbardrop" data-toggle="dropdown"> Students
				Actions </a>
				<div class="dropdown-menu">
				<a class="dropdown-item" href="add_announcements.jsp">Add Announcements</a>
				<a class="dropdown-item" href="quizmanagement.jsp">Quiz Management</a>
				
			</div></li>
		<li class="nav-item dropdown"><a class="nav-link dropdown-toggle"
			href="#" id="navbardrop" data-toggle="dropdown"> Students
				Attendance </a>
				<div class="dropdown-menu">
				<a class="dropdown-item" href="attendance.jsp">Take Students Attendance</a>
				<a class="dropdown-item" href="check_todays_attendance.jsp">Check Today's Attendance Report</a>
				<a class="dropdown-item" href="check_daily_attendance_report.jsp">Check Date Wise Attendance Report</a>
			</div></li>
		<li class="nav-item dropdown"><a class="nav-link dropdown-toggle"
			href="#" id="navbardrop" data-toggle="dropdown">Attendance
				Reports</a>
			<div class="dropdown-menu">
				<a class="dropdown-item" href="attendance_report.jsp">Attendance Report</a> 
				<a class="dropdown-item" href="check_daily_attendance.jsp">Daily Attendance Report</a>
			    <a class="dropdown-item" href="monthly_attendance_report.jsp">Monthly Attendance Report</a>
			</div>
		</li>&emsp;
		<li class="nav-item"><a class="nav-link" href="faculty_reports.jsp">Reports</a></li>&emsp;&emsp;
		<li class="nav-item dropdown"><a class="nav-link dropdown-toggle"
			href="#" id="navbardrop" data-toggle="dropdown"><span class="glyphicon glyphicon-user"></span>&nbsp;<%=session.getAttribute("uname")%></a>
			<div class="dropdown-menu">
				<a class="dropdown-item" href="facultyProfile.jsp"><span class="glyphicon glyphicon-user"></span> My Profile</a>
				<a class="dropdown-item" href="change_faculty_password.jsp"><span class="glyphicon glyphicon-edit"></span> Change Password</a>
				<a class="dropdown-item" href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span> Logout</a>
			</div>
		</li>
	</ul>
</nav><br><br><br>
<%
} else {
	response.sendRedirect("index.jsp");
}
%>