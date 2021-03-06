<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function refreshList(orgId) {
        //debugger;
        document.main.location.href = "/attence/showCalenda.jsf?PersonID=" + orgId;
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 50;
        document.getElementById("tree").style.height = "" + (mainHeight -30) + "px";
        $("iframe[name=main]").height(mainHeight);
    }
    
</script>

<h:form id="form1">
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1" align="center">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value=""/>
        </h:panelGroup>
      </h:panelGrid>

      <c:verbatim>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr><td height="8px"></td></tr>
                    <tr><td align="right">
                        </td>
                    </tr>
                    <tr><td height="8px"></td></tr>

                    <tr> <td valign="top">
                            <iframe name="tree" height="400"  frameborder="1" framespacing="0" scrolling="yes" width="100%"
                                    src="/pages/attence/ShowEmployeeCalendarType.jsp"></iframe>

                    </td></tr>
                </table>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr><td>
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                    src="/attence/showCalenda.jsf"></iframe>
                    </td></tr>
                </table>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>


