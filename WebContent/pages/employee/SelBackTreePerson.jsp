<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String rootId = CommonFuns.filterNull(request.getParameter("rootId"));

%>
    <c:verbatim> <base target="_self">
    <script type="text/javascript">
        function refreshList(orgId) {
            document.main.location.href = "/employee/PersonQuery.jsf?flag=1&superId=" + orgId+"&rightFlag=<%=CommonFuns.filterNull(request.getParameter("rightFlag"))%>";
        }
        with (window) onload = onresize = function()   {
            var mainHeight = document.body.offsetHeight - 39;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
    </script>


<table width="100%" border="0" cellpadding="2" cellspacing="0" class="table03">
    <tr>
        <td class="table01" id="showTree" width="200">
                    <iframe name="tree" height="400"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                            height="465" src="/pages/common/ShowOrgTree.jsp?rootId=<%=rootId%>"></iframe>
        </td>

        <td width="5" class="ctrlbar" valign="middle">
            <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>

        <td align="center" valign="top">
                   <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                height="465" src="/employee/PersonQuery.jsf?rightFlag=<%=CommonFuns.filterNull(request.getParameter("rightFlag"))%>"></iframe>
        </td>
    </tr>
</table>
</c:verbatim>