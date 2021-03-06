<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
	function forSel() {
		PopUpMutilCodeDlgNoLayerForSubmit('form1:personType',
				'form1:personTypeValue', "0135", '');
		var type = document.all("form1:personType").value;
		if (type == null || type == "") {
			return false;
		}
		return true;
	}
	function process() {
		x = document.body.clientWidth / 2 - 150;
		y = document.body.clientHeight / 2;
		document.all('processbar').style.top = y;
		document.all('processbar').style.left = x;
		document.all('processbar').style.display = "";
	}
	function modify(id) {
        window.showModalDialog("/custom/attence/attCalcResultMasterEdit.jsf?subID="+id, null, "dialogWidth:400px;dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
	function showAttDetail(personId,yearMonth){
		window.showModalDialog("/custom/attence/attDetailForSomeBody.jsf?personId="+personId+"&yearMonth="+yearMonth, null, "dialogWidth:400px;dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
	}
	</script>
<x:saveState value="#{attCalcMgrBB}" />
<h:inputHidden value="#{attCalcMgrBB.pageInit}" />
<h:form id="form1">
	<h:inputHidden id="personType" value="#{attCalcMgrBB.personType}" />
	<h:inputHidden id="personTypeValue"
		value="#{attCalcMgrBB.personTypeValue}" />	
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGroup>
			<h:commandButton styleClass="button01" value="计算"
				onclick="process();" action="#{attCalcMgrBB.calc}" />
			<h:outputText value="  " />
			<h:outputText value=" 员工编号或姓名:" />
			<h:inputText value="#{attCalcMgrBB.nameStr}" styleClass="input"
				size="20" />			

			<h:commandButton styleClass="button01" value="人员类别"
				onclick="return forSel();" action="#{attCalcMgrBB.doQuery}" />
			<h:commandButton styleClass="button01" value="查询"
				action="#{attCalcMgrBB.doQuery}" />
			<h:outputText value="  " />
			<h:outputText value="记录数:#{attCalcMgrBB.mypage.totalRecord}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="页数:#{attCalcMgrBB.mypage.totalPage}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="每页有#{attCalcMgrBB.mypage.pageSize}"></h:outputText>
			<h:outputText value="  "></h:outputText>
			<h:outputText value="当前为第#{attCalcMgrBB.mypage.currentPage}页"></h:outputText>

			<h:commandButton value="首页" action="#{attCalcMgrBB.first}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="上页" action="#{attCalcMgrBB.pre}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="下页" action="#{attCalcMgrBB.next}"
				styleClass="button01"></h:commandButton>
			<h:commandButton value="尾页" action="#{attCalcMgrBB.last}"
				styleClass="button01"></h:commandButton>
		</h:panelGroup>
		<h:panelGrid columns="1" width="100%" align="left">
			<x:dataTable value="#{attCalcMgrBB.list}" headerClass="td_top"
				rowIndexVar="index" var="list" styleClass="table03" border="1"
				width="98%"
				columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center">
				<h:column>
					<f:facet name="header">
						<h:outputText value="序号" />
					</f:facet>
					<h:outputText value="#{index+1}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="员工编号" />
					</f:facet>
					<h:outputText value="#{list.personCode}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="姓名" />
					</f:facet>
					<h:outputText value="#{list.personName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="人员类别" />
					</f:facet>
					<h:outputText value="#{list.personType}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="所在部门" />
					</f:facet>
					<h:outputText value="#{list.deptName}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="事假扣款" />
					</f:facet>
					<h:outputText value="#{list.normalLeaveDeduction}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="病假扣款" />
					</f:facet>
					<h:outputText value="#{list.illLeaveDeduction}"></h:outputText>
				</h:column>
				
				<h:column>
					<f:facet name="header">
						<h:outputText value="迟到扣款" />
					</f:facet>
					<h:outputText value="#{list.laterDeduction}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="旷工扣款" />
					</f:facet>
					<h:outputText value="#{list.awayDeduction}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="产假扣款" />
					</f:facet>
					<h:outputText value="#{list.chanjiaLeaveDeduction}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="难产产假扣款" />
					</f:facet>
					<h:outputText value="#{list.nanchanjiaLeaveDeduction}"></h:outputText>
				</h:column>					
				<h:column>
					<f:facet name="header">
						<h:outputText value="迟到" />
					</f:facet>
					<h:outputText value="#{list.lateTime}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="旷工" />
					</f:facet>
					<h:outputText value="#{list.awayTime}" rendered="#{list.awayTime!='.5' }"></h:outputText>
					<h:outputText value="0.5" rendered="#{list.awayTime=='.5' }"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="事假" />
					</f:facet>
					<h:outputText value="#{list.leaveReasons}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="病假" />
					</f:facet>
					<h:outputText value="#{list.leaveSick}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="产假" />
					</f:facet>
					<h:outputText value="#{list.leaveMaternity}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="难产产假" />
					</f:facet>
					<h:outputText value="#{list.nanchanjiaLeave}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="婚假" />
					</f:facet>
					<h:outputText value="#{list.leaveWedding}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="丧假" />
					</f:facet>
					<h:outputText value="#{list.leaveArrangingFuneral}"></h:outputText>
				</h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="操作" />
					</f:facet>
					<h:commandButton value="修改" onclick="modify('#{list.subID}');" styleClass="button01" rendered="#{attCalcMgrBB.isView!='1'}" />
				    <h:commandButton value="查看详情" styleClass="button01" onclick="showAttDetail('#{list.personId }','#{list.attenceDate }')" />
				</h:column>
			</x:dataTable>
		</h:panelGrid>
	</h:panelGrid>
</h:form>
<marquee id="processbar"
	style="position: absolute; display: none; border: 1px solid #000000"
	direction="right" width="300" scrollamount="5" scrolldelay="10"
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
