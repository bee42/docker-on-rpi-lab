<%@ page session="false" %>
<%java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");%>
<html>
<head>
	<title>Hello Docker Tomcat world!</title>
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
	<style>
	body {
		background-color: white;
		text-align: center;
		padding: 50px;
		font-family: "Open Sans","Helvetica Neue",Helvetica,Arial,sans-serif;
	}

	#logo {
		margin-bottom: 40px;
	}
	</style>
</head>
<body>
	<img id="logo" src="logo.png" />
	<h1>Docker Tomcat Status page</h1>
	  <b>Hostname :</b> <%= java.net.InetAddress.getLocalHost().getHostName() %><br />
		<b>Tomcat Version :</b> <%= application.getServerInfo() %><br/>
		<b>Servlet Specification Version :</b> <%= application.getMajorVersion() %>.<%= application.getMinorVersion() %><br />
		<b>JSP version :</b> <%=JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %><br />
		<b>Tags:</b> <%= System.getenv("SERVICE_TAGS") %><br />
		<b>Now :</b> <%= dateFormat.format(new java.util.Date()) %><br />
	<h2>You have the infrabricks line power!</h2>
</body>
</html>
