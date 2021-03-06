<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User)session.getAttribute(Constants.USER_INFO);
    String rootid = user.getOrgId();

%>
<c:verbatim>
    <script type="text/javascript">
        function refreshList(orgId) {
        	document.main.location.href = "/custom/emp/typeChangeQuery.jsf?superId=" + orgId;
        }
        
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 35;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
        function setType() {
            window.showModalDialog("/custom/emp/orgTypeChangeEdit.jsf?act=init", null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
            return false;
        }
    </script>
</c:verbatim>

<h:form id="form1">
    <f:verbatim>
    <table  width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
              	人员管理 -> 人员类别变动
             </td>
             <td align="left" class=td_title>
              </f:verbatim>
               		<h:commandButton value="薪酬变动项目设置" styleClass="button01"	onclick="return setType()" />
               <f:verbatim>
               </td>
        </tr>
    </table>

    <table width="100%" border="0"  height="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210" height="100%" valign="top">
                  <iframe name="tree" height="400"  frameborder="0"  height="100%" scrolling="auto" width="100%"
                                    src="/pages/common/ShowOnlyOrgTree.jsp"></iframe>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar();">
            </td>

            <td align="center" valign="top" height="100%">
                 <iframe name="main" height="100%"  frameborder="0"  height="100%" scrolling="no" width="100%"
                     src="/custom/emp/typeChangeQuery.jsf?superId=<%=user.getOrgId()%>"></iframe>
            </td>
        </tr>
    </table>
    </f:verbatim>    
</h:form>

