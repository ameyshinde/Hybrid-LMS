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
					style="text-transform: uppercase">Student action / Add
					Quiz for students</div>
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
												<form action="Quiz" method="post">
													<div class="form-group row">
														<label for="quiz_no" class="col-4 col-form-label">Question
															Number </label>
														<div class="col-4">
															<input type="text" id="quiz_no" name="quiz_no"
																placeholder="" class="form-control here" value=""></input>
														</div>
													</div>
													<div class="form-group row">
														<label for="question" class="col-4 col-form-label">QUESTION
														</label>
														<div class="col-8">
															<textarea id="question" name="question" placeholder=""
																class="form-control here" type="textarea" value=""
																rows="1" cols="10"></textarea>
														</div>
													</div>
													<div class="form-group row">
														<label for="option1" class="col-4 col-form-label">Option
															A </label>
														<div class="col-4">
															<input type="text" id="option1" name="option1"
																placeholder="" class="form-control here" value=""></input>
														</div>
													</div>
													<div class="form-group row">
														<label for="option2" class="col-4 col-form-label">Option
															B </label>
														<div class="col-4">
															<input type="text" id="option2" name="option2"
																placeholder="" class="form-control here" value=""></input>
														</div>
													</div>
													<div class="form-group row">
														<label for="option3" class="col-4 col-form-label">Option
															C </label>
														<div class="col-4">
															<input type="text" id="option3" name="option3"
																placeholder="" class="form-control here" value=""></input>
														</div>
													</div>
													<div class="form-group row">
														<label for="option4" class="col-4 col-form-label">Option
															D </label>
														<div class="col-4">
															<input type="text" id="option4" name="option4"
																placeholder="" class="form-control here" value=""></input>
														</div>
													</div>
													<div class="form-group row">
														<label for="correctAnswer" class="col-4 col-form-label">Correct
															Answer </label>
														<div class="col-8">
															<div class="form-group row">
															
																<div class="col-4">
																	<input type="text" id="correctAnswer" name="correctAnswer"
																		placeholder="" class="form-control here" value=""></input>
																</div>
															</div>
														</div>
													</div>
													<div class="form-group row">
														<label for="notice" class="col-4 col-form-label"></label>
														<div class="col-8">
															<input type="submit" value="Add Quiz"
																class="btn btn-primary"> <input type="reset"
																value="Reset" class="btn btn-danger">
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

