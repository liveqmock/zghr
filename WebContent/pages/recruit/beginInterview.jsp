<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp" %>
     
<x:saveState value="#{BeginInteviewBB}" />
 <h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{BeginInteviewBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 面试管理 -> 开始面试"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="100%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="岗位名称"></h:outputText>
               <h:inputText value="#{BeginInteviewBB.detailbo.postName}" readonly="true"></h:inputText>
              
			   <h:outputText value="面试人"></h:outputText>
               <h:selectOneMenu value="#{BeginInteviewBB.resultbo.viewer}">
                      <c:selectItems value="#{BeginInteviewBB.personList}"></c:selectItems>
               </h:selectOneMenu>
            	
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="开始面试" id="save"  action="#{BeginInteviewBB.beginInterview}"  styleClass="button01"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>


