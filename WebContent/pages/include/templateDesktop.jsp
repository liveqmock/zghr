<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="taglib.jsp" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/html;charset=GBK");
%>
<html>
<c:view>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8;"/>
    <meta http-equiv="Content-Type" content="text/html;charset=GBK"/>
    <title>
    	<%
	        if ("1".equals(Constants.USE_OAMAIN)){
	            out.println(Constants.OA_SYSTEM_NAME);
	        }
	        else{
	            out.println(Constants.SYSTEM_NAME);
	        }
	    %>
    </title>
    <link href="/css/styleDesktop.css" rel="stylesheet" type="text/css"/>
    <script src="<%=request.getContextPath()%>/js/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript" src="/js/Appclient.js"></script>
    <script type="text/javascript" language="javascript" src="/js/check.js"></script>
    <script type="text/javascript">
        //document.oncontextmenu=function(e){return false;}
    </script>
    
</head>
<body BGCOLOR=<%=Constants.BGCOLOR%>>
    <tiles:insert attribute="body" flush="true"/>
    <script language="javascript" src="/pages/common/DatePicker/WdatePicker.js"></script>
</body>
</c:view>
</html>