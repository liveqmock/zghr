<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO"%>
<%@ page import="com.hr319wg.sys.pojo.vo.RecordVO"%>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script language="javascript">
    function selectAdjustPerson(ctrlobj){
        showx = event.screenX - event.offsetX - 4 - 210 ;
        showy = event.screenY - event.offsetY + 18;
        retval = window.showModalDialog("/cont/SelectNoEndPerson.jsf", "", "dialogWidth:750px; dialogHeight:400px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:yes; directories:yes;scrollbars:yes;Resizable=yes; "  );
        if (retval != null) {
               form1.all("form1:str").value = retval;
               pageCodeExchange(document.forms(0));

        } else {
               return false;
        }
    }

    function checkSubmit(form1) {
            flag = true;
            var name = form1.all("form1:templateClassId").value;
            if (document.all('form1:generateDoc').checked){
                if (name == "" || name == null) {
                    alert("模板类别不能为空！");
                     flag = false;
                     return flag;
                }
                name = form1.all("form1:templateId").value;
                if (name == "" || name == null) {
                    alert("合同模板不能为空！");
                     flag = false;
                     return flag;
                }
            }
            name = form1.all("form1:contRemark").value;
            if (name != "" && name != null) {
                if (name.length>50) {
                    alert("劳动合同摘要容限制最多只能输入50个汉字！");
                    flag = false;
                    return flag;
                }
            }
            name = form1.all("form1:endReason").value;
            if (name == "" || name == null) {
                alert("解除原因不能为空！");
                 flag = false;
                 return flag;
            }
            return flag;
    }
    function queryPerson(){
        if(doAdvanceQuery('A','ORG','110','Y','cont_selPerObjs','1=1','Y','<%=Constants.DEFAULT_QUERY_CONTRACT%>','N','','2')){
             pageCodeExchange(document.forms(0));
             return true;
        }else{
             return false;
        }
    }
    function delPerson() {
      var field = form1.all('chk');
      if (checkMutilSelect(field)) {
          pageCodeExchange(document.forms(0));
      } else{
          alert("请选择人员！");
          return false;
      }
    }
    var flag=0 ;
    function showHide(obj){
        if(flag==0){
            obj.style.display="none";
            flag=1;
        }else{
            obj.style.display="";
            flag = 0;
        }
    }
    function confirmSave(form1){
            if (confirm('确定要做保存吗？')) {
                pageCodeExchange(form1);
                return true;
            } else {
                return false;
            }
    }
    function forView(form, id, type) {
        window.open("/cont/ContQueryHistory.jsf?displayFlag=false&personId=" + id ,"","left=50,top=50,height=400,width=800,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=yes")
    }
    function doQueryManyPerson(){
        var reval = window.showModalDialog("/common/ManyPersonCon.jsf", null, "dialogWidth:550px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
        if (reval != null && reval !="") {
            document.all('form1:ManyPerson').value = reval;
            pageCodeExchange(document.forms(0));
            disPlayProcessBar();
            return true;
        } else {
            return false;
        }
    }
</script>

<h:form id="form1">
    <h:panelGrid width="100%" border="0" styleClass="td_title" cellspacing="6" cellpadding="0" >
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="合同终止/解除维护" ></h:outputText>
        </h:panelGroup>
    </h:panelGrid>

<h:panelGrid  border="0"  align="center" columns="2" width="800">
    <%
        int  rowCount = 0;
        if(request.getSession().getAttribute("cont_selPerObjs")!=null){
           RecordVO[] recordVOs = ((TableVO)request.getSession().getAttribute("cont_selPerObjs")).getRowData();
           rowCount = recordVOs.length;
        }
    %>
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <c:verbatim escape="false"><a href="javascript:showHide(ryTable);"><b>  人员信息(共<%=rowCount%>条记录)</b></a></c:verbatim>
    </h:panelGrid>
    <h:panelGrid  border="0"  cellspacing="0" align="right" columns="5" >
        <h:panelGroup>
            <h:inputHidden id="ManyPerson" value="#{cont_contEndSignBB.nameStrs}"></h:inputHidden>
            <h:commandButton value="多人查询" id="queryPerson2" onclick="return doQueryManyPerson()" styleClass="button01"
                             action="#{cont_contEndSignBB.queryMultPerson}"/>
        </h:panelGroup>
        <h:inputHidden id="str" value="#{cont_contEndSignBB.selectNewPersonIds}"/>
        <h:commandButton id="dismiss" styleClass="button01"  value="调往系统内单位人员" action="#{cont_contEndSignBB.selectDismiss}" onclick="javascript:return selectAdjustPerson();"/>
        <h:commandButton id="advance1" styleClass="button01"  value="自定义查询" action="#{cont_contEndSignBB.selPerson}" onclick="return queryPerson();"/>
        <h:commandButton styleClass="button01" value="去除人员" action="#{cont_contEndSignBB.delPerson}" onclick="javascript:return delPerson();"/>
    </h:panelGrid>
</h:panelGrid>

<c:verbatim>
<table id="ryTable" width="850" border="0" align="center" height=180>
  <tr><td>
          <jsp:include page="/pages/common/activepage/ActiveList.jsp">
              <jsp:param name="target" value="cont_selPerObjs"/>
              <jsp:param name="hasOperSign" value="true"/>
              <jsp:param name="operSignType" value="checkbox"/>
              <jsp:param name="isPage" value="false"/>
          </jsp:include>
  </td></tr>
</table>
</c:verbatim>

<h:panelGrid  border="0"  cellpadding="0"  cellspacing="0"  align="center" columns="1" width="800">
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <h:outputText value="录入信息" styleClass="td05"/>
    </h:panelGrid>
</h:panelGrid>
<h:inputHidden id="contId" value="#{cont_contEndSignBB.bo.contId}"/>
<h:inputHidden id="contCode" value="#{cont_contEndSignBB.bo.contCode}"/>
<h:inputHidden id="personId" value="#{cont_contEndSignBB.bo.personId}"/>
<h:inputHidden id="personName" value="#{cont_contEndSignBB.bo.personName}"/>
<h:inputHidden id="attachmentId" value="#{cont_contEndSignBB.bo.attachmentId}"/>
<h:inputHidden id="createOrgId" value="#{cont_contEndSignBB.bo.createOrgId}"/>
<h:inputHidden id="isValid" value="#{cont_contEndSignBB.bo.isValid}"/>
<h:inputHidden id="contCreateDate" value="#{cont_contEndSignBB.bo.contCreateDate}"/>

<h:panelGrid width="800" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02">
         <h:outputText  styleClass="td_form_required" value="合同编号" />
         <h:outputText value=""/>
         <h:outputText   styleClass="td_form_required" value="模板类别" />
         <h:selectOneMenu value="#{cont_contEndSignBB.bo.templateClassId}" id="templateClassId" onchange="javascript:pageCodeExchange(document.forms(0));submit(); "  valueChangeListener="#{cont_contEndSignBB.templateClassChanged}">
                    <c:selectItems value="#{cont_contEndSignBB.item_templateClass}"/>
         </h:selectOneMenu>

         <h:outputText  styleClass="td_form_required" value="合同处理类别" />
         <h:selectOneMenu value="#{cont_contEndSignBB.bo.contClass}" id="contClass">
                    <c:selectItem itemValue="022006" itemLabel="合同终止" />
                    <c:selectItem itemValue="022007" itemLabel="合同解除" />
         </h:selectOneMenu>

         <h:outputText  styleClass="td_form_required" value="合同模板" />
         <h:panelGroup>
             <h:selectOneMenu value="#{cont_contEndSignBB.bo.templateId}" id="templateId" >
                     <c:selectItems value="#{cont_contEndSignBB.item_template}"/>
             </h:selectOneMenu>
             <h:selectBooleanCheckbox id="generateDoc" value="#{cont_contEndSignBB.generateDoc}"></h:selectBooleanCheckbox>
             <h:outputText value="生成合同文件"></h:outputText>
         </h:panelGroup>

         <h:outputText  styleClass="td_form_required" value="合同终止/解除时间" />
         <h:panelGroup>
             <h:inputText id="contEndSignDate" styleClass="input" size="10" value="#{cont_contEndSignBB.bo.contEndSignDate}" readonly="true" alt="合同终止/解除时间|0"/>
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:contEndSignDate')"> </c:verbatim>
         </h:panelGroup>
         <h:outputText value="竞业限制期限" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="jobLimitTerm" value="#{cont_contEndSignBB.bo.jobLimitTerm}" maxlength="10" alt="竞业限制期限|1|i" />
            <h:outputText value=" 月" />
         </h:panelGroup>

         <h:outputText  styleClass="td_form_required" value="经济补偿金额" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="repairMoney" value="#{cont_contEndSignBB.bo.repairMoney}" maxlength="10" alt="经济补偿金额|0|f" />
            <h:outputText value=" 元" />
         </h:panelGroup>

         <h:outputText  styleClass="td_form_required" value="合同违约金额" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="fellbackMoney" value="#{cont_contEndSignBB.bo.fellbackMoney}" maxlength="10" alt="合同违约金额|0|f" />
            <h:outputText value=" 元" />
         </h:panelGroup>

         <h:outputText  styleClass="td_form_required" value="医疗补助费" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="medicineMoney" value="#{cont_contEndSignBB.bo.medicineMoney}" maxlength="10" alt="医疗补助|0|f" />
            <h:outputText value=" 元" />
         </h:panelGroup>

         <h:outputText styleClass="td_form_required"  value="一次性补贴金额" />
         <h:panelGroup>
            <h:inputText styleClass="input" id="oneOffMoney" value="#{cont_contEndSignBB.bo.oneOffMoney}" maxlength="10" alt="一次性补贴金额|0|f" />
            <h:outputText value=" 元" />
         </h:panelGroup>

         <h:outputText styleClass="td_form_required"  value="其它费用" />
         <h:panelGroup>
         <h:inputText styleClass="input" id="otherMoney" value="#{cont_contEndSignBB.bo.otherMoney}" maxlength="10" alt="其它费用|0|f" />
         <h:outputText value=" 元" />
         </h:panelGroup>

         <h:outputText styleClass="td_form_required"  value="实际应付金额" />
         <h:panelGroup>
         <h:inputText styleClass="input" id="factPaymentMoney" value="#{cont_contEndSignBB.bo.factPaymentMoney}" maxlength="10" alt="实际应付金额|0|f" />
         <h:outputText value=" 元" />
         </h:panelGroup>

         <h:outputText value="劳动合同摘要" />
         <h:panelGroup>
             <h:inputTextarea id="contRemark" rows="4" cols="28"  value="#{cont_contEndSignBB.bo.contRemark}"/>
         </h:panelGroup>

         <h:outputText value="是否同意鉴证" />
         <h:panelGroup>
             <h:inputText value="#{cont_contEndSignBB.bo.agreeTestify}" id="agreeTestify" styleClass="input"  code="" dict="yes" dict_num="2023" readonly="true" />
             <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:agreeTestify')" class="button_select"></c:verbatim>
         </h:panelGroup>

        <h:outputText  styleClass="td_form_required" value="原因说明" />
        <h:panelGroup>
        <h:inputText styleClass="input" id="endReason" code="" dict="yes" dict_num="2230"
                    readonly="true" value="#{cont_contEndSignBB.bo.endReason}"                     />
        <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:endReason')" class="button_select"></c:verbatim>
       </h:panelGroup>

        <h:outputText  styleClass="td_form_required" value="去向" />
        <h:panelGroup>
        <h:inputText styleClass="input" id="endPlace" code="" dict="yes" dict_num="2231"
                    readonly="true" value="#{cont_contEndSignBB.bo.endPlace}"                     />
        <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:endPlace')" class="button_select"></c:verbatim>
       </h:panelGroup>

     </h:panelGrid>


     <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="center" columns="2">
            <h:commandButton styleClass="button01" value="保存" action="#{cont_contEndSignBB.save_add}"  onclick="if( checkSubmit(document.forms(0))&&checkAll(document.forms(0)) ){ return confirmSave(document.forms(0));}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" action="#{cont_contEndSignBB.forwardList}"/>
     </h:panelGrid>
</h:form>

<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>