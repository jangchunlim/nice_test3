<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.apache.commons.codec.binary.Hex" %>

<!DOCTYPE html>
<html>
<head>
    <title>AUTHORIZATION RESULT(UTF-8)</title>
    <meta charset="utf-8">
    <style>
        html,body {height: 100%;}
        form {overflow: hidden;}
    </style>
</head>
<body>

<form action=payRequest.jsp" id="frm">
    <input type="hidden" name ="TID" value="Tid">
    <input type="hidden" name ="MID" value="nicepay00m">
    <input type="hidden" name ="Moid" value="test">
    <input type="text" name ="CancelAmt" value="1004">
    <label><input type="checkbox" name="PartialCancelCode" value="PartialCancelCodeYN">부분취소</label>
    <input type="hidden" name ="EdiDate" value="ediDate">

    <input type="button" id = "btn" value="취소 요청" onclick="location.href='payRequest.jsp'">

</form>
<p>*테스트 아이디인경우 당일 오후 11시 30분에 취소됩니다.</p>
</body>
</html>