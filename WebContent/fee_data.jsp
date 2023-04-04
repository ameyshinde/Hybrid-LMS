<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.attendance.DatabaseConnection"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.util.Random"%>
<%@page import="java.util.UUID"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Hybrid LMS</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css" />
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
				<div class="alert alert-info shadow p-3 mb-5 "
					style="text-transform: uppercase">Admin Actions / Fee
					Details</div>
				<%
				String successUpdate = (String) session.getAttribute("update-success-message");
				if (successUpdate != null) {
					session.removeAttribute("update-success-message");
				%>
				<div class="alert alert-success" id='success'>Record updated
					successfully.</div>
				<%
				}
				%>
				<div class="panel panel-muted shadow p-3 mb-5">
					<div class="panel-heading bg-light"
						style="text-transform: uppercase">
						<strong>Fee Details &nbsp;[&nbsp;<%=(new java.util.Date()).toLocaleString()%>&nbsp;]&nbsp;&nbsp;
						</strong>
					</div>
					<div class="panel-body">
						<form action="" method="post">
							<table id="table" class="table table-bordered">
								<thead>
									<tr>
										<th>Student Name</th>
										<th>BRANCH</th>
										<th>Fee Type</th>
										<th>Amount</th>
										<th>UTR Number</th>
										<th>File Name</th>
										<th>Upload Date</th>
										<th>Download</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<%
									Connection con = DatabaseConnection.getConnection();
									PreparedStatement ps = con.prepareStatement("select * from fee_Details");
									ResultSet rs = ps.executeQuery();
									while (rs.next()) {
									%>
									<tr>
										<td><%=rs.getString(2)%></td>
										<td><%=rs.getString(3)%></td>
										<td><label style='color: #33b5e5;'><%=rs.getString(4)%></label></td>
										<td><label style='color: green;'><%=rs.getInt(5)%></label></td>
										<td><%=rs.getString(6)%></td>
										<td><%=rs.getString(7)%></td>
										<td><span class="label label-warning"><%=rs.getDate(8)%></span></td>
										<td><a
											href="downloadFeeDetail?fileName=<%=rs.getString(7)%>">Download</a></td>
										<td><a
											href="DeleteFeeDetail?fileName=<%=rs.getString(7)%>"><button
													class="btn btn-danger"
													onClick="return confirm('Are you sure, you want to Delete this File?');">Delete</button></a></td>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>
						</form>
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
<script src="js/jquery-3.1.1.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/script.js"></script>
<script src="js/jquery.dataTables.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#table').DataTable();
	})
</script>
<script type="text/javascript">
	$(function() {
		$('#success').delay(5000).show().fadeOut('slow');
	});
</script>
</html>
