# Method
A Web-Application Based on JAVA Framework including Multiple Features in a Single Dashboard ie. Leaves Management, Feedback Management, 
Quiz Management, Project Management, Complaints Management, Attendance Management, Students Fee Details Management , Student-Faculty Management , Student Course Management

Tech-Stack :- HTML, CSS, JS,Bootstrap, JSP, Java Servlets,Apache Tomcat, IOT

First, clone or download the source code from github
Then, import the Hybrid_LMS.sql script to MySQL
Then, go to the DBConnection.java, change your connection string
private String url = "jdbc:mysql://localhost:3306/student_attedance”;
private String username = "root";
private String password = “root”;

Then, change your UPLOAD_DIRECTORY Folder for files in com.assignment package
private final String UPLOAD_DIRECTORY =  "<UPLOAD_DIRECTORY>" + "submission";

private final String UPLOAD_DIRECTORY =  "<UPLOAD_DIRECTORY>" + "assignment";

String filePath = "<UPLOAD_DIRECTORY>" + request.getParameter("filename");

Make Changes in web.xml file for Email sending Credentials
Change Email to your email
Make a New Google Application Password from your Google Account and add it to Web.xml file

Make Sure to Change RunTime in Project Facets Setting

Finally, run the application on Apache Tomcat Server 👍.

