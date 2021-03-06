<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  
  <script type="text/javascript">
  	function forsave(){
  		var beginDate= document.all("form1:beginTime").value;
  		var applydays= document.all("form1:applyHours").value/8.0;//小时转为天(8小时对应一天)

        var date = new Date(); 
  		var d=date.getDate();
  		var m=date.getMonth()+1;
  		if(d<10){
  			d="0"+d;
  		}
  		if(m<10){
  			m="0"+m;
  		}
  		var str = date.getFullYear()+"-"+m+"-"+d;
  		if(beginDate==null || beginDate==""){
  			alert("请选择加班日期");
  			return false;
  		}else if(beginDate<str){
  			alert("根据考勤制度，只能申请当天及以后的。如果您需要补录，请联系人力资源处。");
  			return false;
  		}else if(applydays==null || applydays==""){
  			alert("加班时间不能为空");
  			return false;
  		}else if(isNaN(applydays) || applydays*8<4){
  			alert("根据考勤制度，小于4小时不能申请加班。");
  			return false;
  		}
  	//判断原因是否过长
		var reason = document.all("form1:reason").value;
		if (reason.length > 100) {
			alert("申请原因不能超过100字。");
			return false;
		}
  		//document.all("form1:applyHours").value=applydays;
  		
  		return true;
  	}
  </script>
  
  <x:saveState value="#{attOvertimeApplyBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{attOvertimeApplyBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 考勤管理 ->加班申请"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="center">
           <h:panelGrid columns="4" width="100%" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
             <h:outputText value="申请人"/>
             <h:outputText value="#{attOvertimeApplyBB.personName}"/>
		     <h:outputText value=""/>           
		     <h:outputText value=""/>           
             <h:outputText value="加班日期"/>
             <h:panelGroup>
             <h:inputText styleClass="input" id="beginTime" value="#{attOvertimeApplyBB.overtimeBo.beginTime}"
                             readonly="true" alt="加班日期|0|d|50||"/>
			<f:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:beginTime');"></f:verbatim>
			</h:panelGroup>
            <h:outputText value="加班时间/时"/>
            <h:inputText id="applyHours" value="#{attOvertimeApplyBB.overtimeBo.applyDays}" styleClass="input"/>
            </h:panelGrid>
		   <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
		     <h:outputText value="原因"/>
             <h:inputTextarea id="reason" cols="60" rows="5" value="#{attOvertimeApplyBB.overtimeBo.reason}"></h:inputTextarea>
		   </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="保存"  styleClass="button01" onclick="return forsave();" action="#{attOvertimeApplyBB.save}"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>