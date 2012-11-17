<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{cont_contFollowSignBB}"/>

<script type="text/javascript" language="javascript">
    function checkModiCode(selected_ids){
        var form = document.forms[0];
        var field = form(selected_ids);
        var size = field.length;
        //debugger;
        var flag=0;
        if (size == null) {
            if (!field.checked) {
                alert("请选择要修改的项目!");
                return false;
            }
            else{
                if (document.all('form1:data_0:status').innerText=="审查通过"){
                    alert("已审批项目不能修改!");
                    return false;
                }
            }
        } else {
            for (var i = 0; i < size; i++) {
                if (field[i].checked) {
                    if (document.all('form1:data_'+i+':status').innerText=="审查通过"){
                        flag=2;
                        break;
                    }
                    else{
                       flag=3;
                    }
                }
            }
            if (flag==0) {
                alert("请选择要修改的项目!");
                return false;
            }
            if (flag==2){
                alert("已审批项目不能修改!");
                return false;
            }
        }
        return true;
    }

function valid(ctrlobj){
	if(!checkBatchDo('selected_ids')){  return false; }
    showx = 300 ;
	showy = 200;
	retval = window.showModalDialog("/pages/cont/SelectValidDate.jsf", "", "dialogWidth:350px; dialogHeight:230px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
    if (retval != null) {
           form1.all("form1:str").value = retval;

    } else {
           return false;
    }
}
//打包下载
function downloadBatch(form1){
	if(!checkBatchDo('selected_ids')){  return false; }
    var old_action = document.form1.action;
    window.open("","downloadBatch","left=400,top=300,height=100,width=200,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=yes");
    document.form1.target = 'downloadBatch';
    var temp_action = "/pages/cont/DownloadBatch.jsp";
    document.form1.action = temp_action;
    //document.form1.target = '_blank';
    form1.submit();
    document.form1.action = old_action;
    document.form1.target = '_self';
}
function checkSubmit() {
    var filename = form1.all("form1:excelFile").value;
    if (filename.substr(filename.length - 3).toLowerCase() != 'xls') {
        alert("请选择xls文件！");
        return false;
    } 
    x = document.body.clientWidth / 2 - 150;
	y = document.body.clientHeight / 2;
	document.all('processbar').style.top = y;
	document.all('processbar').style.left = x;
	document.all('processbar').style.display = "";
	return true;
}
</script>

<h:form id="form1" enctype="multipart/form-data">
    <h:inputHidden id="init_a" value="#{cont_contFollowSignBB.init_a}"/>
    <h:inputHidden id="str" value="#{cont_contFollowSignBB.validDate}"/>
    <h:panelGrid width="100%" border="0" styleClass="td_title" cellspacing="0" cellpadding="0" columns="2">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="合同续签"  ></h:outputText>
        </h:panelGroup>
        <h:panelGrid  border="0"  cellspacing="0" align="right" columns="2" >
            <h:outputText value="合同已到期共有：#{cont_contFollowSignBB.newCount}"></h:outputText>
            <h:commandButton styleClass="button01" value="合同已到期员工列表" action="contEnd_PersonList_jsf"/>
        </h:panelGrid>
    </h:panelGrid>

    <h:panelGrid  border="0"  align="center" columns="1" width="95%">
     <h:panelGrid  border="0"  cellspacing="0" align="left" columns="13" >
         <h:outputText value="姓名"/>
         <h:inputText styleClass="input" size="10" id="personNameQry" value="#{cont_contFollowSignBB.personNameQry}"/>
        <h:commandButton styleClass="button01" value=" 查询 " action="#{cont_contFollowSignBB.queryAll}"/>
        <h:panelGroup>
			<h:outputLink value="/pages/cont/import.xls" target="_new">
				<h:outputText value="下载模板  " />
			</h:outputLink>
            <x:inputFileUpload id="excelFile" styleClass="input" value="#{cont_contFollowSignBB.excelFile}" storage="file" size="10"/>
            <h:commandButton styleClass="button01" value="上传" action="#{cont_contFollowSignBB.uploadFile}"
                             onclick="return checkSubmit();"/>
        </h:panelGroup>
        <h:commandLink id="doQuery" action="#{cont_contFollowSignBB.queryAll}"></h:commandLink>
        <h:commandButton styleClass="button01" value="续签合同" action="#{cont_contFollowSignBB.forwardAdd}" />
         <h:commandButton styleClass="button01" value="报审" action="#{cont_contFollowSignBB.toApprove}" onclick="if(checkBatchDo('selected_ids')) { return true } else {return false;}"/>
         <h:commandButton styleClass="button01" value="撤销报审" action="#{cont_contFollowSignBB.toCancelApprove}" onclick="if(checkBatchDo('selected_ids')) { return doCancelApprove(); } else {return false;}"/>
        <h:commandButton styleClass="button01" value="批量修改" action="#{cont_contFollowSignBB.findByIds}" onclick="return checkBatchDo('selected_ids');"/>
        <h:commandButton styleClass="button01" value="合同编号维护" action="#{cont_contFollowSignBB.editMainContCode}" onclick="return checkModiCode('selected_ids');"/>
        <h:commandButton styleClass="button01" value=" 生效 " action="#{cont_contFollowSignBB.toValid}" onclick="javascript:return valid();"/>
        <h:commandButton styleClass="button01" value=" 删除 " action="#{cont_contFollowSignBB.deleteBatch}" onclick="return checkBatchDelete('selected_ids');" />
        <c:verbatim escape="false"><input type="button" class="button01"   name="cont_button" value="合同打印" onclick="javascript:downloadBatch(document.forms(0));" /> </c:verbatim>
     </h:panelGrid>

     <h:panelGrid align="right" styleClass="locked_top">
            <h:panelGroup>
                <h:outputText value="记录数:#{cont_contFollowSignBB.pagevo.totalRecord}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="页数:#{cont_contFollowSignBB.pagevo.totalPage}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="每页有#{cont_contFollowSignBB.pagevo.pageSize}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="当前为第#{cont_contFollowSignBB.pagevo.currentPage}页"></h:outputText>
                <h:commandButton value="首页" action="#{cont_contFollowSignBB.first}" styleClass="button01"></h:commandButton>
                <h:commandButton value="上页" action="#{cont_contFollowSignBB.pre}" styleClass="button01"></h:commandButton>
                <h:commandButton value="下页" action="#{cont_contFollowSignBB.next}" styleClass="button01"></h:commandButton>
                <h:commandButton value="尾页" action="#{cont_contFollowSignBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>

</h:panelGrid>

<x:dataTable value="#{cont_contFollowSignBB.bos}" var="list"  rowIndexVar="index"
                     headerClass="td_top"    id="data"  align="center"
                     rowClasses="td_middle" styleClass="table03" width="95%" border="1">
             <h:column>
                  <c:facet name="header">
                      <c:verbatim escape="false">
                      <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selected_ids)"/>
                      </c:verbatim>
                      </c:facet>
                  <c:verbatim escape="false"><input type="checkbox" name="selected_ids" value="</c:verbatim>
                  <h:outputText value="#{list.contId}"/>
                  <h:outputText value=","/>
                  <h:outputText value="#{list.personId}"/>
                  <h:outputText value=","/>
                  <h:outputText value="#{list.attachmentId}"/>
                  <c:verbatim>"></c:verbatim>
              </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="序号"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="合同编号"/></c:facet>
                <h:outputText value="#{list.contCode}"/>
            </h:column>

    <h:column>
        <c:facet name="header"><h:outputText value="员工编号"/></c:facet>
        <h:outputText value="#{list.contPersonBO.personCode}"/>
    </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="性别"/></c:facet>
                <h:outputText value="#{list.contPersonBO.personSex}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="身份证号码"/></c:facet>
                <h:outputText value="#{list.contPersonBO.idCard}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="用工类别"/></c:facet>
                <h:outputText value="#{list.contPersonBO.jobType}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="审查状态"/></c:facet>
                <h:outputText id="status" value="#{list.approveStatus}" title="审查单位：#{list.approveOrgId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="合同约定起始时间"/></c:facet>
                <h:outputText value="#{list.contStartDate}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="合同约定终止时间"/></c:facet>
                <h:outputText value="#{list.contEndDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <c:verbatim escape="false"><A  onclick="doShowCont('</c:verbatim><h:outputText value="#{list.attachmentId}"/><c:verbatim escape="false">')" taget="_blank" ></c:verbatim>
                <h:outputText value="合同查看" />
                <c:verbatim escape="false"></A></c:verbatim>
                <h:outputText value="  "/>
                <h:commandLink id="bnt2" value="修改" action="#{cont_contFollowSignBB.findById}">
                    <c:param name="contId" value="#{list.contId}"/>
                </h:commandLink>
                
            </h:column>
</x:dataTable>
</h:form>
<marquee id="processbar" style="position:absolute;display:none; border:1px solid #000000" direction="right" width="300"
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
<script type="text/javascript">
   setDataTableOver("form1:data");
</script>