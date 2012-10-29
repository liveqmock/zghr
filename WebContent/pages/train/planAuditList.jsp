<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>

<f:verbatim>
    <script type="text/javascript">
        function doAudit(id){
            window.showModalDialog("/train/trainPlanAuditEdit.jsf?planID="+id, null, "dialogWidth:630px; dialogHeight:700px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function doQuery(id){
        	 window.showModalDialog("/train/trainPlanAuditQuery.jsf?planID="+id, null, "dialogWidth:630px; dialogHeight:700px;center:center;resizable:yes;status:no;scroll:no;");
             return true;
        }
        function viewAtt(id){
       	 window.open('/pages/train/download.jsp?attachmentId='+id, "", 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+0.9*screen.width+',height='+0.9*screen.height+',left='+0.05*screen.width+', top='+0.05*screen.height);
       	}
        function trainClassManager(id){
            window.showModalDialog("/train/trainClassManager.jsf?planID="+id, "", "dialogWidth:"+screen.width*0.75+"px; dialogHeight:550px; status:0;resizable:yes");
            return true;
        }
    </script>
</f:verbatim>
<x:saveState value="#{TrainPlan_auditBB}"/>
<h:form id="form1">
    <h:inputHidden value = "#{TrainPlan_auditBB.initPlanAudit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{TrainPlan_auditBB.superId}"></h:inputHidden>
   
   <c:verbatim>
       <table height="98%" width="98%" align="center">
       <tr><td height="8"> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="当前机构:"></h:outputText>
                  <h:outputText value="#{TrainPlan_auditBB.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
          	 <h:panelGroup>
            	<h:selectBooleanCheckbox value="#{TrainPlan_auditBB.selectAll}" onclick="submit();" valueChangeListener="#{TrainPlan_auditBB.queryAll}"/>
				<h:outputText value="全部显示"/>
          	</h:panelGroup>
         	<h:panelGroup>
                <h:outputText value="记录数:#{TrainPlan_auditBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{TrainPlan_auditBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{TrainPlan_auditBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{TrainPlan_auditBB.mypage.currentPage}页"></h:outputText>
	            <h:commandButton value="首页" action="#{TrainPlan_auditBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{TrainPlan_auditBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{TrainPlan_auditBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{TrainPlan_auditBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    
    <x:dataTable value="#{TrainPlan_auditBB.planList}" width="100%" var="list"  rowIndexVar="index" align="center" id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03"  >
             <h:column>
	             <c:facet name="header"><h:outputText value="序号"/></c:facet>
	             <h:outputText value="#{index+1}"/>
       		 </h:column>
       		
       		<h:column>
                <c:facet name="header"><h:outputText value="计划名称"/></c:facet>
                <h:outputText value="#{list.planName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="状态"/></c:facet>
                <h:outputText value="#{list.statusDes}"/>
            </h:column>
            
             <h:column>
                <c:facet name="header"><h:outputText value="审批意见"/></c:facet>
                <h:outputText value="#{list.auditContent}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="计划时间"/></c:facet>
                <h:outputText value="#{list.dateValue}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="预算总额"/></c:facet>
                <h:outputText value="#{list.planBudget}"/>
            </h:column>
            
			 <h:column>
                <c:facet name="header"><h:outputText value="计划人数"/></c:facet>
                <h:outputText value="#{list.createaOper}"/>
            </h:column>
            <h:column>
            <c:facet name="header"><h:outputText value="附件"/></c:facet>
            <h:outputText value="无" rendered="#{list.isHaveAtt=='0'}"/>
            <h:commandLink value="附件"  rendered="#{list.isHaveAtt=='1'}" onclick="viewAtt('#{list.planAtt}')">
   			</h:commandLink>
        </h:column>
        <h:column>
                 <c:facet name="header"><h:outputText value="操作"/></c:facet>
                 <h:commandButton value="审批" styleClass="button01" rendered="#{list.status=='1' && list.canAudit=='1'}" onclick="return doAudit('#{list.planID}');"></h:commandButton>
                 <h:commandButton value="查看" styleClass="button01" onclick="return doQuery('#{list.planID}');"></h:commandButton>
                 <h:commandButton value="查看培训班" onclick="return trainClassManager('#{list.planID}')" styleClass="button01"></h:commandButton>
                 <h:commandButton value="查看流程" onclick="return showWorkFlowLogByLinkID('#{list.planID}')" styleClass="button01" rendered="#{TrainPlan_auditBB.isWorkFlow=='1'}"></h:commandButton>
            </h:column>
    </x:dataTable>
    
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>