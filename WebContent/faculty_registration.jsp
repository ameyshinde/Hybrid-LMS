<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
					style="text-transform: uppercase">Faculty Activity / Faculty
					Registration</div>
				<%
				String success = (String) session.getAttribute("success-message");
				if (success != null) {
					session.removeAttribute("success-message");
				%>
				<div class='alert alert-success' id='success'>Faculty Register
					Successfully.</div>
				<%
				}
				String fail = (String) session.getAttribute("fail-message");
				if (fail != null) {
				session.removeAttribute("fail-message");
				%>
				<div class="alert alert-danger" id='danger'>Faculty
					Registration Fail,Please try again</div>
				<%
				}
				String regifail = (String) session.getAttribute("duplicate-message");
				if (regifail != null) {
				session.removeAttribute("fail-message");
				%>
				<div class="alert alert-danger" id='danger'>User Name Already
					Exists,Please Choose Unique User Name</div>
				<%
				}
				%>
				<div class="panel panel shadow p-3 mb-5 ">
					<div class="panel-heading bg-light"
						style="text-transform: uppercase">
						<strong>Faculty Registration &nbsp;[&nbsp;<%=(new java.util.Date()).toLocaleString()%>&nbsp;]&nbsp;&nbsp;
						</strong>
					</div>
					<div class="panel-body">
						<form action="FacultyRegistration" method="post">
							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="sname">Faculty Name:</label> <input type="text"
										class="form-control" id="sname" name="tname"
										oninput="validateInput(event)"
										placeholder="Faculty Name" required>
								</div>
								<div class="form-group col-md-6">
									<label for="collegeName">Branch Name:</label> <input
										type="text" class="form-control" id="collegeName"
										oninput="validateInput(event)"
										name="branchName" placeholder="Branch Name" required>
								</div>
							</div>
							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="mobile">Mobile:</label> <input type="tel"
										class="form-control" id="mobile" name="mobile" maxlength="10"
										oninput="validateInput(event)"
										title="Please use a 10 digit telephone number with no dashes or dots"
										placeholder="Mobile No." required>
								</div>

								<div class="form-group col-md-6">
									<label for="email">Email Id:</label> <input type="email"
										class="form-control" id="email" name="email"
										oninput="validateInput(event)"
										placeholder="Email Id" required>
								</div>
							</div>

							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="uname">User Name:</label> <input type="text"
										class="form-control" id="uname" name="uname"
										oninput="validateInput(event)"
										placeholder="Users Name" required>
								</div>
								<div class="form-group col-md-6">
									<label for="pass">Temporary Password:</label> <input
										type="password" class="form-control" id="pass" name="pass"
										oninput="validateInput(event)"
										placeholder="Password" required>
								</div>
							</div>
							<input type="submit" class="btn btn-primary" value="Register">
							<input type="reset" class="btn btn-danger" value="Cancel">
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
<script type="text/javascript">
	$(function() {
		$('#success').delay(5000).show().fadeOut('slow');
	});

	$(function() {
		$('#danger').delay(5000).show().fadeOut('slow');
	});
	function validateInput(event) {
		console.log("Warning,Stop Trying to use XSS attack!");
		const input = event.target.value;
		const safeInput = input.replace(/<script>/gi, '');
		event.target.value = safeInput;
	}
</script>
</html>
