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
<style type="text/css">
.container {
	width: 950px;
	height: 800px;
	padding-left: 80px;
	padding-top: 40px;
	background-color: rgba(52, 73, 94, 0.7);
	border-radius: 4px;
	margin: 0 auto;
	margin-top: 18px;
}

.signout {
	color: green;
	background: #F1F0D1;
	padding-top: 5px;
	padding-right: 5px;
	padding-bottom: 5px;
	padding-left: 5px;
	border-radius: 4px;
	border: none;
	border-bottom: 4px solid #27aE60;
	cursor: pointer;
	height: 40px;
	width: 150px;
	margin-left: 210px;
}

.text {
	color: #ffff80;
	font-style: oblique;
	font-size: 1.2em;
}
</style>
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
					style="text-transform: uppercase">Student action / Add Quiz
					for students</div>
				<%
				String sentquiz = (String) session.getAttribute("quiz-apply");
				if (sentquiz != null) {
					session.removeAttribute("quiz-apply");
				%>
				<div class='alert alert-success' id='success'>Quiz
					successfully sent.</div>
				<%
				}
				%>
				<div class="panel panel-primary shadow p-3 mb-5">
					<div class="panel-heading bg-info text-white">
						Send Quiz&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;<%=(new java.util.Date()).toLocaleString()%>&nbsp;]&nbsp;&nbsp;
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-9">
								<div class="card">
									<div class="card-body">
										<div class="row">
											<div class="col-md-12">
												<h4>QUIZ TEST</h4>
												<hr>
											</div>
										</div>
										<div class="row">
											<div class="col-md-12">
												<%
												Connection conn = DatabaseConnection.getConnection();
												String query = "select * from quiz";
												PreparedStatement ps = conn.prepareStatement(query);
												ResultSet rs = ps.executeQuery();
												%>
												<div class="container">
													<h2 style="color: #ffff80; text-align: center;">Quiz
														questions database:</h2>
													<%
													while (rs.next()) {
														String sno = rs.getString("quiz_no");
														String ques = rs.getString("question");
														String a = rs.getString("option1");
														String b = rs.getString("option2");
														String c = rs.getString("option3");
														String d = rs.getString("option4");
														String correct = rs.getString("correct_option");
													%>

													<b class="text">Question <%=sno%>: <%=ques%></b><br> <b
														class="text">a) <%=a%></b><br> <b class="text">b)
														<%=b%></b><br> <b class="text">c) <%=c%></b><br> <b
														class="text">d) <%=d%></b><br> <b class="text">Correct
														Choice: <%=correct%></b><br> <br>

													<%
													}
													conn.close();
													%>

													<fieldset style="width: 600px; margin-left: 150px;">

														<form action="deleteQuiz" method="post">
															<b class="text">Enter the question number you wish to
																delete:</b> &nbsp;&nbsp;&nbsp;&nbsp;<input type="number"
																name="delete"><br> <br> <input
																type="submit" value="Delete" class="signout"> <br>
															<br>
														</form>
													</fieldset>
													<%
session.setAttribute("delete", request.getParameter("delete"));

%>
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

