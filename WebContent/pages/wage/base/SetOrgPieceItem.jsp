<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
    <script language="javascript">
        function chkNull() {
            if (document.getElementById("form1:wageitem").value == "" || document.getElementById("form1:item").value == "") {
                alert("请选择相关项目！")
                return false;
            }
            else {
                pageCodeExchange(form1);
                return true
            }
        }
        function checkIds(persId) {
            if (checkMutilSelect(persId)) {
                if (confirm('确定要删除所选项目吗？'))
                {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert("请选择项目！")
                return false;
            }
        }
    </script>
<x:saveState value="#{wage_wageItemSetBB}"/>
<h:form id="form1">
<h:inputHidden value="#{wage_wageItemSetBB.pageInit}"/>
<f:verbatim><br>
    <table height=96% width=98% align="center" cellpadding="0" cellspacing="0">
    <tr height=8>
                <td align="center" width="16%" class=tab>&nbsp;<a href="SetWageItem.jsf?act=1">薪资项目－成本代码</a></td>
                <td align="center" width="16%" class=tab>&nbsp;<a href="SetDeptItem.jsf?act=2">薪资项目－机构人力成本</a></td>
                <td align="center" width="16%" class=tab>&nbsp;<a href="SetPersonItem.jsf?act=3">薪资项目－员工人力成本</a></td>
                <td align="center" width="16%" class=tab>&nbsp;<a href="SetOrgSumItem.jsf?act=4">机构汇总设置</a></td>
                <td align="center" width="16%" class=tab>&nbsp;<a href="SetPieceItem.jsf?act=6">个人计量汇总</a></td>
                <td align="center" width="16%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="SetOrgPieceItem.jsf?act=7">部门计量汇总</a></td>
     </tr>
    <tr><td colspan="6" valign="top">
    <div class="tabbody" id=datatable>
      </f:verbatim>
    <h:panelGrid width="95%" align="center"  border="0"   columns="2">
        <h:panelGroup>
            <h:selectBooleanCheckbox id="orderByName" value="#{wage_wageItemSetBB.orderByName}" onclick="submit();"  valueChangeListener="#{wage_wageItemSetBB.outputByName}" ></h:selectBooleanCheckbox>
            <h:outputText value="按项目名称排序"></h:outputText>
        </h:panelGroup>

        <h:panelGroup>
            <h:outputText value="明细项目："/>
            <h:selectOneMenu style="width:150;" id="wageitem" value="#{wage_wageItemSetBB.costFieldBo.costType}">
                <f:selectItems value="#{wage_wageItemSetBB.pieceItemList}"/>
            </h:selectOneMenu>
            <h:outputText value="汇总项目 "/>
            <h:selectOneMenu style="width:150;" id="item" value="#{wage_wageItemSetBB.costFieldBo.costField}">
                <f:selectItems value="#{wage_wageItemSetBB.pieceOrgSumList}"/>
            </h:selectOneMenu>
            <h:commandButton id="set" styleClass="button01" value="设置"
                             onclick="if(chkNull())return true;else return false;"
                             action="#{wage_wageItemSetBB.addOrgPieceItem}"/>
            <h:commandButton value=" 删除 " styleClass="button01"
                             onclick="if(checkIds(document.form1.Id)){pageCodeExchange(form1);return true;}else return false;"
                             action="#{wage_wageItemSetBB.deleteItem}">
                <x:updateActionListener property="#{wage_wageItemSetBB.flag}" value="2"/>
            </h:commandButton>
            </h:panelGroup>
    </h:panelGrid>

    <h:dataTable align="center" width="95%"  value="#{wage_wageItemSetBB.pieceSet}" var="list"    id="dateList"
                 headerClass="tr_fixrow td_top" columnClasses="td_middle_center,td_middle,td_middle"
                 styleClass="table03">
        <h:column>
            <f:facet name="header"><f:verbatim escape="false"><input type="checkbox" name="chkAll"
                                                                     onclick="selectAll(document.form1.chkAll,document.form1.Id)"/></f:verbatim>
            </f:facet>
            <f:verbatim escape="false"><div align=center><input type="checkbox" name="Id"
                value="</f:verbatim>
            <h:outputText value="#{list.costFieldId}"/><f:verbatim>"></div></f:verbatim>
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="计量明细(A002)"/></f:facet>
            <h:outputText value="#{list.costName}"/>
        </h:column>

        <h:column>
            <f:facet name="header"><h:outputText value="计量汇总(B734)"/></f:facet>
            <h:outputText value="#{list.fieldName}"/>
        </h:column>
    </h:dataTable>

      <f:verbatim>
  </div>
  </td></tr>

    </table>
</f:verbatim>


</h:form>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
    setDataTableOver("form1:dateList");    
</script>
