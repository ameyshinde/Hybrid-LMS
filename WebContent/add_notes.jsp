<%@page import="com.attendance.DatabaseConnection"%>
<%@ page import="java.sql.*"%>
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
	<jsp:include page="faculty_side_header.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="panel panel-default">
			<div class="panel-body">
				<div class="alert alert-info shadow p-3 mb-5"
					style="text-transform: uppercase">Students Actions / Add
					Notes</div>
				<%
				String success = (String) session.getAttribute("msg");
				String lsuccess = (String) session.getAttribute("lmsg");
				if (success != null) {
					session.removeAttribute("msg");
				%>
				<div class='alert alert-success' id='success'>Notes Uploaded
					Successfully.</div>
				<%
				}
				if (lsuccess != null) {
				session.removeAttribute("lmsg");
				%>
				<div class='alert alert-success' id='success'>Notes Deleted
					Successfully.</div>
				<%
				}
				String fail = (String) session.getAttribute("msg");
				String lfail = (String) session.getAttribute("lmsg");
				if (fail != null) {
				session.removeAttribute("msg");
				%>
				<div class="alert alert-danger" id='danger'>Notes Upload
					Fail,Please try again</div>
				<%
				}
				if (lfail != null) {
				session.removeAttribute("lmsg");
				%>
				<div class="alert alert-danger" id='danger'>Notes Deletion
					Fail,Please try again</div>
				<%
				}
				%>

				<div class="panel panel shadow p-3 mb-5 ">
					<div class="panel-heading bg-info text-white"
						style="text-transform: uppercase">
						Upload Notes &nbsp;[&nbsp;<%=(new java.util.Date()).toLocaleString()%>&nbsp;]&nbsp;&nbsp;
					</div>
					<div class="panel-body">
						<form action=UploadServlet method="post"
							enctype="multipart/form-data">
							<div class="form-row">
								<div class="form-group col-md-4">
									<label for="subjectName">Remark</label> <input type="text"
										class="form-control" id="remark" name="remark"
										placeholder="Add Remark for Upload" required oninput="validateInput(event)">
								</div>
							</div>
							<div class="form-row">
								<div class="form-group col-md-4 ">
									<label for="filetype">Upload Type:</label> <br> <select
										class="form-select form-select-lg" name="filetype" required>
										<option selected value="Notes">Notes</option>
										<option value="Assignments">Assignments</option>
										<option value="References">References</option>
										<option value="Question Bank">Question Bank</option>
										<option value="Lab Manual">Lab Manual</option>
										<option value="Results">Results</option>
										<option value="Video Lecture">Video Lecture</option>
									</select>
								</div>
							</div>

							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="uname">Select File:</label> <input type="file"
										required="" name="notesfile">
								</div>

							</div>
							<input type="submit" class="btn btn-primary" value="Upload">
							<input type="reset" class="btn btn-danger" value="Cancel">
						</form>
					</div>
				</div>
				<h4>MY UPLOADS</h4>
				<hr>
				<table id="table" class="table table-bordered">
					<thead>
						<tr>
							<th>Subject Code</th>
							<th>Subject</th>
							<th>File Name</th>
							<th>Remark</th>
							<th>File Category</th>
							<th>File Type</th>
							<th>Upload Date</th>
							<th>Download</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<%
						String uploader = (String) session.getAttribute("TeacherName");
						Connection con = DatabaseConnection.getConnection();
						PreparedStatement ps = con.prepareStatement("select * from uploads where Uploader=?");
						ps.setString(1, uploader);
						ResultSet rs = ps.executeQuery();
						while (rs.next()) {
						%>
						<tr>
							<td><%=rs.getString(2)%></td>
							<td><label style='color: #33b5e5;'><%=rs.getString(3)%></label></td>
							<td><%=rs.getString(4)%></td>
							<td><%=rs.getString(5)%></td>
							<td><%=rs.getString(6)%></td>
							<%
							if (rs.getString("FileName").endsWith(".pdf")) {
							%>

							<td scope="row"><img alt="" src="files/pdf.png" width="40px"
								height="40px"></td>
							<%
							} else if (rs.getString("FileName").endsWith(".xlsx")) {
							%>

							<td scope="row"><img alt="" src="files/excel.png"
								width="40px" height="40px"></td>
							<%
							} else if (rs.getString("FileName").endsWith(".doc") || rs.getString("FileName").endsWith(".docx")) {
							%>
							<td scope="row"><img alt="" src="files/word.png"
								width="40px" height="40px"></td>
							<%
							} else if (rs.getString("FileName").endsWith(".mp4") || rs.getString("FileName").endsWith(".avi")) {
							%>
							<td scope="row"><img alt="" src="files/videologo.png"
								width="40px" height="40px"></td>
								<%
							} else if (rs.getString("FileName").endsWith(".ppt") || rs.getString("FileName").endsWith(".pptx") ) {
							%>
							<td scope="row"><img alt="" src="files/ppt.png"
								width="40px" height="40px"></td>
							<%
							} else {
							%>
							<td scope="row"><img alt=""
								src="files/<%=rs.getString("FileName")%>" width="40px"
								height="40px"></td>
							<%
							}
							%>
							<td><span class="label label-warning"><%=rs.getDate(7)%></span></td>
							<td><a href="download?fileName=<%=rs.getString(4)%>">Download</a></td>
							<td><a href="DeleteServlet?fileName=<%=rs.getString(4)%>"><button
										class="btn btn-danger"
										onClick="return confirm('Are you sure, you want to Delete this File?');">Delete</button></a></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
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
