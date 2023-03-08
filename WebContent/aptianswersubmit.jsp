<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.attendance.*"%>
<%@ page import="java.util.*, com.bean.*"%>
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
<script type="text/javascript">
	var timeLeft = 60; // time in seconds

	function startTimer() {
		setInterval(function() {
			if (timeLeft <= 0) {
				clearInterval();
				document.getElementById("timer").innerHTML = "Time's up!";
				document.getElementById("submitButton").click();
			} else {
				document.getElementById("timer").innerHTML = timeLeft
						+ " seconds remaining";
				timeLeft -= 1;
				document.getElementById("time").value = timeLeft;
			}
		}, 1000);
	}

	window.onload = function() {
		startTimer();
	}
</script>
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
					style="text-transform: uppercase">Student action / Attempt
					Aptitude Test for students</div>
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
						Aptitude Test&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;<%=(new java.util.Date()).toLocaleString()%>&nbsp;]&nbsp;&nbsp;
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-9">
								<div class="card">
									<div class="card-body">
										<div class="row">
											<div class="col-md-12">
												<h4>APTITUDE TEST</h4>
												<div id="timer"></div>
												<hr>
											</div>
											<%!ArrayList list;
	int term = 0;
	int qn = 0;%>

											<%
											Connection conn = DatabaseConnection.getConnection();
											String query = "select count(quiz_no) as totalQuestions from aptitude";
											PreparedStatement ps = conn.prepareStatement(query);
											ResultSet rs = ps.executeQuery();
											rs.next();
											int count = rs.getInt("totalQuestions");
											System.out.println(count);
											if (term++ == 0) {
												list = (ArrayList) session.getAttribute("dbdata");
											}

											if (qn == count) {
												qn = 0;
											}

											Question q = (Question) list.get(qn++);
											%>
											<div class="container">
												<form method="post" action="saveAptitude">
													<b style="font-size: 1.2em; color: #26408B;"><i> <%
 out.println("Question" + q.getSno() + ". " + q.getQuestion());
 session.setAttribute("sno", q.getSno());
 %>
													</i> </b>

													<table>
														<tr>
															<td style="text-align: right;"><input type="radio"
																name="myradio" value="<%=q.getAns1()%>"></td>
															<td><b style="font-size: 1.2em; color: black;"><%=q.getAns1()%></b></td>
														</tr>
														<tr>
															<td style="text-align: right;"><input type="radio"
																name="myradio" value="<%=q.getAns2()%>"></td>
															<td><b style="font-size: 1.2em; color: black;"><%=q.getAns2()%></b></td>
														</tr>
														<tr>
															<td style="text-align: right;"><input type="radio"
																name="myradio" value="<%=q.getAns3()%>"></td>
															<td><b style="font-size: 1.2em; color: black;"><%=q.getAns3()%></b></td>
														</tr>
														<tr>
															<td style="text-align: right;"><input type="radio"
																name="myradio" value="<%=q.getAns4()%>"></td>
															<td><b style="font-size: 1.2em; color: black;"><%=q.getAns4()%></b></td>
														</tr>
														<tr>
															<td style="text-align: right;"><input type="hidden"
																name="correct" value="<%=q.getCorrect()%>"></td>
														</tr>
													</table>
													<input type="hidden" id="time" name="time" value="">
													<input type="submit" id="submitButton" style="width: 103px;" value="Submit">
													<input type="reset" value="Clear">
													<div id="timer"></div>
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

