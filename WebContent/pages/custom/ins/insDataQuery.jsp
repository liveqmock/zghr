<%@page import="com.hr319wg.custom.util.CommonUtil"%>
<%@page import="com.hr319wg.custom.pojo.bo.UserBO"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%
User user = (User) (session.getAttribute(Constants.USER_INFO));
String rootid = user.getOrgId();
String status = request.getParameter("status");
String wageDate = request.getParameter("wageDate");
String ID = request.getParameter("ID");
%>
<script type="text/javascript">
        function refreshList(orgId,pId) {
        	var id = "";
        	if(pId != null){//根节点不传值，后台查询所有
        		id = "3053"+orgId;
        	}
            document.main.location.href = "/custom/ins/insDataQueryList.jsf?act=init&ID=<%=ID%>&operWageDate=<%=wageDate%>&operStatus=<%=status%>&orgID=" + id;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 34;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
    </script>
<f:view>
<h:form id="form1">
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">保险管理 -> 缴费基数计算</td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                        <iframe name="tree" height="400"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                               src="/pages/common/ShowOrgTree_sec.jsp"></iframe>
            </td>
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>
            <td align="center" valign="top">
				<iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%" src="/custom/ins/insDataQueryList.jsf?act=init&ID=<%=ID%>&operWageDate=<%=wageDate%>&operStatus=<%=status%>"></iframe>
            </td>
        </tr>
    </table>
    </c:verbatim>
</h:form>

</f:view>
