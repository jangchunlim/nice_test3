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
<%
request.setCharacterEncoding("utf-8"); 
/*
****************************************************************************************
* <인증 결과 파라미터>
****************************************************************************************
*/
String authResultCode 	= (String)request.getParameter("AuthResultCode"); 	// 인증결과 : 0000(성공)
String authResultMsg 	= (String)request.getParameter("AuthResultMsg"); 	// 인증결과 메시지
String nextAppURL 		= (String)request.getParameter("NextAppURL"); 		// 승인 요청 URL
String txTid 			= (String)request.getParameter("TxTid"); 			// 거래 ID
String authToken 		= (String)request.getParameter("AuthToken"); 		// 인증 TOKEN
String payMethod 		= (String)request.getParameter("PayMethod"); 		// 결제수단
String mid 				= (String)request.getParameter("MID"); 				// 상점 아이디
String moid 			= (String)request.getParameter("Moid"); 			// 상점 주문번호
String amt 				= (String)request.getParameter("Amt"); 				// 결제 금액
String reqReserved 		= (String)request.getParameter("ReqReserved"); 		// 상점 예약필드
String netCancelURL 	= (String)request.getParameter("NetCancelURL"); 	// 망취소 요청 URL


%>
<!DOCTYPE html>
<html>
<head>
	<title>NICEPAY PAY RESULT(UTF-8)</title>
	<meta charset="utf-8">
	<style>
		html,body {height: 100%;}
		form {overflow: hidden;}
	</style>
	<script type="text/javascript">
		//결제창 최초 요청시 실행됩니다.
		function call_pay_process(){
			document.payForm.action = "pay_process.jsp";
			document.payForm.acceptCharset="euc-kr";
			document.payForm.submit();
		}
	</script>
</head>
<body>
	<table>
		<tr>
			<th>authResultCode 인증결과</th>
			<td><%=authResultCode%></td>
		</tr>
		<tr>
			<th>authResultMsg 인증결과 메시지</th>
			<td><%=authResultMsg%></td>
		</tr>
		<tr>
			<th>nextAppURL 승인 요청 URL</th>
			<td><%=nextAppURL%></td>
		</tr>
		<tr>
			<th>txTid 거래 ID</th>
			<td><%=txTid%></td>
		</tr>
		<tr>
			<th>authToken 인증 TOKEN</th>
			<td><%=authToken%></td>
		</tr>
		<tr>
			<th>payMethod 결제수단</th>
			<td><%=payMethod%></td>
		</tr>
		<tr>
			<th>mid 상점 아이디</th>
			<td><%=mid%></td>
		</tr>
		<tr>
			<th>moid 상점 주문번호</th>
			<td><%=moid%></td>
		</tr>
		v
		<tr>
			<th>amt 결제 금액</th>
			<td><%=amt%></td>
		</tr>
		<tr>
			<th>reqReserved 상점 예약필드</th>
			<td><%=reqReserved%></td>
		</tr>
		<tr>
			<th>netCancelURL 망취소 요청 URL</th>
			<td><%=netCancelURL%></td>
		</tr>

	</table>
	<form id="payForm" name="payForm" action="">
		<input type="hidden" name="authResultCode" value="<%=authResultCode%>">
		<input type="hidden" name="authResultMsg" value="<%=authResultMsg%>">
		<input type="hidden" name="nextAppURL" value="<%=nextAppURL%>">
		<input type="hidden" name="txTid" value="<%=txTid%>">
		<input type="hidden" name="authToken" value="<%=authToken%>">
		<input type="hidden" name="payMethod" value="<%=payMethod%>">
		<input type="hidden" name="mid" value="<%=mid%>">
		<input type="hidden" name="moid" value="<%=moid%>">
		<input type="hidden" name="amt" value="<%=amt%>">
		<input type="hidden" name="reqReserved" value="<%=reqReserved%>">
		<input type="hidden" name="netCancelURL" value="<%=netCancelURL%>">
	</form>
	<input type="button" value="승인 요청" onclick="javascript:call_pay_process();">

<%--	<button onclick="location=windows.open('pay_process.jsp')">승인 요청</button>--%>
<%--	<a href="#" class="btn_blue" onClick="nicepayStart();"> 승인 요청</a>--%>
	<p>*테스트 아이디인경우 당일 오후 11시 30분에 취소됩니다.</p>
</body>
</html>
<%!
public final synchronized String getyyyyMMddHHmmss(){
	SimpleDateFormat yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");
	return yyyyMMddHHmmss.format(new Date());
}

// SHA-256 형식으로 암호화
public class DataEncrypt{
	MessageDigest md;
	String strSRCData = "";
	String strENCData = "";
	String strOUTData = "";
	
	public DataEncrypt(){ }
	public String encrypt(String strData){
		String passACL = null;
		MessageDigest md = null;
		try{
			md = MessageDigest.getInstance("SHA-256");
			md.reset();
			md.update(strData.getBytes());
			byte[] raw = md.digest();
			passACL = encodeHex(raw);
		}catch(Exception e){
			System.out.print("암호화 에러" + e.toString());
		}
		return passACL;
	}
	
	public String encodeHex(byte [] b){
		char [] c = Hex.encodeHex(b);
		return new String(c);
	}
}

//server to server 통신
public String connectToServer(String data, String reqUrl) throws Exception{
	HttpURLConnection conn 		= null;
	BufferedReader resultReader = null;
	PrintWriter pw 				= null;
	URL url 					= null;
	
	int statusCode = 0;
	StringBuffer recvBuffer = new StringBuffer();
	try{
		url = new URL(reqUrl);
		conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setConnectTimeout(3000);
		conn.setReadTimeout(5000);
		conn.setDoOutput(true);
		
		pw = new PrintWriter(conn.getOutputStream());
		pw.write(data);
		pw.flush();
		
		statusCode = conn.getResponseCode();
		resultReader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
		for(String temp; (temp = resultReader.readLine()) != null;){
			recvBuffer.append(temp).append("\n");
		}
		
		if(!(statusCode == HttpURLConnection.HTTP_OK)){
			throw new Exception();
		}
		
		return recvBuffer.toString().trim();
	}catch (Exception e){
		return "9999";
	}finally{
		recvBuffer.setLength(0);
		
		try{
			if(resultReader != null){
				resultReader.close();
			}
		}catch(Exception ex){
			resultReader = null;
		}
		
		try{
			if(pw != null) {
				pw.close();
			}
		}catch(Exception ex){
			pw = null;
		}
		
		try{
			if(conn != null) {
				conn.disconnect();
			}
		}catch(Exception ex){
			conn = null;
		}
	}
}

//JSON String -> HashMap 변환
private static HashMap jsonStringToHashMap(String str) throws Exception{
	HashMap dataMap = new HashMap();
	JSONParser parser = new JSONParser();
	try{
		Object obj = parser.parse(str);
		JSONObject jsonObject = (JSONObject)obj;

		Iterator<String> keyStr = jsonObject.keySet().iterator();
		while(keyStr.hasNext()){
			String key = keyStr.next();
			Object value = jsonObject.get(key);
			
			dataMap.put(key, value);
		}
	}catch(Exception e){
		
	}
	return dataMap;
}
%>