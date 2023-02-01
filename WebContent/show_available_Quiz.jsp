<%@page import="com.attendance.DatabaseConnection"%>
<%@page
	import="java.sql.*,java.io.*,java.text.*,java.util.*  ,javax.servlet.*,javax.servlet.http.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML>
<HTML>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
<link rel="stylesheet" href="bstyle.css" type="text/css">
<title>Insert title here</title>
</head>
<body>
<body>
	<%
	String quiz_title = request.getParameter("quiz_title");
	String no_question = request.getParameter("no_question");
	String quiz_id = request.getParameter("quiz_id");
	%>
	<br>
	<br>
	<div class="container">
		<div class="row">
			<div class="col-6">
				<h3>java program</h3>
			</div>
			<div class="col-6">
				<h3>
					Total no. of questions:
					10</h3>
			</div>
		</div>
		<br>
		<%
		ResultSet rs = DatabaseConnection.getResultFromSqlQuery("select * from testquiz1 where QuizId=" + 1);
		while (rs.next()) {
			String question = rs.getString("question");
			String option_a = rs.getString("option1");
			String option_b = rs.getString("option2");
			String option_c = rs.getString("option3");
			String option_d = rs.getString("option4");
			String correct_option = rs.getString("correctoption");
			String current_no = rs.getString("Qtnum");
		%>
		<div class="row">
			<div class="col-6">
				<h4><%=current_no%>.
					<%=question%></h4>
			</div>
		</div>
		<br>
		<form>
			<div class="row">
				<div class="col-6">
					<div class="form-check">
						<input class="form-check-input" type="radio"
							name="inlineRadioOptions" value="A"> <label
							class="form-check-label" for="inlineRadio1">A. <%=option_a%></label>
					</div>
				</div>
				<div class="col-6">
					<div class="form-check">
						<input class="form-check-input" type="radio"
							name="inlineRadioOptions" value="B"> <label
							class="form-check-label" for="inlineRadio1">B. <%=option_b%></label>
					</div>
				</div>
			</div>
			<br>
			<div class="row">
				<div class="col-6">
					<div class="form-check">
						<input class="form-check-input" type="radio"
							name="inlineRadioOptions" value="C"> <label
							class="form-check-label" for="inlineRadio1">C. <%=option_c%></label>
					</div>
				</div>
				<div class="col-6">
					<div class="form-check">
						<input class="form-check-input" type="radio"
							name="inlineRadioOptions" value="D"> <label
							class="form-check-label" for="inlineRadio1">D. <%=option_d%></label>
					</div>
				</div>
			</div>
			<br>
			<hr>
		</form>
		<%
}
%>
	</div>
	<br>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
		integrity="sha384- 
     DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
		crossorigin="anonymous">
		
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
		integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
		crossorigin="anonymous"></script>


</body>
</html>