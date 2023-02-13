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
	href="${pageContext.request.contextPath}/css/admin_projects_tables.css" />
<script src="{pageContext.request.contextPath}/js/table-color.js"
	type="text/javascript"></script>
<style>
.bg {
	background-color: #C8D7DB;
}
</style>
</head>
<body style="background-color: #F0F0F0";>
	<%
	if (session.getAttribute("uname") != null && session.getAttribute("uname") != "") {
	%>
	<jsp:include page="admin_side_header.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="panel panel-default shadow p-3 mb-5">
			<div class="panel-body">
				<%
				ResultSet resultset = DatabaseConnection
						.getResultFromSqlQuery("select COUNT(status) from projectinfo where status='PENDING'");
				resultset.next();
				int count = resultset.getInt(1);
				%>
				<div class="alert alert-info shadow p-3 mb-5"
					style="text-transform: uppercase">Student Course details /
					Announcements</div>
				<div class="panel panel-secondary shadow p-3 mb-5">
					<div class="panel-heading">
						Approve Project&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;<%=(new java.util.Date()).toLocaleString()%>&nbsp;]&nbsp;&nbsp;<a
							class="btn btn-warning" href=""><span class="badge"><%=count%></span>
							Pending</a>
					</div>
					<div class="panel-body">
						<div class="bg">
							<table id="club" align="center">
								<tr>
									<th>ID</th>
									<td>${p.id}</td>
								</tr>
								<tr>
									<th>Project Title</th>
									<td>${p.ptitle}</td>
								</tr>
								<tr>
									<th>Type</th>
									<td>${p.type}</td>
								</tr>
								<tr>
									<th>Team Members</th>
									<td>${p.team}</td>
								</tr>
								<tr>
									<th>Project Abstract</th>
									<td>${p.pabstract}</td>
								</tr>
								<tr>
									<th>Status</th>
									<td class="status">${p.status}</td>
								</tr>
								<tr>
									<th>Feedback From Admin</th>
									<td>${p.feedback}</td>
								</tr>
							</table>

							<hr>

							<div class="container">
								<div class="row">
									<form action="update" method="post">
										<fieldset class="form-group">
											<div class="row">
												<legend class="col-form-label col-sm-8 pt-10 text">Set
													Project Status</legend>
												<div class="col-sm-16">

													<div class="form-check">
														<input style="text-align: right;"
															form-check-input" type="radio" name="status" id="pending"
															required value="Pending"> <label
															class="form-check-label text-primary" for="pending">
															Pending </label>
													</div>

													<div class="form-check">
														<input style="text-align: right;class="
															form-check-input" type="radio" name="status"
															id="gridRadios1" required value="Approved"> <label
															class="form-check-label text-success" for="gridRadios1">
															Approve </label>
													</div>
													<div class="form-check">
														<input style="text-align: right;"
															form-check-input" type="radio" name="status"
															id="gridRadios2" required value="Rejected"> <label
															style="color: red" class="form-check-label"
															for="gridRadios2"> Reject </label>
													</div>
												</div>
											</div>
											<div class="form-group">
												<label for="exampleFormControlTextarea1" class="text">Feedback
													to Student</label>
												<textarea class="form-control mb-3"
													id="exampleFormControlTextarea1" rows="3" name="feedback"
													required></textarea>
											</div>
										</fieldset>
										<div class="form-group row">
											<div class="col-sm-14">
												<button type="submit" class="btn btn-primary">Update</button>
												&nbsp;&nbsp;
												<button type="reset" class="btn btn-warning">Clear</button>
												&nbsp;&nbsp; <a href="AdminDashboard.html"><button
														type="button" class="btn btn-danger">Cancel</button></a>
											</div>
										</div>
									</form>
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
