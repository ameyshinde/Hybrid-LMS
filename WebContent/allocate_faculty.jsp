<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.attendance.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Hybrid LMS</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<body style="background-color: #F0F0F0";>
	<%
	if (session.getAttribute("uname") != null && session.getAttribute("uname") != "") {
	%>
	<jsp:include page="admin_side_header.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="panel panel-default">
			<div class="panel-body">
				<div class="alert alert-info shadow p-3 mb-5"
					style="text-transform: uppercase">Admin action / Allocated
					Faculty to Subject</div>
				<%
				String sentnotice = (String) session.getAttribute("allocation-apply");
				if (sentnotice != null) {
					session.removeAttribute("allocation-apply");
				%>
				<div class='alert alert-success' id='success'>Allocated
					Faculty to Subject successfully.</div>
				<%
				}
				%>
				<div class="panel panel-primary shadow p-3 mb-5">
					<div class="panel-heading bg-info text-white">
						Allocate Faculty&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;<%=(new java.util.Date()).toLocaleString()%>&nbsp;]&nbsp;&nbsp;
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-9">
								<div class="card">
									<div class="card-body">
										<div class="row">
											<div class="col-md-12">
												<h4>Allocate Faculty</h4>
												<hr>
											</div>
										</div>
										<div class="row">
											<div class="col-md-12">
												<form action="AllocateFaculty" method="post">
													<%
													ResultSet rs = DatabaseConnection.getResultFromSqlQuery("select * from faculty");
													%>
													<div class="form-group row">
														<label for="subject" class="col-4 col-form-label">Subject
															Name </label>
														<div class="col-4">
															<input id="subname" type="text" class="form-control"
																name="subjectName" placeholder="Enter Subject Name"
																required oninput="validateInput(event)">
														</div>
													</div>
													<div class="form-group row">
														<label for="subject" class="col-4 col-form-label">Subject
															Code </label>
														<div class="col-4">
															<input id="subcode" type="text" class="form-control"
																name="subjectCode" placeholder="Enter Subject Code"
																required oninput="validateInput(event)">
														</div>
													</div>
													<div class="form-group row">
														<label for="faculty" class="col-4 col-form-label">Faculty
															Name </label>
														<div class="col-6">
															<select class="form-select form-select-lg mb-3"
																aria-label=".form-select-lg example" name="facultyName"
																required>
																<%
																while (rs.next()) {
																	String facultyname = rs.getString("teacher_name");
																%>
																<option value="<%=facultyname%>"><%=facultyname%></option>
																<%
																}
																%>
															</select>
														</div>
													</div>

													<div class="form-group row">
														<label for="allocate" class="col-4 col-form-label"></label>
														<div class="col-8">
															<input type="submit" value="Allocate Subject"
																class="btn btn-primary"> <input type="reset"
																value="Reset" class="btn btn-danger">
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
	</div>
	<%
	} else {
	response.sendRedirect("index.jsp");
	}
	%>
</body>
<script type="text/javascript">
	$(function() {
		$('#success').delay(5000).show().fadeOut('slow');
	});
	function validateInput(event) {
		console.log("Warning,Stop Trying to use XSS attack!");
		const input = event.target.value;
		const safeInput = input.replace(/<script>/gi, '');
		event.target.value = safeInput;
	}
</script>
</html>
