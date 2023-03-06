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
	width: 900px;
	height: auto;
	padding-left: 20px;
	background-color: rgba(52, 73, 94, 0.7);
	border-radius: 4px;
	margin: 0 auto;
	margin-top: 0px;
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
	width: 100px;
	margin-left: 30px;
	margin-top: -30px;
}

.text {
	color: #ffff80;
	font-style: oblique;
	font-size: 1.2em;
}

.correct {
	color: green;
	font-style: oblique;
	font-size: 1.2em;
}

.userchoice {
	color: #064789;
	font-style: oblique;
	
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
												String uname = request.getParameter("uname");
												Connection conn = DatabaseConnection.getConnection();
												String query1 = "select * from quiz order by quiz_no";
												String query2 = "select * from quiz_answers where username=? order by quiz_no";
												PreparedStatement ps1 = conn.prepareStatement(query1);
												PreparedStatement ps2 = conn.prepareStatement(query2);
												ps2.setString(1, uname);
												ResultSet rs1 = ps1.executeQuery();
												ResultSet rs2 = ps2.executeQuery();
												int cnum = 0;
												%>
												<div class="container">

													<b class="text">
														<h2 style="text-align: center;">Detailed result:</h2> <%
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
 %> Question <%=sno%>: <%=ques%><br> a) <%=a%><br> b) <%=b%><br>
														c) <%=c%><br> d) <%=d%><br>
													<b class="result"> Correct Choice: <%=correct%><br></b>
														User's Choice: <b class="userchoice"> <%=userans%></b><br>
														<br> <%
 }
 out.println("Number of correct answers: " + cnum);
 conn.close();
 %>
													</b>
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
<script type="text/javascript">
	$(function() {
		$('#success').delay(5000).show().fadeOut('slow');
	});
</script>
</html>

