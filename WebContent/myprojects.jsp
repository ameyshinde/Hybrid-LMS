<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.attendance.DatabaseConnection"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.util.Random"%>
<%@page import="java.util.UUID"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Student Attendance System</title>
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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/projectsTables.css" />
<script src="{pageContext.request.contextPath}/js/table-color.js"
	type="text/javascript"></script>
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
				int usn = (int) session.getAttribute("student_id");
				ResultSet resultset = DatabaseConnection
						.getResultFromSqlQuery("select count(pid) from projectinfo where usn='" + usn + "'");
				resultset.next();
				int count = resultset.getInt(1);
				%>
				<div class="alert alert-info shadow p-3 mb-5"
					style="text-transform: uppercase">Student Course details /
					Show Projects</div>
				<div class="panel panel-primary shadow p-3 mb-5">
					<div class="panel-heading bg-info text-white">
						Show Projects&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;<%=(new java.util.Date()).toLocaleString()%>&nbsp;]&nbsp;&nbsp;<a
							class="btn btn-warning" href=""><span class="badge"><%=count%></span>
							My Projects</a>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-12">
								<div class="card">
									<div class="card-body">
										<div class="row">
											<div class="col-md-14">
												<h1 align="center">Your Projects</h1>
												<br>

												<table id="sports" align="center">
													<tr>
													<tr>
														<th>Project ID</th>
														<th>Project Title</th>
														<th>Type</th>
														<th>Team Members</th>
														<th>Project Abstract</th>
														<th>Status</th>
														<th>Feedback From Admin</th>
														<th>Report</th>
														<th>View Report</th>
													</tr>
													<c:forEach items="${myprojects}" var="p">
														<tr>
															<td>${p.id}</td>
															<td>${p.ptitle}</td>
															<td>${p.type}</td>
															<td>${p.team}</td>
															<td>${p.pabstract}</td>
															<td class="status">${p.status}</td>
															<td>${p.feedback}</td>
															<td><a href="reportreview?title=${p.ptitle}"><button>Add
																		Report</button></a></td>
															<td><a href="getreport?title=${p.ptitle}"><button>View
																		Report</button></a></td>

														</tr>
													</c:forEach>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
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
	$(document).ready(function() {
		var x = $("td.status")
		for (var i = 0; i < x.length; i++) {
			if ($(x[i]).html() == "PENDING") {
				$(x[i]).html('<h5 class="text-primary">PENDING</h5>')
			} else if ($(x[i]).html() == "REJECTED") {
				$(x[i]).html('<h5 class="text-danger">REJECTED</h5>')
			} else {
				$(x[i]).html('<h5 class="text-success">APPROVED</h5>')
			}
		}
	});
</script>
</html>
