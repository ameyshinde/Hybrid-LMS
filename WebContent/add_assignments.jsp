<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.attendance.*"%>
<%@page import="com.dao.AssignmentDAO"%>
<%@ page import="com.google.gson.Gson"%>
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
	<jsp:include page="faculty_side_header.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="panel panel-default">
			<div class="panel-body">
				<div class="alert alert-info shadow p-3 mb-5"
					style="text-transform: uppercase">Student action / Add
					Assignments for students</div>
				<%
				String success = (String) session.getAttribute("msg");
				if (success != null) {
					session.removeAttribute("msg");
				%>
				<div class='alert alert-success' id='success'>Assignment
					successfully sent.</div>
				<%
				}
				String fail = (String) session.getAttribute("lmsg");
				if (fail != null) {
				session.removeAttribute("lmsg");
				%>
				<div class='alert alert-danger' id='danger'>Assignment not
					sent.</div>
				<%
				}
				String wrongEntry = (String) session.getAttribute("fmsg");
				if (wrongEntry != null) {
				session.removeAttribute("fmsg");
				%>
				<div class='alert alert-danger' id='danger'>Please Enter All
					the Fields Correctly.</div>
				<%
				}
				String deleteassign = (String) session.getAttribute("delemsg");
				if (deleteassign != null) {
				session.removeAttribute("delemsg");
				%>
				<div class='alert alert-danger' id='danger'>Assignment Deleted
					Successfully</div>
				<%
				}
				String deleteassignfailed = (String) session.getAttribute("fdelemsg");
				if (deleteassignfailed != null) {
				session.removeAttribute("fdelemsg");
				%>
				<div class='alert alert-danger' id='danger'>Assignment is not
					deleted.</div>
				<%
				}
				%>

				<div class="panel panel-primary shadow p-3 mb-5">
					<div class="panel-heading bg-info text-white">
						Send Assignments&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;<%=(new java.util.Date()).toLocaleString()%>&nbsp;]&nbsp;&nbsp;
					</div>
					<div class="panel-body">
						<div class="contanier">



							<div class="row">
								<div class="col-sm-12">
									<button type="button"
										class="btn btn-primary mt-2 mr-2 float-right"
										data-toggle="modal" data-target="#assignModal">Add
										Assignment</button>
								</div>
							</div>

							<%
							ArrayList<Assignment> assignment = new ArrayList<>();
							int teacher_id = (int) session.getAttribute("teacher_id");
							String teacher_name = (String) session.getAttribute("TeacherName");
							try {
								assignment = AssignmentDAO.getLecturerAssignment(teacher_id);
							} catch (Exception e) {
								e.printStackTrace();
							}

							request.setAttribute("assignment", assignment);

							request.getAttribute("assignment");

							if (assignment == null) {
							%><h4 style="text-align: center;">No Assignment Available.</h4>
							<%
							} else if (assignment.size() == 0) {
							%><h4 style="text-align: center;">No Assignment Available.</h4>
							<%
							} else {

							for (int i = 0; i < assignment.size(); i++) {
							%>
							<div class="row">
								<div class="col-sm-12">
									<div class="card m-3">
										<div class="card-body">
											<h5 class="card-title"><%=assignment.get(i).getTitle()%></h5>
											<h6 class="card-subtitle mb-2 text-muted"><%=assignment.get(i).getSubject()%></h6>
											<h6 class="card-subtitle mb-2 text-muted">
												Year:
												<%=assignment.get(i).getYear()%></h6>
											<h6 class="card-subtitle mb-2 text-muted">
												Semester:
												<%=assignment.get(i).getSemester()%></h6>
											<p class="card-text">
												Post Date:
												<%=assignment.get(i).getPost_date()%><br /> Due Date:
												<%=assignment.get(i).getDue_date()%></p>
											<%
											if (assignment.get(i).getUpload_file() != null) {
											%>
											<a
												href="downloadFile?filename=assignments/<%=assignment.get(i).getUpload_file()%>"
												class="card-link"><%=assignment.get(i).getUpload_file()%></a>
											<%
											}
											%>
											<a href="lhome?assign-delete=<%=assignment.get(i).getId()%>"
												class="btn btn-danger mt-2 mr-2 float-right">Delete</a>
											<button type="button"
												onclick='updateAssign(<%=new Gson().toJson(assignment.get(i))%>)'
												class="btn btn-warning mt-2 mr-2 float-right"
												data-target="#assignUModal" data-toggle="modal">Update</button>
											<a
												href="student-submission?assignment=<%=assignment.get(i).getId()%>"
												class="btn btn-success mt-2 mr-2 float-right">Submissions</a>
										</div>
									</div>
								</div>
							</div>
							<%
							}
							}
							%>
						</div>

						<!-- Add Assignment Pop up -->
						<div class="modal fade" id="assignModal" tabindex="-1"
							role="dialog" aria-labelledby="assignModalLabel"
							aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<form id="addAssignmentForm" method="post" action="lhome"
										enctype="multipart/form-data">
										<div class="modal-header">
											<h3 class="modal-title" id="assignModalLabel">Add
												Assignment</h3>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">

											<div class="form-group">
												<label for="title">Title</label> <input type="text"
													class="form-control" id="title" name="title"
													placeholder="Title" required>
											</div>
									<!--  	<div class="form-group">
												<label for="subject">Subject</label> <input type="text"
													class="form-control" id="subject" name="subject"
													placeholder="Subject" required>
											</div> -->	
											<div class="form-group">
												<label for="year">Year</label> <input type="number"
													class="form-control" id="year" name="year"
													placeholder="Year" required>
											</div>
											<div class="form-group">
												<label for="semester">Semester</label> <input type="number"
													class="form-control" id="semester" name="semester"
													placeholder="Semester" required>
											</div>
											<div class="form-group">
												<label for="due_date">Due Date</label> <input type="date"
													class="form-control" id="due_date" name="due_date"
													placeholder="Due date" required>
											</div>
											<div class="form-group">
												<label for="ass_file">Assignment File</label>
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

						<!-- Update pop up -->
						<div class="modal fade" id="assignUModal" tabindex="-1"
							role="dialog" aria-labelledby="assignUModalLabel"
							aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<form id="updateAssignmentForm" method="post"
										enctype="multipart/form-data">
										<div class="modal-header">
											<h5 class="modal-title" id="assignUModalLabel">Update
												Assignment</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">

											<div class="form-group">
												<label for="title">Title</label> <input type="text"
													class="form-control" id="title" name="title"
													placeholder="Title" required>
											</div>
											<div class="form-group">
												<label for="subject">Subject</label> <input type="text"
													class="form-control" id="subject" name="subject"
													placeholder="Subject" required>
											</div>
											<div class="form-group">
												<label for="year">Year</label> <input type="number"
													class="form-control" id="year" name="year"
													placeholder="Year" required>
											</div>
											<div class="form-group">
												<label for="semester">Semester</label> <input type="number"
													class="form-control" id="semester" name="semester"
													placeholder="Semester" required>
											</div>
											<div class="form-group">
												<label for="due_date">Due Date</label> <input type="date"
													class="form-control" id="due_date" name="due_date"
													placeholder="Due date" required>
											</div>
											<div class="form-group">
												<label for="ass_file">Assignment File</label>
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
    $('#addAssignmentForm #upload_file').on('change',function(){
        var fileName = $(this).val().split('\\');
        $(this).next('.custom-file-label').html(fileName[fileName.length-1]);
    });
    
    $('#updateAssignmentForm #upload_file').on('change',function(){
        var fileName = $(this).val().split('\\');
        $(this).next('.custom-file-label').html(fileName[fileName.length-1]);
    });
    
    function updateAssign(assign){
    	
    	$('#updateAssignmentForm #title').val(assign.title);
    	$('#updateAssignmentForm #subject').val(assign.subject);
    	$('#updateAssignmentForm #year').val(assign.year);
    	$('#updateAssignmentForm #semester').val(assign.semester);
    	$('#updateAssignmentForm .custom-file-label').html(assign.upload_file);
    	let due_date = new Date(assign.due_date);
    	$('#updateAssignmentForm #due_date').val(due_date.getFullYear() + "-" + addPrefix(due_date.getMonth() + 1) + "-" + addPrefix(due_date.getDate()));
    	$('#updateAssignmentForm').attr('action', 'lhome?assign-update=' + assign.id);
    	$("#assignUModal").modal();
    }
    
    function addPrefix(str) {
   	  return ('0' + str).slice(-2)
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
  jq('#success').delay(5000).show().fadeOut('slow');
  jq('#danger').delay(5000).show().fadeOut('slow');
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
