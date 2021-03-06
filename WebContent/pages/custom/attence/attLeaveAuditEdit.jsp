<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  
  <script type="text/javascript">
  //验证审批原因是否过长
  function check(){
	  var reason=document.all("form1:reason").value;
	  if(reason.length>100){
		  alert("审批意见过长");
		  return false;
	  }
  }
  </script>
  
  <x:saveState value="#{attLeaveAuditBB}" />
  <h:inputHidden id="initEdit" value="#{attLeaveAuditBB.initAuditEdit}"/>
  <h:form id="form1">
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 考勤管理 ->请假审批"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="center">
		   <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
		     <h:outputText value="审批结果"/>
		     <h:selectOneMenu value="#{attLeaveAuditBB.result}">
		     	<c:selectItem itemLabel="通过" itemValue="1"/>
		     	<c:selectItem itemLabel="退回" itemValue="0"/>
		     </h:selectOneMenu>
		     <h:outputText value="审批意见"/>
             <h:inputTextarea id="reason" cols="60" rows="5" value="#{attLeaveAuditBB.reason}"></h:inputTextarea>
		   </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="审批" onclick="return check()" styleClass="button01"  action="#{attLeaveAuditBB.saveAudit}"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>