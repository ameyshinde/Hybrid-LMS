<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.attendance.DatabaseConnection"%>
<%@page import="java.sql.ResultSet"%>
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
					Data</div>
				<div class="panel panel shadow p-3 mb-5">
					<div class="panel-heading bg-light"
						style="text-transform: uppercase"">
						<strong>Faculty Information For Update</strong>
					</div>
					<div class="panel-body">
						<%
						String teacher_id = request.getParameter("teacher_id");
						Connection con = DatabaseConnection.getConnection();
						Statement statement = con.createStatement();
						String sql = "select * from faculty where teacher_id=" + teacher_id;
						ResultSet resultSet = statement.executeQuery(sql);
						while (resultSet.next()) {
						%>
						<form action="faculty_update_process.jsp" method="post">
							<div class="form-group">
								<label for="teacher_id">Faculty Id:</label> <input type="text"
									class="form-control" id="teacher_id" name="teacher_id"
									value="<%=resultSet.getInt(1)%>" readonly>
							</div>
							<div class="form-group">
								<label for="tname">Faculty Name:</label> <input type="text"
									class="form-control" id="tname" name="tname"
									oninput="validateInput(event)"
									value="<%=resultSet.getString(2)%>">
							</div>
							<div class="form-group">
								<label for="cname">Branch Name:</label> <input type="text"
									class="form-control" id="branch" name="branchname"
									oninput="validateInput(event)"
									value="<%=resultSet.getString(4)%>">
							</div>
							<div class="form-group">
								<label for="mobile">Mobile:</label> <input type="tel"
									class="form-control" id="mobile" name="mobile" maxlength="10"
									title="Please use a 10 digit telephone number with no dashes or dots"
									oninput="validateInput(event)"
									value="<%=resultSet.getString(3)%>">
							</div>
							<div class="form-group">
								<label for="email">Email:</label> <input type="email"
									class="form-control" id="email" name="email"
									oninput="validateInput(event)"
									value="<%=resultSet.getString(5)%>">
							</div>
							<div class="form-group">
								<label for="subject">Subject:</label> <input type="text"
									class="form-control" id="subject" name="subject"
									oninput="validateInput(event)"
									value="<%=resultSet.getString(9)%>">
							</div>
							<div class="form-group">
								<label for="subjectcode">Subject Code:</label> <input
									type="text" class="form-control" id="subjectcode"
									name="subjectcode" oninput="validateInput(event)"
									value="<%=resultSet.getString(10)%>">
							</div>
							<input type="submit" class="btn btn-primary"
								value="Update Information">
						</form>
						<%
						}
						%>
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
<script>
	function validateInput(event) {
		console.log("Warning,Stop Trying to use XSS attack!");
		const input = event.target.value;
		const safeInput = input.replace(/<script>/gi, '');
		event.target.value = safeInput;
	}
</script>
</html>
