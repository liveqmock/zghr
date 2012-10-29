<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
 
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
        <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
        <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
        <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
        <script type="text/javascript">
            function forAdd(form, type) {
            	 form.flag.value = type;
                document.all("form1:addMany").click();
                return true;
            }
            function forEdit(form, type) {
                form.flag.value = type;
                if (!checkMutilSelect(form.chk)) {
                    alert("请选择!");
                } else {
                    var s = selectOnlyOne(form.chk);
                    if (s != null){
                        document.all("pk").value = s;
                        forsubmit(form);
                        document.all("form1:updateMany").click();
                        return true;
                    }
                }
            }
            function forDel(form, type) {
                form.flag.value = type;
                if (checkMutilSelect(form.chk)) {
                    if (confirm("确认删除？如果要删除为上缴或下发的记录请通知对方删除相应记录")) {
                        forsubmit(form);
                        document.all("form1:delMany").click();
                        return true;
                    }
                } else {
                    alert("请选择需要删除的记录！")
                }
                return false;
            }

            function forPrintRev(form) {
                if (!checkMutilSelect(form.chk)) {
                    alert("请选择要打印的记录！");
                    return false;
                } else {
                    var s = selectOnlyOne(form.chk);
                    alert(s);
                    if (s != null){
                        windowOpen("/pages/ccp/PartyFeeRecPrint.jsf?sid="+s, "", "status=no,toolbar=no,menubar=no,location=no", "900", "600", "no");
                    }
                }
                return true;
            }

            function forPrint(form) {
                if (!checkMutilSelect(form.chk)) {
                    alert("请选择要打印的记录！");
                    return false;
                } else {
                    var s = selectOnlyOne(form.chk);
                    if (s != null){
                        windowOpen("/pages/ccp/PartyFeeBillPrint.jsf?pid="+s, "", "status=no,toolbar=no,menubar=yes,location=no", "900", "600", "no");
                    }
                }
            }
            function forExport() {
                windowOpen("/pages/common/ExportToExcel.jsp?sessionKey=<%=Constants.OBJECT_DETAIL%>", "", "status=no,toolbar=no,menubar=no,location=no", "900", "600", "no");
           }
        </script>
 
<c:verbatim><br></c:verbatim> 
<h:inputHidden value="#{ccp_PartyFeeEditBB.feeList}"/>
<h:form id="form1">
    <h:commandButton id="addMany" action="#{ccp_PartyEditBB.addMany}" style="display:none"/>
    <h:commandButton id="updateMany" action="#{org_orgEditBB.updateMany}" style="display:none"/>
    <h:commandButton id="delMany" action="#{ccp_PartyEditBB.delMany}" style="display:none"/>
    <h:panelGrid columns="1" style="table03" width="95%" align="center" >
        <h:panelGroup>
            <h:commandButton styleClass="button01" type="button" value=" 新增 " onclick="forAdd(document.forms(0),'1')" disabled="{ccp_PartyFeeEditBB.rightFlag}"/>
            <h:outputText value=" "/>
            <h:commandButton styleClass="button01" type="button" value=" 修改 " onclick="forEdit(document.forms(0),'6')" disabled="{ccp_PartyFeeEditBB.rightFlag}"/>
            <h:outputText value=" "/>
            <h:commandButton styleClass="button01" type="button" value=" 删除 " onclick="forDel(document.forms(0),'5')" disabled="{ccp_PartyFeeEditBB.rightFlag}"/>
            <h:outputText value=" "/>
            <h:commandButton type="button" styleClass="button01" value="打印收据" onclick="forPrintRev(document.forms(0))" rendered="false"/>
            <h:outputText value=" "/>
            <h:commandButton type="button" styleClass="button01" value="打印凭证" onclick="forPrint(document.forms(0))"  rendered="false"/>
            <h:outputText value=" "/>
            <h:commandButton type="button" styleClass="button01" value="导出到Excel" onclick="forExport()"/>
        </h:panelGroup>
    </h:panelGrid>
    <c:verbatim>
    <jsp:include page="/pages/common/activepage/ActiveList.jsp">
        <jsp:param name="hasOperSign" value="true"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="false"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="true"/>
        <jsp:param name="isForward" value="false"/>
        <jsp:param name="isRow" value="false"/>
        <jsp:param name="isPage" value="true"/>
        <jsp:param name="target" value="<%=Constants.OBJECT_DETAIL%>"/>
    </jsp:include>
 
    
<%
    String flag = request.getParameter("flag");
    String fk = request.getParameter("fk");
    String setId = request.getParameter("setId");
    out.println("<input type=hidden name=flag  value='" + CommonFuns.filterNull(flag) + "'>");
    out.println("<input type=hidden name=fk value='" + CommonFuns.filterNull(fk) + "'>");
    out.println("<input type=hidden name=setId value='" + CommonFuns.filterNull(setId) + "'>");
    out.println("<input type=hidden name=pk value=''>");
%>
   </c:verbatim>
</h:form>
