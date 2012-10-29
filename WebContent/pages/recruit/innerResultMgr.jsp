<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function showSignPerson(id){
            window.showModalDialog("/recruit/showSignPerson.jsf?planID="+id, "", "dialogWidth:800px; dialogHeight:600px; status:0;resizable:yes");
            return true;
        }
    </script>

<x:saveState value="#{innerRecuResultBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{innerRecuResultBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{innerRecuResultBB.superId}"></h:inputHidden>
    
     <c:verbatim>
       <table height=98% width=98% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif"> 招聘管理-> 结果公布</td>
        </tr>
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="记录数:#{innerRecuResultBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{innerRecuResultBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{innerRecuResultBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{innerRecuResultBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{innerRecuResultBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{innerRecuResultBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{innerRecuResultBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{innerRecuResultBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{innerRecuResultBB.planList}" var="list" rowIndexVar="index" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
               <c:facet name="header"><h:outputText value="序号"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="计划名称"/></c:facet>
            <h:outputText value="#{list.planName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="计划类型"/></c:facet>
            <h:outputText value="#{list.planType}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="计划方式"/></c:facet>
            <h:outputText value="#{list.plaMethodDesc}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="预算"/></c:facet>
            <h:outputText value="#{list.budget}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="开始日期"/></c:facet>
            <h:outputText value="#{list.startDate}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="结束日期"/></c:facet>
            <h:outputText value="#{list.endDate}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="招聘职位个数"/></c:facet>
            <h:outputText value="#{list.postCount}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="总需求人数"/></c:facet>
            <h:outputText value="#{list.needCount}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.planStatusDes}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="审批意见"/></c:facet>
            <h:outputText value="#{list.approveReason}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="创建人"/></c:facet>
            <h:outputText value="#{list.createID}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="创建人单位"/></c:facet>
            <h:outputText value="#{list.createOrg}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="创建时间"/></c:facet>
            <h:outputText value="#{list.createDate}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="浏览报名" onclick="return showSignPerson('#{list.planID}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="结束招聘"  styleClass="button01" action="#{innerRecuResultBB.jiesu}" rendered="#{list.planStatus=='3'}">
            	<x:updateActionListener property="#{innerRecuResultBB.planID}" value="#{list.planID}"/>
            </h:commandButton>
            <h:commandButton value="查看流程" onclick="return showWorkFlowLogByLinkID('#{list.planID}')" styleClass="button01" rendered="#{innerRecuResultBB.isWorkFlow=='1'}"></h:commandButton>
        </h:column>
    </x:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
