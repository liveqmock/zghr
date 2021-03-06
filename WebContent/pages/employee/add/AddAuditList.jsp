<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<script type="text/javascript">
    function audit(id){
        window.showModalDialog("/employee/add/AddAuditEdit.jsf?OperID="+document.all('form1:operid').value+"&itemID="+id, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
    }
    function OpenRpt(itemID,personID){
        if (document.all("form1:ReportID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }
        var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+personID+"&ORGUID=&Parameter="+itemID+"&Title=";
        window.open(url);
       return false;
   }
    
</script>
<x:saveState value="#{emp_personAddAuditBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{emp_personAddAuditBB.pageInit}"/>
    <h:inputHidden id="operid" value="#{emp_personAddAuditBB.operid}"/>
    <f:verbatim>
    <table height=96% width=100%>
     <tr><td height=8 class=td_title>
    </f:verbatim>
                   <h:graphicImage value="/images/tips.gif" />
                   <h:outputText value="#{emp_personAddAuditBB.opername}"/>
     <f:verbatim>
         </td>
      </tr>

         <tr><td height=8 align="right">
        </f:verbatim>
            <h:selectOneMenu id="ReportID" style="width:190px">
                <c:selectItems value="#{emp_personAddAuditBB.regTableList}"/>
            </h:selectOneMenu>
         <f:verbatim>
             </td>
          </tr>

     <tr><td align="top">
          <div style='width:100%;height:100%;overflow:auto' id=datatable>
  </f:verbatim>
          <h:dataTable value="#{emp_personAddAuditBB.auditList}" var="list" align="center"  id="dateList"
                       headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                       styleClass="table03" width="95%" >
              <h:column>
                  <c:facet name="header"><h:outputText value="申请时间"/></c:facet>
                  <h:outputText value="#{list.applyDate}"/>
              </h:column>
              <h:column>
                  <c:facet name="header"><h:outputText value="入职单位"/></c:facet>
                  <h:outputText value="#{list.orgName}"/>
              </h:column>

              <h:column>
                  <c:facet name="header"><h:outputText value="入职部门"/></c:facet>
                  <h:outputText value="#{list.deptName}"/>
              </h:column>
              <h:column>
                  <c:facet name="header"><h:outputText value="入职岗位"/></c:facet>
                  <h:outputText value="#{list.postName}"/>
              </h:column>
              <h:column>
                  <c:facet name="header"><h:outputText value="人员姓名"/></c:facet>
                  <h:outputText value="#{list.personName}"/>
              </h:column>

              <h:column>
                  <c:facet name="header"><h:outputText value="操作"/></c:facet>
                  <h:commandButton styleClass="button01" value="查看流程" type="button" onclick="return showWorkFlowLogByLinkID('#{list.itemID}')"></h:commandButton>
                  <h:commandButton styleClass="button01" value="审批" rendered="#{(list.audit1Result=='0' && emp_personAddAuditBB.operid=='0333') || (list.audit2Result=='0' && emp_personAddAuditBB.operid=='0334') ||(list.audit3Result=='0' && emp_personAddAuditBB.operid=='0335') || (list.audit4Result=='0' && emp_personAddAuditBB.operid=='0337') || (list.audit5Result=='0' && emp_personAddAuditBB.operid=='0338') || (list.audit6Result=='0' && emp_personAddAuditBB.operid=='0339')}" onclick="return audit('#{list.itemID}')"></h:commandButton>
                  <h:commandButton styleClass="button01" type="button" value="显示表格" onclick="OpenRpt('#{list.itemID}','#{list.personID}');"></h:commandButton>
              </h:column>

      </h:dataTable>
  <f:verbatim>
      </div>

       </td></tr>
       </table>

    </f:verbatim>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
