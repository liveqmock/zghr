<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim>
    
     <link href="/css/editor.css" rel="stylesheet" type="text/css"/>
        <script language="javascript" src="/js/commonFuns.js"></script>
        <script language="javascript" src="/js/editor2.js"></script>
        <script language="javascript" src="/js/editor_toolbar.js"></script>
</c:verbatim>
<script type="text/javascript">
    function forCheck() {
        if(forsubmit(document.forms(0))){
             return true;
        }
        else{
            return false;
        }
    }
</script>
<c:verbatim><base target='_self'></c:verbatim>
<x:saveState value="#{Train_planAuditeditBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{Train_planAuditeditBB.initAudit}"></h:inputHidden>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value="培训管理 -> 培训计划查看"/>
        </h:panelGroup>
    </h:panelGrid>
    <br>
	<h:panelGrid align="center" width="98%" columns="1">
		<h:panelGrid width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
            
			<h:outputText value="审批意见"/>
            <h:inputText id="意见" readonly="true" value="#{Train_planAuditeditBB.planbo.auditResult}" />
            <h:outputText value="原因"/>
            <h:inputTextarea value="#{Train_planAuditeditBB.planbo.auditContent}" rows="3" cols="80" readonly="true"/>
        </h:panelGrid>
		<h:panelGrid width="100%" columns="4" cellspacing="2" columnClasses="td_form01,td_form02,td_form01,td_form02" styleClass="table03">
			<h:outputText value="名称"/>
            <h:inputText id="name" readonly="true" value="#{Train_planAuditeditBB.planbo.planName}" />
       		<h:outputText value="计划年度"/>
            <h:inputText id="year" readonly="true" value="#{Train_planAuditeditBB.planbo.year}" />
      		<h:outputText value="计划季度"/>
            <h:inputText id="jidu" readonly="true" value="#{Train_planAuditeditBB.planbo.dateType}" />
        	<h:outputText value="计划月份"/>
            <h:inputText id="month" readonly="true" value="#{Train_planAuditeditBB.planbo.month}" />
        	<h:outputText value="预算总额"/>
            <h:inputText id="budget" readonly="true" value="#{Train_planAuditeditBB.planbo.planBudget}" />
       		<h:outputText value="计划人数"/>
            <h:inputText id="renshu" readonly="true" value="#{Train_planAuditeditBB.planbo.createaOper}" />
		</h:panelGrid>
        
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
			<h:outputText value="培训计划描述"/>
            <h:inputTextarea id="desc" value="#{TrainPlan_makeBB.trainPlanbo.planDesc}" cols="75" rows="3" style="display:none;"/>
            <c:verbatim>
                <script language="javascript">
                    gFrame = 1;//1-在框架中使用编辑器
                    gContentId = "form1:desc";//要载入内容的content ID
                    OutputEditorLoading();
                </script>
                <iframe id="HtmlEditor" class="editor_frame" frameborder="0" marginheight="0" marginwidth="0" style="width:100%;height:300px;overflow:visible;" ></iframe>
            </c:verbatim>
	    </h:panelGrid>
	 </h:panelGrid>
</h:form>
