<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.ucc.IAttachmentUCC" %>
<%@ page import="java.io.File" %>
<%
    try {
        String receiveId = request.getParameter("receiveId");
       	String filename="/file/tmp/"+receiveId+".csv";
        if (!"".equals(filename)){
           response.sendRedirect(filename);
        }
        else{
            out.print("没有发现文件!");
        }
    } catch (Exception e) {
        out.println("\n 下载失败:"+e.getMessage());
    }
%>
