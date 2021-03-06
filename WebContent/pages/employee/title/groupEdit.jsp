<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp" %>
<script type="text/javascript">
</script>

<x:saveState value="#{emptitleauditgroupmgrBB}" />
<h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{emptitleauditgroupmgrBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 人员管理 ->职称管理"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="名称"></h:outputText>
               <h:inputText value="#{emptitleauditgroupmgrBB.groupbo.groupName}"></h:inputText>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="保存" id="save" action="#{emptitleauditgroupmgrBB.saveGroup}"   styleClass="button01" />
           </h:panelGrid>
      </h:panelGrid>
  </h:form>

