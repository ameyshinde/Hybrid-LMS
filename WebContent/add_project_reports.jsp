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
<style type="text/css">
.body {
	background-color: #CAD4D3;
}
</style>
</head>
<body style="background-color: #F0F0F0";>
	<%
	if (session.getAttribute("uname") != null && session.getAttribute("uname") != "") {
	%>
	<jsp:include page="student_side_header.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="panel panel-default shadow p-3 mb-5">
			<div class="panel-body">
				<div class="alert alert-info shadow p-3 mb-5"
					style="text-transform: uppercase">Student Course details /
					Projects</div>
				<%
				String sentproject = (String) session.getAttribute("msg");
				if (sentproject != null) {
					session.removeAttribute("msg");
				%>
				<div class='alert alert-success' id='success'>Project Report
					successfully sent.</div>
				<%
				}
				%>

				<div class="panel-body">
					<div class="row">
						<div class="col-md-12">
							<div class="body">
								<div class="card-body">
									<div class="row">
										<div class="container">
											<div class="row">
												<div class="col-md-4"></div>
												<div class="col-md-4">
													<form class="form" action="addpmreport" method="post"
														enctype="multipart/form-data">
														<div class="form-group mx-sm-10 ">
															<select class="form-select form-select-sm" name="phase"
																required>
																<option selected value="1">Phase One</option>

																<option value="2">Phase Two</option>
																<option value="3">Phase Three</option>
															</select>
														</div>
														<div class="form-group">
															<input type="file" name="reportfile" id="reportfile"
																required />
														</div>
														<button type="submit" class="btn btn-primary mb-4 ml-2">Add
															Report</button>
													</form>

												</div>
												<div class="col-md-4"></div>
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