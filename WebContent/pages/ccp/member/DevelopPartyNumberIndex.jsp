<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

%>

    <script type="text/javascript">
        function refreshList(orgId) {
        	 document.main.location.href = "/ccp/member/DevelopInfoQuery.jsf?superId=" + orgId + "&flag=1&pageFlag=2";
        }
        with (window) onload = onresize = function()
        {
            var mainHeight = document.body.offsetHeight - 39;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
    </script>

<h:form id="form1">
    <h:panelGrid width="100%" border="0" cellpadding="0" cellspacing="0"  styleClass="td_title">
        <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value="��չ��Ա"/>
        </h:panelGroup>
    </h:panelGrid>
    
    <c:verbatim>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table03">
        <tr>
            <td class="table01" id="showTree" width="159">
                            <iframe name="tree" height="400"  frameborder="0"  scrolling="yes" width="100%"
                                     src="/pages/common/ShowOrgTree.jsp"></iframe>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0"  scrolling="yes" width="100%"
                                   src="/ccp/member/DevelopInfoQuery.jsf"  ></iframe>
            </td>
        </tr>
    </table>
    </c:verbatim>
</h:form>
