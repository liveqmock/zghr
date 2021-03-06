<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.sys.api.UserAPI"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>

<%@ include file="../include/taglib.jsp" %>
<%
    String hideSave = "Y";
    User user = (User) session.getAttribute(Constants.USER_INFO);
    UserAPI api = (UserAPI) SysContext.getBean("user_pmsAPI");
    String publicFlag=request.getParameter("publicFlag");
    if (publicFlag!=null){
        session.setAttribute("publicFlag",publicFlag);
    }
    else{
        publicFlag=(String)session.getAttribute("publicFlag");
    }
    if("PRIVATE".equals(publicFlag) ||
       (api.checkIsHQUser(user) && user.isSysOper() && "PUBLIC".equals(request.getParameter("publicFlag"))) ||
        "QALEAD".equals(request.getParameter("classId"))){
        hideSave="";
    }
    String operFlag=request.getParameter("operFlag");
    if  (operFlag==null){
        operFlag="1";
    }
    session.setAttribute("CONTRAL_SAVE",hideSave);
%>
<c:verbatim>
<base id="dbase" target="_parent">
</c:verbatim>
<script type="text/javascript">
    function forNew(){
        parent.location="/qry/QueryOrgSetting.jsf?operFlag=<%=operFlag%>&resetFlag=Y&classId=<%=CommonFuns.filterNull(request.getParameter("classId"))%>&qsType=<%=CommonFuns.filterNull(request.getParameter("qsType"))%>&setType=<%=CommonFuns.filterNull(request.getParameter("setType"))%>&unitType=<%=CommonFuns.filterNull(request.getParameter("unitType"))%>"
    }
    function forEdit(qryId){
        parent.location="/qry/QueryOrgSetting.jsf?operFlag=<%=operFlag%>&resetFlag=Y&classId=<%=CommonFuns.filterNull(request.getParameter("classId"))%>&qsType=<%=CommonFuns.filterNull(request.getParameter("qsType"))%>&setType=<%=CommonFuns.filterNull(request.getParameter("setType"))%>&qryId=" + qryId;
    }
    function forSetScope(){
       window.showModalDialog("/qry/QueryModuleSet.jsf", "", "dialogWidth:580px; dialogHeight:400px; status:0;resizable:no");
    }
    function forSetZJL(){
       window.showModalDialog("/qry/QueryZJLSet.jsf", "", "dialogWidth:580px; dialogHeight:400px; status:0;resizable:no");
    }
    function forSetJGJL(){
       window.showModalDialog("/qry/QueryJGJLSet.jsf", "", "dialogWidth:580px; dialogHeight:400px; status:0;resizable:no");
    }

    function forQuery(qryID){
        document.getElementById("qryID1").value = qryID;
        return true;
    }
    function fordel(qryID){
        if(confirm('确定要删除吗')){
        	document.getElementById("qryID").value=qryID;
            document.all("dbase").target="_self";
	        return true;
        }
        return false;
    }
</script>

<x:saveState value="#{qry_queryBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{qry_queryBB.pageInit}"/>
    <h:inputHidden id="classId" value="#{qry_queryBB.classId}"/>
<c:verbatim>
    <input type="hidden" name="hideSave" value="<%=hideSave%>">

    <table width="100%" height=98% border="0" cellpadding="0" cellspacing="0">
        <tr> <td align="right" height=8>
        </td></tr>
        <tr> <td align="right" height=8>
        <span>
</c:verbatim>
            <h:commandButton type="button" value=" 新建 " styleClass="button01" onclick="forNew()" rendered="#{qry_queryBB.hasQRight}"/>
            <h:commandButton value="设置总经理自助" styleClass="button01" onclick="forSetZJL()" type="button" rendered="#{qry_queryBB.classId=='QALEAD'}"/>
            <h:commandButton value="设置分支经理自助" styleClass="button01" onclick="forSetJGJL()" type="button" rendered="#{qry_queryBB.classId=='QALEAD'}"/>
<c:verbatim> 
        </span>
        <h:commandButton value="设置使用范围" styleClass="button01" onclick="forSetScope()" type="button" rendered="#{qry_queryBB.classId!='QALEAD' && qry_queryBB.classId!='QAPUBLIC'}"/>
       </td></tr>
        <tr><td height=8></td></tr>
        <tr><td>
            <div style='width:100%;height:100%;overflow:auto' id=datatable>
            <input type="hidden" id="qryID" name="ids"/>
</c:verbatim>
                 <h:dataTable var="list" value="#{qry_queryBB.queryBo}" headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center" styleClass="table03" width="95%" border="0" align="center" id="dateList">
                    <h:column>
                        <c:facet name="header"><h:outputText value="名称"/></c:facet>
                        <h:outputText value="#{list.name}"/>
                    </h:column>
                    <h:column>
                        <c:facet name="header"><h:outputText value="创建人"/></c:facet>
                        <h:outputText value="#{list.createUser}"/>
                    </h:column>
                    <h:column>
                        <c:facet name="header"><h:outputText value="创建时间"/></c:facet>
                        <h:outputText value="#{list.createDate}"/>
                    </h:column>
                    <h:column>
                        <c:facet name="header"><h:outputText value="操作"/></c:facet>
                        <h:commandButton id="doQuery" action="#{qry_querySettingBB.doQuery}" onclick="return forQuery('#{list.qryId}')" styleClass="button01" value="查询"/>
                        <h:outputText value="  "/>
                        <h:commandButton rendered="#{qry_queryBB.hasQRight}" onclick="return forEdit('#{list.qryId}');" styleClass="button01" type="button" value="修改" />
                        <h:commandButton rendered="#{qry_queryBB.hasQRight}" action="#{qry_querySettingBB.deleteQuery}" onclick="return fordel('#{list.qryId}');" styleClass="button01" value="删除"/>
                    </h:column>
                </h:dataTable>
<c:verbatim>
            </div>
        </td></tr>
    </table>

    <input type="hidden" name="qsType" value="<%=CommonFuns.filterNull(request.getParameter("qsType"))%>">
    <input type="hidden" name="setType" value="<%=CommonFuns.filterNull(request.getParameter("setType"))%>">
    <input type="hidden" name="classId" value="<%=CommonFuns.filterNull(request.getParameter("classId"))%>">
    <input type="hidden" name="flag" value="querylist">
    <input type="hidden" id="qryID1" name="qryId" value="">
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>