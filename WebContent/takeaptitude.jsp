<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.attendance.*"%>
<%@ page import="java.util.ArrayList, com.bean.*"%>
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
					style="text-transform: uppercase">Student action / Aptitude
					Test for students</div>
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
												<h4>Aptitude TEST</h4>
												<hr>
												<a href="selectexam.jsp"><input type="button"
													value="Home"
													style="color: green; background: #F1F0D1; padding-top: 5px; padding-right: 5px; padding-bottom: 5px; padding-left: 5px; border-radius: 4px; border: none; border-bottom: 4px solid #27aE60; cursor: pointer; height: 40px; width: 100px; margin-right: 30px;"></a>
												<a href="viewaptiresult.jsp"><input type="button"
													value="View Result"
													style="color: green; background: #F1F0D1; padding-top: 5px; padding-right: 5px; padding-bottom: 5px; padding-left: 5px; border-radius: 4px; border: none; border-bottom: 4px solid #27aE60; cursor: pointer; height: 40px; width: 100px;">
												</a><br> <br> <br>
											</div>
										</div>
										<%
										String s = (String) session.getAttribute("uname");
										Connection conn = DatabaseConnection.getConnection();
										String query2 = "select * from apti_answers where username=?";
										PreparedStatement ps = conn.prepareStatement(query2);
										PreparedStatement ps2 = conn.prepareStatement("select * from aptitude order by quiz_no");
										ps.setString(1, s);
										ResultSet rs = ps.executeQuery();

										if (rs.next()) {
											out.println("Not allowed. You have already given the test.");
											conn.close();
										} else {

											ResultSet rs2 = ps2.executeQuery();
											java.util.ArrayList list = new java.util.ArrayList();
											while (rs2.next()) {
												Question q = new Question();
												q.setSno(rs2.getInt(1));
												q.setQuestion(rs2.getString(2));
												q.setAns1(rs2.getString(3));
												q.setAns2(rs2.getString(4));
												q.setAns3(rs2.getString(5));
												q.setAns4(rs2.getString(6));
												q.setCorrect(rs2.getString(7));
												list.add(q);
											}
											session.setAttribute("dbdata", list);
											conn.close();
										%>
										<jsp:forward page="aptianswersubmit.jsp"></jsp:forward>
										<%
										}
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

