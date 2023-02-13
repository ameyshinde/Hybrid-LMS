<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.attendance.*"%>
<%@page import="java.util.ArrayList, com.bean.*"%>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student_result_display.css" />
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
					style="text-transform: uppercase">Student action / Quiz Result
					</div>
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
						Send Announcements&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;<%=(new java.util.Date()).toLocaleString()%>&nbsp;]&nbsp;&nbsp;
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
												<h2>Detailed result:</h2>
												<br>
												<%
												String uname = (String) session.getAttribute("uname");
												Connection connection = DatabaseConnection.getConnection();
												String query1 = "select * from quiz order by quiz_no";
												String query2 = "select * from quiz_answers where username=? order by quiz_no";
												PreparedStatement ps1 = connection.prepareStatement(query1);
												PreparedStatement ps2 = connection.prepareStatement(query2);
												ps2.setString(1, uname);
												ResultSet rs1 = ps1.executeQuery();
												ResultSet rs2 = ps2.executeQuery();
												int cnum = 0;
												%>
												<div class="container">
													<%
													while (rs1.next() && rs2.next()) {
														String sno = rs1.getString("quiz_no");
														String ques = rs1.getString("question");
														String a = rs1.getString("option1");
														String b = rs1.getString("option2");
														String c = rs1.getString("option3");
														String d = rs1.getString("option4");
														String correct = rs1.getString("correct_option");
														String userans = rs2.getString("userans");
														if (correct.equals(userans)) {
															cnum++;
														}
													%>

													<b class="text"> Question <%=sno%>: <%=ques%></b><br>
													<b class="text"> a) <%=a%></b><br> <b class="text">
														b) <%=b%></b><br> <b class="text"> c) <%=c%></b><br>
													<b class="text"> d) <%=d%></b><br> <b class="text">
														Correct Answer : <%=correct%></b><br> <b class='text1'>Your
														Answer: <%=userans%></b><br>
													<br>

													<%
													}
													out.println("<b class='text1'>Number of Correct Answers: " + cnum + "</b>");
													%>
												</div>
												<%
												connection.close();
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

