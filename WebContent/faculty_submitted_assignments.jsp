<%@page import="com.dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.attendance.*"%>
<%@page import="com.dao.AssignmentDAO"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.model.Submission"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.model.Assignment"%>
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
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #F0F0F0";>
	<%
	if (session.getAttribute("uname") != null && session.getAttribute("uname") != "") {
	%>
	<jsp:include page="faculty_side_header.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="panel panel-default">
			<div class="panel-body">
				<div class="alert alert-info shadow p-3 mb-5"
					style="text-transform: uppercase">Student action / Students
					Assignments Submission</div>
				<%
				String sentnotice = (String) session.getAttribute("notice-apply");
				if (sentnotice != null) {
					session.removeAttribute("notice-apply");
				%>
				<div class='alert alert-success' id='success'>Announcement
					successfully sent.</div>
				<%
				}
				%>
				<div class="panel panel-primary shadow p-3 mb-5">
					<div class="panel-heading bg-info text-white">
						Students Submitted Assignments&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;<%=(new java.util.Date()).toLocaleString()%>&nbsp;]&nbsp;&nbsp;
					</div>
					<div class="panel-body">
						<div class="contanier">

							<%
							if (request.getAttribute("msg") != null) {
							%>
							<div class="alert alert-info mt-2 mr-2 ml-2" role="alert">
								<%=request.getAttribute("msg")%>
								<button type="button" class="close" data-dismiss="alert"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<%
							}
							%>

							<div class="row">
								<div class="col-sm-12">
									<a href="add_assignments.jsp"
										class="btn btn-primary mt-2 ml-2">Back</a>
								</div>
							</div>


							<%
							ArrayList<Submission> submission = (ArrayList<Submission>) request.getAttribute("submission");

							if (submission.size() == 0) {
							%><h4 style="text-align: center;">No Submissions  Available.</h4>
							<%
							}
							String stud_name = (String) session.getAttribute("StudentName");
							for (int i = 0; i < submission.size(); i++) {
							%>
							<div class="row">
								<div class="col-sm-12">
									<div class="card m-3">
										<div class="card-body">
											<h5 class="card-title">
												Student Name:
												<%=UserDAO.getUserById(submission.get(i).getStudent_id()).getName()%></h5>
											<h6 class="card-subtitle mb-2 text-muted">
												Email:
												<%=UserDAO.getUserById(submission.get(i).getStudent_id()).getEmail()%></h6>
											<p class="card-text">
												Post Date:
												<%=AssignmentDAO.getAssignment(submission.get(i).getAssignment_id()).getPost_date()%><br />
												Due Date:
												<%=AssignmentDAO.getAssignment(submission.get(i).getAssignment_id()).getDue_date()%></p>
											<p class="card-text">
												Submitted Date:
												<%=submission.get(i).getSubmit_date()%></p>
											<%
											if (AssignmentDAO.getAssignment(submission.get(i).getAssignment_id()).getUpload_file() != null) {
											%>
											<a
												href="downloadFile?filename=assignments/<%=AssignmentDAO.getAssignment(submission.get(i).getAssignment_id()).getUpload_file()%>"
												class="card-link"><%=AssignmentDAO.getAssignment(submission.get(i).getAssignment_id()).getUpload_file()%></a>
											<%
											}
											%>
											<%
											if (submission.get(i).getUpload_file() != null) {
											%>
											<p class="font-weight-bold mt-3">Submitted File</p>
											<a
												href="downloadFile?filename=submissions/<%=submission.get(i).getUpload_file()%>"
												class="card-link"><%=submission.get(i).getUpload_file()%></a>
											<%
											}
											%>
										</div>
									</div>
								</div>
							</div>
							<%
							}
							%>

						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
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
