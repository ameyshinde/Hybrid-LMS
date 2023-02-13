<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.attendance.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Student Attendance System</title>
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
	<jsp:include page="student_side_header.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="panel panel-default">
			<div class="panel-body">
				<div class="alert alert-info shadow p-3 mb-5"
					style="text-transform: uppercase">Student action / Add
					Project Details</div>
				<%
				String sentnotice = (String) session.getAttribute("project-apply");
				if (sentnotice != null) {
					session.removeAttribute("project-apply");
				%>
				<div class='alert alert-success' id='success'>Project Details
					successfully sent.</div>
				<%
				}
				%>
				<div class="panel panel-primary shadow p-3 mb-5">
					<div class="panel-heading bg-info text-white">
						Send Project Details&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;<%=(new java.util.Date()).toLocaleString()%>&nbsp;]&nbsp;&nbsp;
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-9">
								<div class="card">
									<div class="card-body">
										<div class="row">
											<div class="col-md-12">
												<h4>Project Details</h4>
												<hr>
											</div>
										</div>
										<div class="row">

											
											<div class="container">
												<form action="addnewproject" method="post">
													<div class="input-group">
														<label for="sname" class="mb-2 mr-sm-2">Project
															Name:</label> <input id="pname" type="text" class="form-control"
															name="ptitle" placeholder="Enter Project Name" required>
													</div>
													<br>

													<div class="input-group">
														<label for="sname" class="mb-2 mr-sm-2">Project
															Domain :</label>

														<div class="form-check form-check-inline">
															<input class="form-check-input" type="radio" name="type"
																id="inlineRadio1" required value="Web Application">
															<label class="form-check-label" for="inlineRadio1">Web
																Application</label>
														</div>
														<div class="form-check form-check-inline">
															<input class="form-check-input" type="radio" name="type"
																id="aiml" required value="Android Application"> <label
																class="form-check-label" for="app">AI/Ml </label>
														</div>
														<div class="form-check form-check-inline">
															<input class="form-check-input" type="radio" name="type"
																id="inlineRadio2" required value="Console Based">
															<label class="form-check-label" for="inlineRadio2">Console
																Based</label>
														</div>
														<div class="form-check form-check-inline">
															<input class="form-check-input" type="radio" name="type"
																id="iot" required value="IOT"> <label
																class="form-check-label" for="iot">IOT</label>
														</div>
														<div class="form-check form-check-inline">
															<input class="form-check-input" type="radio" name="type"
																id="app" required value="Android Application"> <label
																class="form-check-label" for="app">Android/ IOS
																Application</label>
														</div>
													</div>
													<br>

													<div class="input-group">
														<label for="pabt" class="mb-2 mr-sm-2">Team
															Members USN(S):</label> <input id="pabt" type="text"
															class="form-control" name="team"
															placeholder="Enter Team Members USN(S)" required>
													</div>
													<br>

													<div class="input-group">
														<label for="pabt" class="mb-2 mr-sm-2">Project
															Abstract:</label>
														<textarea id="pabt" name="abs" placeholder="Enter Project Abstract"
															class="form-control" type="textarea"  required value=""
															rows="4" cols="30"></textarea>

														
													</div>
													<br>
													<div>

														<button class="btn btn-success">Add New Project</button>
														&nbsp;
														<button type="reset" class="btn btn-warning" name="reset"
															value=" Clear ">Clear</button>
													</div>
													<br>
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
</script>
</html>
