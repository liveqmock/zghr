<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function addDictionary(){
        window.showModalDialog("/eLearn/DictEdit.jsf", null, "dialogWidth:330px; dialogHeight:140px;center:center;resizable:no;status:no;scroll:no;");
        document.tree.location.href="/pages/eLearn/ShowCourceDir.jsp";
    }
    function modifyDictionary(){
        if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
            alert("请选择要删除的类别!");
            return false;
        }
        window.showModalDialog("/eLearn/DictEdit.jsf?TypeID="+document.all("form1:currentID").value, null, "dialogWidth:330px; dialogHeight:140px;center:center;resizable:no;status:no;scroll:no;");
        document.tree.location.href="/pages/eLearn/ShowCourceDir.jsp";
        return false;
    }
    function deletedDictionary(){
        if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
            alert("请选择要删除的类别!");
            return false;
        }
        if (confirm("确定要删除吗?")){
            return true;
        }
        else{
            return false;
        }
    }
    function refreshList(orgId) {
        document.all("form1:currentID").value=orgId;
        document.main.location.href = "/eLearn/CourceWareManListChild.jsf?superId=" + orgId;
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 80;
        $("iframe[name=tree]").height(mainHeight);
        $("iframe[name=main]").height(mainHeight);
    }
    
</script>

<h:form id="form1">
	  <h:inputHidden id="currentID" value="#{eLearn_courcebb.dicID}"></h:inputHidden>
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1" align="center">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="#{eLearn_courcebb.unitName}培训课件管理"/>
        </h:panelGroup>
      </h:panelGrid>

       <f:verbatim>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr><td height="8px"></td></tr>
                    <tr><td align="right">
</f:verbatim>
                        <h:commandButton styleClass="button01" type="button" value="增加" onclick="addDictionary();"></h:commandButton>
                        <h:commandButton styleClass="button01" type="button" value="修改" onclick="modifyDictionary()"></h:commandButton>
                        <h:commandButton styleClass="button01"  value="删除" action="#{eLearn_courcebb.DeleteType}" onclick="return deletedDictionary();"></h:commandButton>
<f:verbatim>
                        </td>
                    </tr>
                    <tr><td height="8px"></td></tr>

                    <tr> <td valign="top">
                            <iframe name="tree" height="400"  frameborder="1" framespacing="0" scrolling="yes" width="100%"
                                    src="/pages/eLearn/ShowCourceDir.jsp"></iframe>
                    </td></tr>
                </table>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                    src="/eLearn/CourceWareManListChild.jsf"></iframe>
            </td>
        </tr>
    </table>
</f:verbatim>    
</h:form>


