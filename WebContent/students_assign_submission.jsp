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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
					style="text-transform: uppercase">Student course details / My
					Assignments Submission</div>
				<%
				String updatesubmsn = (String) session.getAttribute("msg");
				if (updatesubmsn != null) {
					session.removeAttribute("msg");
				%>
				<div class='alert alert-success' id='success'>Submission
					Updated successfully.</div>
				<%
				}
				String failupdatesubmsn = (String) session.getAttribute("lmsg");
				if (failupdatesubmsn != null) {
				session.removeAttribute("lmsg");
				%>
				<div class='alert alert-danger' id='danger'>Submission is not
					updated.</div>
				<%
				}
				String wronginputs = (String) session.getAttribute("fmsg");
				if (wronginputs != null) {
				session.removeAttribute("fmsg");
				%>
				<div class='alert alert-danger' id='danger'>Updation field
					can't be empty.</div>
				<%
				}
				String delete = (String) session.getAttribute("deletemsg");
				if (delete != null) {
				%>
				<div class='alert alert-danger' id='danger'><%=session.getAttribute("deletemsg")%>
				</div>
				<%
				session.removeAttribute("deletemsg");
				}
				%>
				<div class="panel panel-primary shadow p-3 mb-5">
					<div class="panel-heading bg-info text-white">
						My Submitted Assignments&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;<%=(new java.util.Date()).toLocaleString()%>&nbsp;]&nbsp;&nbsp;
					</div>
					<div class="panel-body">
						<div class="contanier">

							<div class="row">
								<div class="col-sm-12">
									<a href="students_assignments.jsp"
										class="btn btn-primary mt-2 ml-2">Back</a>
								</div>
							</div>
							<%
							ArrayList<Submission> submission = (ArrayList<Submission>) request.getAttribute("submission");
							if (submission == null) {
							%><h4 style="text-align: center;">No Submission Available..</h4>
							<%
							} else if (submission.size() == 0) {
							%><h4 style="text-align: center;">No Submission Available.</h4>
							<%
							} else {
							for (int i = 0; i < submission.size(); i++) {
							%>
							<div class="row">
								<div class="col-sm-12">
									<div class="card m-3">
										<div class="card-body">
											<h5 class="card-title"><%=AssignmentDAO.getAssignment(submission.get(i).getAssignment_id()).getTitle()%></h5>
											<h6 class="card-subtitle mb-2 text-muted"><%=AssignmentDAO.getAssignment(submission.get(i).getAssignment_id()).getSubject()%></h6>
											<h6 class="card-subtitle mb-2 text-muted">
												Year:
												<%=AssignmentDAO.getAssignment(submission.get(i).getAssignment_id()).getYear()%></h6>
											<h6 class="card-subtitle mb-2 text-muted">
												Semester:
												<%=AssignmentDAO.getAssignment(submission.get(i).getAssignment_id()).getSemester()%></h6>
											<h6 class="card-subtitle mb-2 text-muted"><%=UserDAO.getFacultyById(AssignmentDAO.getAssignment(submission.get(i).getAssignment_id()).getLecturer_id())
		.getName()%>
												-
												<%=UserDAO.getFacultyById(AssignmentDAO.getAssignment(submission.get(i).getAssignment_id()).getLecturer_id())
		.getEmail()%>
											</h6>
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
											<a
												href="my-submission?submission-delete=<%=submission.get(i).getId()%>"
												class="btn btn-danger mt-2 mr-2 float-right">Delete
												Submission</a>
											<button type="button"
												onclick='updateSubmission(<%=new Gson().toJson(submission.get(i))%>)'
												class="btn btn-success mt-2 mr-2 float-right"
												data-target="#submissionModal" data-toggle="modal">Update
												Submission</button>
										</div>
									</div>
								</div>
							</div>
							<%
							}
							}
							%>
						</div>

						<!-- Modal -->
						<div class="modal fade" id="submissionModal" tabindex="-1"
							role="dialog" aria-labelledby="submissionModalLabel"
							aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<form id="updateSubmissionForm" method="post"
										enctype="multipart/form-data">
										<div class="modal-header">
											<h5 class="modal-title" id="submissionModalLabel">Update
												Submission</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<div class="form-group">
												<label for="ass_file" class="font-weight-bold">Submission
													File</label>
												<div class="custom-file">
													<input type="file" class="custom-file-input"
														id="upload_file" name="upload_file"> <label
														class="custom-file-label" for="customFile"
														style="overflow: hidden; text-overflow: ellipsis;">Choose
														file</label>
												</div>
											</div>
										</div>
										<div class="modal-footer">
											<button type="submit" class="btn btn-primary">Submit</button>
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
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script>
    $('#updateSubmissionForm #upload_file').on('change',function(){
        var fileName = $(this).val().split('\\');
        $(this).next('.custom-file-label').html(fileName[fileName.length-1]);
    });
    
    function updateSubmission(sub){
    	$('#updateSubmissionForm .custom-file-label').html(sub.upload_file);
    	$('#updateSubmissionForm').attr('action', 'my-submission?submission-update=' + sub.id);
    	$("#submissionModal").modal();
    }
</script>
	<%
	} else {
	response.sendRedirect("index.jsp");
	}
	%>
</body>
<script type="text/javascript">
var jq = $.noConflict();
jq(function() {
  jq('#success').delay(4000).show().fadeOut('slow');
  jq('#danger').delay(4000).show().fadeOut('slow');
});
	$(function() {
		console.log("Script loaded");
		$('#success').delay(4000).show().fadeOut('slow');
	});
	$(function() {
		$('#danger').delay(4000).show().fadeOut('slow');
	});
</script>
</html>
