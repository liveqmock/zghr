<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	String num = request.getParameter("num");
	String[] array = (String[]) request.getSession().getAttribute(
			"array" + num);
%>
<script type="text/javascript">
        function doChange(){
			var score = document.getElementsByTagName("input");
			var str="";
			for(var i=0;i<score.length;i++){
				if(score[i].type=="text"){
					if(score[i].value==null||score[i].value==""){
						score[i].value='';
					}
					if(score[i].value!=0){
					str += score[i].value + ":";
					}
			    }
			}
			
			var content = document.getElementsByTagName("textarea")[0].value;
			var another = document.getElementsByTagName("textarea")[1].value;
			if(content==null){
				content='';
			}
			if(another==null){
				another='';
				}
			var con = "";
			con += content +":"+ another+":";
			str=con+str;
			str = str.replace(/%/g,"");//将页面上的%替换为空，保证页面中不会出现多个%，因为向数据库中添加数据时后台会自动添加%
			var splitStr = str.split(":");
			if(splitStr[0]==""||splitStr[1]==""||splitStr[2]==""||splitStr[3]==""){
				alert("请保证数据的完整!");
				return false;
			}
			document.all('form1:doChange').value=str;
		    return true;
        }
    </script>
<x:saveState value="#{eva_showSelfJobDetailBB}" />
<h:form id="form1">
	<h:inputHidden value="#{eva_showSelfJobDetailBB.initChange}"></h:inputHidden>

	<h:panelGrid columns="4" width="100%"
		columnClasses="td_form01,td_form02,td_form01,td_form02" align="center"
		styleClass="table03">
		<h:outputText value="履行责任"></h:outputText>
		<h:panelGroup>
			<c:verbatim>
				<%
					out.print("<input value='" + array[1] + "' class='input' type='text'");
				%>
			</c:verbatim>
		</h:panelGroup>
		<h:outputText value="时间比重"></h:outputText>
		<h:panelGroup>
			<c:verbatim>
				<%
					out.print("<input value='" + array[3] + "' class='input' type='text'");
				%>
			</c:verbatim>
		</h:panelGroup>
		</h:panelGrid>
		
		<h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
		<h:outputText value="工作任务"></h:outputText>
		<h:panelGroup>
			<c:verbatim>
				<%
				out.print("<textarea name='data' cols='70'>");
				out.print(array[2]);
				out.print("</textarea>");
				%>
			</c:verbatim>
		</h:panelGroup>
		</h:panelGrid>
		
		<h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
		<h:outputText value="考核要点"></h:outputText>
		<h:panelGroup>
			<c:verbatim>
				<%
				out.print("<textarea name='data' cols='70'>");
				out.print(array[4]);
				out.print("</textarea>");
				%>
			</c:verbatim>
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid align="right" styleClass="table03">
		<h:inputHidden id="doChange" value="#{eva_showSelfJobDetailBB.doChange}"></h:inputHidden>
				    <h:commandButton styleClass="button01" value="保存" onclick="return doChange();" action="#{eva_showSelfJobDetailBB.change}">
				    </h:commandButton>
	</h:panelGrid>
</h:form>