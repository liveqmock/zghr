<%@page import="com.hr319wg.custom.util.CommonUtil"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>系统超时</title>
</head>

<body>
        <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
           <tr>
                <script type="text/javascript">
                    document.write("<td  height='100%' width='100%'  ><img src='/<%=CommonUtil.getSYS_INTERFACE()[0] %>' width=100% height=100% style='position:absolute;top:0;left:0;z-index:-1'></td>");
                </script>
           </tr>
        </table>

  <script  language="javascript">
 		 /*
 		 单点登录时，有时会出现问题，屏蔽
        if(window.opener != null){
            window.opener.location = "/pages/overtime.jsp";
            this.close();
        }
          */
        var p = window.parent;
        var cur = this;
        //找到最上级页面
        while(p != cur)
        {
           p = p.parent;
           cur = p;
        }
        if(p != this)     p.location = "overtime.jsp"
      
    </script>

        <script type="text/javascript">
            var logintop=document.body.clientHeight/2;
            var contentStr="<table   style='POSITION: absolute; top:"+logintop+"px;' width='100%' cellspacing=0 cellpadding=0 border=0>";
            document.write(contentStr);
        </script>
          <tr><td align="center">
          <font size="6">系统连接超时，请重新<a href="/index.jsp"><font color="red">登录</font></a>！</font>
          </td></tr>
        <script type="text/javascript">
            document.write("</table>");
        </script>
</body>
</html>
