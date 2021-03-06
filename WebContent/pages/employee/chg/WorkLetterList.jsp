<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function ModifyNo(id){
        var ret=window.showModalDialog("/employee/chg/ModifyLetterNo.jsf?letterType=worker&ID="+id, null, "dialogWidth:300px; dialogHeight:200px;center:center;resizable:no;status:no;");
        return false;
    }
    function openDetail(id){
        var ret=window.showModalDialog("/employee/chg/WorkLetterDetailList.jsf?LetterNO="+id, null, "dialogWidth:"+screen.width*0.85+"px; dialogHeight:"+screen.height*0.85+"px;center:center;resizable:no;status:no;");
        return false;
    }
    function doOpenWorkLetter() {
         var ret=window.showModalDialog("/employee/chg/OpenWorkLetter.jsf?Init=true", null, "dialogWidth:"+screen.width*0.85+"px; dialogHeight:"+screen.height*0.85+"px;center:center;resizable:no;status:no;");
         return true;
    }
    //id 介绍信编号
    function OpenRpt(id){
        if (document.all("form1:ReportID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }
        var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+id+"&Title=WL_"+id;
        window.open(url);
        return false;
    }
    function OpenRptOrFlow(id){
        if (document.all("form1:ReportID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }
        var url="/pages/report/RollORFlowReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+id+"&Title=WL_"+id;
        window.open(url);
        return false;
    }

    function OpenRptByControl(){
        if (document.all("form1:ReportID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }
        var url="/pages/report/ClientReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID=&ORGUID="+document.all("form1:unitId").value+"&Parameter="+document.all("form1:setId").value
                 +"&Title="+document.all("form1:setId").value+"_"+document.all("form1:dateId").value+"_"+document.all("form1:ReportID").value;
        window.open(url);
        return false;
    }
</script>
<x:saveState value="#{emp_letterBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{emp_letterBB.pageInit}"></h:inputHidden>

    <c:verbatim>
    <table width="98%" height=98% align="center" >
      <tr><td height=8>
        <table><tr>
            <td>
     </c:verbatim>
                <h:selectOneMenu id="ReportID" style="width:190px">
                    <c:selectItems value="#{emp_letterBB.workReport}"/>
                </h:selectOneMenu>
    <c:verbatim>
            </td>
            <td>
    </c:verbatim>
                <f:verbatim>
                    <%=LanguageSupport.getResource("COMM-1043", " 记录数")%>:
                </f:verbatim>
                <h:outputText value="#{emp_letterBB.pagevo.totalRecord}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                 <f:verbatim>
                    <%=LanguageSupport.getResource("COMM-1044", " 页数")%>:
                </f:verbatim>
                <h:outputText value="#{emp_letterBB.pagevo.totalPage}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                 <f:verbatim>
                    <%=LanguageSupport.getResource("COMM-1045", " 每页有")%>
                </f:verbatim>
                <h:outputText value="#{emp_letterBB.pagevo.pageSize}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                 <f:verbatim>
                    <%=LanguageSupport.getResource("RYGL-2217", "COMM-1046")%>
                </f:verbatim>
                <h:outputText value="#{emp_letterBB.pagevo.currentPage}"></h:outputText>
                <f:verbatim>
                    <%=LanguageSupport.getResource("COMM-1047", " 页")%>
                </f:verbatim>
<c:verbatim>
            </td>
            <td align="right">
</c:verbatim>
                    <h:commandButton value="首页" action="#{emp_letterBB.first}" styleClass="button01"></h:commandButton>
                    <h:commandButton value="上页" action="#{emp_letterBB.pre}" styleClass="button01"></h:commandButton>
                    <h:commandButton value="下页" action="#{emp_letterBB.next}" styleClass="button01"></h:commandButton>
                    <h:commandButton value="尾页" action="#{emp_letterBB.last}" styleClass="button01"></h:commandButton>
                    <h:outputText value="     "></h:outputText>
                    <h:commandButton value="新开工人调转介绍信"  styleClass="button01" onclick="doOpenWorkLetter();"></h:commandButton>
                    <h:commandButton value="退出" type="button" styleClass="button01" onclick="window.close();"></h:commandButton>
<c:verbatim>
            </td>
        </tr></table>
      </td></tr>

       <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id='datatable'>
</c:verbatim>
            <h:dataTable value="#{emp_letterBB.letterList}" var="list" width="100%"    id="dateList"
                    styleClass="table03" headerClass="td_fixtop" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center">
                <h:column >
                    <c:facet  name="header">
                    <f:verbatim>
                       <%=LanguageSupport.getResource("YXGL-1026", "操作")%>
                    </f:verbatim>
                    </c:facet>
                     <h:commandButton value="修改编号"  styleClass="button01" onclick="ModifyNo('#{list.letterNO}');"></h:commandButton>
                     <h:commandButton value="打印" type="button" styleClass="button01" onclick="OpenRptOrFlow('#{list.letterNO}');"></h:commandButton>
                     <h:commandButton styleClass="button01"  type="button" value="查看信息" onclick="openDetail('#{list.letterNO}')"></h:commandButton>
                </h:column>

                <h:column>
                    <f:facet name="header">
                     <f:verbatim>
                       <%=LanguageSupport.getResource("RYGL-2154", "编号")%>
                    </f:verbatim>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.letterNO}"/>
                </h:column>

                <h:column>
                    <f:facet name="header">
                    <f:verbatim>
                       <%=LanguageSupport.getResource("RYGL-2155", "调出单位")%>
                    </f:verbatim>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.outOrgDes}"/>
                </h:column>

                <h:column>
                    <f:facet name="header">
                   <f:verbatim>
                       <%=LanguageSupport.getResource("RYGL-2156", "调入单位")%>
                    </f:verbatim>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.inOrgDes}"/>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <f:verbatim>
                       <%=LanguageSupport.getResource("RYGL-2049", "人员姓名")%>
                    </f:verbatim>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.name}"/>
                </h:column>

                <h:column>
                    <f:facet name="header">
                          <f:verbatim>
                       <%=LanguageSupport.getResource("RYGL-2178", "人数")%>
                    </f:verbatim>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.personCount}"/>
                </h:column>

            </h:dataTable>
<c:verbatim>
        </div>
       </td></tr>
    </table>
</c:verbatim>
</h:form>

<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
