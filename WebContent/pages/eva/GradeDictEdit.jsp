<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<x:saveState value="#{eva_gradeBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_gradeBB.initType}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">

            <h:outputText value="名称"/>
            <h:inputText id="name" value="#{eva_gradeBB.gradebo.gradeName}" />

            <h:outputText value="描述"/>
            <h:inputTextarea id="des" value="#{eva_gradeBB.gradebo.gradeDes}" rows="5" cols="40"/>

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{eva_gradeBB.SaveType}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
