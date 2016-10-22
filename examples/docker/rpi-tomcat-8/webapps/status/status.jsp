<%@ page session="false" language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");%>
{
  "Hostname": "<%= java.net.InetAddress.getLocalHost().getHostName() %>",
  "TomcatVersion": "<%= application.getServerInfo() %>",
  "ServletSpecificationVersion": "<%= application.getMajorVersion() %>.<%= application.getMinorVersion() %>",
  "JspVersion": "<%=JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %>",
  "Tags": "<%= System.getenv("SERVICE_TAGS") %>",
  "Date": "<%= dateFormat.format(new java.util.Date()) %>",
  "Timestamp": <%= System.currentTimeMillis() / 1000 %>
}
