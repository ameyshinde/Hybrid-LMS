<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.attendance.*"%>
<%@ page import="java.util.*, com.bean.*"%>
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
					style="text-transform: uppercase">Student action / Add
					announcements for students</div>
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
											</div>
										</div>
										<a href="checkoutquiz.jsp"><input type="button" value="Home"
											style="color: green; background: #F1F0D1; padding-top: 5px; padding-right: 5px; padding-bottom: 5px; padding-left: 5px; border-radius: 4px; border: none; border-bottom: 4px solid #27aE60; cursor: pointer; height: 40px; width: 100px; margin-right: 30px;"></a>
										<a href="viewquizresult.jsp"><input type="button"
											value="View Detailed Result"
											style="color: green; background: #F1F0D1; padding-top: 5px; padding-right: 5px; padding-bottom: 5px; padding-left: 5px; border-radius: 4px; border: none; border-bottom: 4px solid #27aE60; cursor: pointer; height: 40px; width: 200px;">
										</a>

										<%
										Connection conn = DatabaseConnection.getConnection();
										String query1 = "select * from quiz_answers  where username=? order by quiz_no";
										String query2 = "select correct_option from quiz order by quiz_no";

										PreparedStatement st = conn.prepareStatement(query1);
										PreparedStatement st2 = conn.prepareStatement(query2);
										st.setString(1, (String) session.getAttribute("uname"));
										ResultSet rs1 = st.executeQuery();
										ResultSet rs2 = st2.executeQuery();
										int c = 0;
										int un = 0;
										int w = 0;

										while (rs1.next() && rs2.next()) {
											if (rs1.getString("userans").equals("Not Attempted")) {
												un++;
											} else if (rs1.getString("userans").equals(rs2.getString("correct_option"))) {
												c++;
											} else {
												w++;
											}
										}
										%>
										<br> <br>
										<div class='container'>
											<b class="text">Total questions = <%=(un + c + w)%><br>Correct
												answers = <%=c%><br>Wrong answers = <%=(w)%><br>Unattempted
												Questions=<%=un%><br> <br> <!-- Percentage Calculation -->
												<%
												double total = (un + c + w);
												double correct = c;
												double percent = (correct / total) * 100;
												DecimalFormat df = new DecimalFormat("##.##");
												df.format(percent);
												request.setAttribute("percent", df.format(percent));
												%>

												<div>
													The percentage is:
													<%=request.getAttribute("percent")%>%
												</div>
										</div>
										<%
										int temp = un + c + w;
										session.setAttribute("noc", c);
										session.setAttribute("temp", temp);
										conn.close();
										%>
										<div class="container"></div>
										<br> <br>
									</div>
									<br> <br>

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

