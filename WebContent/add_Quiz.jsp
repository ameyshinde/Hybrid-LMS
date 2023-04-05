<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.attendance.*"%>
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
<styel> .space{ margin-left:50%; margin:50px; </styel>
<style type="text/css">
.container {
	width: 950px;
	height: 440px;
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
	<jsp:include page="faculty_side_header.jsp"></jsp:include>
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
						Save Quiz&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;<%=(new java.util.Date()).toLocaleString()%>&nbsp;]&nbsp;&nbsp;
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-9">
								<div class="card">
									<div class="card-body">
										<div class="row">
											<div class="col-md-12">
												<div class="space">
													<nav class="navbar navbar-light bg-light">
														<b><a class="navbar-brand">QUIZ TEST</a></b>
														<form class="form-inline">
															<a href="view_quizDB.jsp"><input type="button"
																value="View Questions" class="btn btn-info"></a>&emsp;&emsp;
															<a href="delete_Quiz.jsp"><input type="button"
																value="Delete Question" class="btn btn-info"></a>
														</form>
													</nav>

												</div>

												<hr>
											</div>
										</div>
										<div class="container">
											<div class="row">
												<div class="col-md-12">
													<form action="Quiz" method="post">
														<div class="form-group row">
															<label for="quiz_no" class="col-4 col-form-label"><b
																class="text">Question Number </b></label>
															<div class="col-4">
																<input type="number" id="quiz_no" name="quiz_no"
																	placeholder="" class="form-control here" value=""></input>
															</div>
														</div>
														<div class="form-group row">
															<label for="question" class="col-4 col-form-label"><b
																class="text">QUESTION</b> </label>
															<div class="col-8">
																<textarea id="question" name="question" placeholder=""
																	class="form-control here" type="textarea" value=""
																	rows="1" cols="10" oninput="validateInput(event)"></textarea>
															</div>
														</div>
														<div class="form-group row">
															<label for="option1" class="col-4 col-form-label"><b
																class="text">Option A </b></label>
															<div class="col-6">
																<input type="text" id="option1" name="option1"
																	placeholder="" class="form-control here" value=""
																	oninput="validateInput(event)"></input>
															</div>
														</div>
														<div class="form-group row">
															<label for="option2" class="col-4 col-form-label"><b
																class="text">Option B </b></label>
															<div class="col-6">
																<input type="text" id="option2" name="option2"
																	placeholder="" class="form-control here" value=""
																	oninput="validateInput(event)"></input>
															</div>
														</div>
														<div class="form-group row">
															<label for="option3" class="col-4 col-form-label"><b
																class="text">Option C </b></label>
															<div class="col-6">
																<input type="text" id="option3" name="option3"
																	placeholder="" class="form-control here" value=""
																	oninput="validateInput(event)"></input>
															</div>
														</div>
														<div class="form-group row">
															<label for="option4" class="col-4 col-form-label"><b
																class="text">Option D </b></label>
															<div class="col-6">
																<input type="text" id="option4" name="option4"
																	placeholder="" class="form-control here" value=""
																	oninput="validateInput(event)"></input>
															</div>
														</div>
														<div class="form-group row">
															<label for="correctAnswer" class="col-4 col-form-label"><b
																class="text">Correct Answer </b></label>
															<div class="col-8">
																<div class="form-group row">

																	<div class="col-9">
																		<input type="text" id="correctAnswer"
																			name="correctAnswer" placeholder=""
																			class="form-control here" value=""
																			oninput="validateInput(event)"></input>
																	</div>
																</div>
															</div>
														</div>
														<div class="form-group row">
															<label for="notice" class="col-4 col-form-label"></label>
															<div class="col-8">
																<input type="submit" value="Add Quiz"
																	class="btn btn-primary">&emsp;&emsp; <input
																	type="reset" value="Reset" class="btn btn-danger">
															</div>
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
	function validateInput(event) {
		console.log("Warning,Stop Trying to use XSS attack!");
		const input = event.target.value;
		const safeInput = input.replace(/<script>/gi, '');
		event.target.value = safeInput;
	}
</script>
</html>

