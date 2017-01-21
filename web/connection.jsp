<%-- 
    Document   : connection
    Created on : May 31, 2016, 1:34:28 PM
    Author     : vicky
--%>

<%@ page import="java.sql.*" %>
<%!
Connection con;
Statement stat;
ResultSet rs;
ResultSetMetaData md;
%>
<%
//MS Access or SQL Server
//Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
//con=DriverManager.getConnection("jdbc:odbc:Sunil", "sa", "ppp");

//Oracle
//Class.forName("oracle.jdbc.OracleDriver");
//con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "ppp");

//MySql
Class.forName("com.mysql.jdbc.Driver");
con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vik", "root", "");


stat=con.createStatement();
%>
