<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.attendance.DatabaseConnection"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.util.Random"%>
<%@page import="java.util.UUID"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Hybrid LMS</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css" />

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #F0F0F0";>
	<%
	if (session.getAttribute("uname") != null && session.getAttribute("uname") != "") {
	%>
	<jsp:include page="student_side_header.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="panel panel-default shadow p-3 mb-5">
			<div class="panel-body">
				<%
				ResultSet resultset = DatabaseConnection.getResultFromSqlQuery("select count(*) from uploads");
				resultset.next();
				int count = resultset.getInt(1);
				%>
				<div class="alert alert-info shadow p-3 mb-5"
					style="text-transform: uppercase">Student Course details /
					Access Study Material</div>
				<%
				String success = (String) session.getAttribute("lmsg");
				if (success != null) {
					session.removeAttribute("lmsg");
				%>
				<div class='alert alert-success' id='success'>Notes Opened
					Successfully.</div>
				<%
				}
				String fail = (String) session.getAttribute("lmsg");
				if (fail != null) {
				session.removeAttribute("lmsg");
				%>
				<div class="alert alert-danger" id='danger'>Notes not found.</div>
				<%
				}
				%>
				<div class="panel panel-secondary shadow p-3 mb-5">
					<div class="panel-heading bg-info text-white">
						<strong>Study Material</strong>&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;<%=(new java.util.Date()).toLocaleString()%>&nbsp;]&nbsp;&nbsp;<a
							class="btn btn-warning" href=""><span class="badge"><%=count%></span>
							Notification</a>
					</div>
					<div class="panel-body">
						<form action="" method="post">
							<table id="table" class="table table-bordered">
								<thead>
									<tr>
										<th>Subject Code</th>
										<th>Subject</th>
										<th>File Name</th>
										<th>Remark</th>
										<th>File Category</th>
										<th>File Type</th>
										<th>Upload Date</th>
										<th>Download</th>
									</tr>
								</thead>
								<tbody>
									<%
									ResultSet rs = DatabaseConnection.getResultFromSqlQuery("select * from uploads");
									while (rs.next()) {
									%>
									<tr>
										<td><%=rs.getString(2)%></td>
										<td><label style='color: #33b5e5;'><%=rs.getString(3)%></label></td>
										<td><%=rs.getString(4)%></td>
										<td><%=rs.getString(5)%></td>
										<td><%=rs.getString(6)%></td>
										<%
										if (rs.getString("FileName").endsWith(".pdf")) {
										%>

										<td scope="row"><img alt="" src="files/pdf.png"
											width="40px" height="40px"></td>
										<%
										} else if (rs.getString("FileName").endsWith(".xlsx")) {
										%>

										<td scope="row"><img alt="" src="files/excel.png"
											width="40px" height="40px"></td>
										<%
										} else if (rs.getString("FileName").endsWith(".doc") || rs.getString("FileName").endsWith(".docx")) {
										%>
										<td scope="row"><img alt="" src="files/word.png"
											width="40px" height="40px"></td>
										<%
										} else if (rs.getString("FileName").endsWith(".mp4") || rs.getString("FileName").endsWith(".avi")) {
										%>
										<td scope="row"><img alt="" src="files/videologo.png"
											width="40px" height="40px"></td>
										<%
										} else if (rs.getString("FileName").endsWith(".ppt") || rs.getString("FileName").endsWith(".pptx")) {
										%>
										<td scope="row"><img alt="" src="files/ppt.png"
											width="40px" height="40px"></td>
										<%
										} else {
										%>
										<td scope="row"><img alt=""
											src="files/<%=rs.getString("FileName")%>" width="40px"
											height="40px"></td>
										<%
										}
										%>
										<td><span class="label label-warning"><%=rs.getDate(7)%></span></td>
										<td><a href="download?fileName=<%=rs.getString(4)%>">Download</a></td>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%
	} else {
	response.sendRedirect("index.jsp");
	}
	%>
</body>
<script src="js/jquery-3.1.1.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/script.js"></script>
<script src="js/jquery.dataTables.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#table').DataTable();
	})
</script>
</html>
