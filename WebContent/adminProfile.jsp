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
</head>
<body style="background-color: #F0F0F0";>
	<%
	if (session.getAttribute("uname") != null && session.getAttribute("uname") != "") {
	%>
	<jsp:include page="admin_side_header.jsp"></jsp:include>
	<div class="container-fluid shadow p-3 mb-5">
		<div class="panel panel-default shadow p-3 mb-5">
			<div class="panel-body">
				<div class="alert alert-info shadow p-3 mb-5"
					style="text-transform: uppercase">My Profile</div>
				<%
				String successUpdate = (String) session.getAttribute("update-success-message");
				if (successUpdate != null) {
					session.removeAttribute("update-success-message");
				%>
				<div class="alert alert-success" id='success'>Email updated
					successfully.</div>
				<%
				}
				%>
				<div class="panel panel shadow p-3 mb-5">
					<div class="panel-heading bg-light"
						style="text-transform: uppercase; font-size: small; font-weight: bold;">
						My Profile&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp;<%=(new java.util.Date()).toLocaleString()%>&nbsp;]&nbsp;&nbsp;
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-9">
								<div class="card">
									<div class="card-body">
										<div class="row">
											<%
											Connection con = DatabaseConnection.getConnection();
											Statement st = con.createStatement();
											ResultSet rs = st.executeQuery("select * from admin where uname='" + session.getAttribute("uname") + "'");
											if (rs.next()) {
											%>
											<div class="col-md-12">
												<h4>My Profile</h4>
												<hr>
											</div>
										</div>
										<div class="row">
											<div class="col-md-12">
												<form action="admin_update_process.jsp" method="post">
													<div class="form-group row">
														<label for="Id" class="col-4 col-form-label">Your
															Id</label>
														<div class="col-8">
															<input id="id" name="adminID" placeholder=""
																class="form-control here" type="text"
																value="<%=rs.getInt(1)%>" readonly>
														</div>
													</div>
													<div class="form-group row">
														<label for="name" class="col-4 col-form-label">Full
															Name </label>
														<div class="col-8">
															<input id="name" name="" placeholder=""
																class="form-control here" type="text"
																value="<%=rs.getString(2)%>" disabled>
														</div>
													</div>

													<div class="form-group row">
														<label for="email" class="col-4 col-form-label">Email</label>
														<div class="col-8">
															<input id="email" name="email" placeholder=""
																class="form-control here" type="text"
																value="<%=rs.getString(3)%>">
														</div>
													</div>
													<div class="form-group row">
														<label for="uname" class="col-4 col-form-label">User
															Name</label>
														<div class="col-8">
															<input id="uname" name="" placeholder=""
																class="form-control here" required="required"
																type="text" value="<%=rs.getString(4)%>" disabled>
														</div>
													</div>
													<input type="submit" class="btn btn-primary"
														value="Update Information">
												</form>
											</div>
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
