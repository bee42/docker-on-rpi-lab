<%@ page session="false" language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");%>
{
  "Container": "<%= java.net.InetAddress.getLocalHost().getHostName() %>",
  "UUID": "<%= UUID.randomUUID()%>
  "Date": "<%= dateFormat.format(new java.util.Date()) %>",
  "Timestamp": <%= System.currentTimeMillis() / 1000 %>
  "Version": <%= System.getenv("UUID_VERSION") %>
}
