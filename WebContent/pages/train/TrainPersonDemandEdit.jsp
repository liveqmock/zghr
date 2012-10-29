<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<c:verbatim>
    <link href="/css/editor.css" rel="stylesheet" type="text/css"/>
    <script language="javascript" src="/js/commonFuns.js"></script>
    <script language="javascript" src="/js/editor.js"></script>
    <script language="javascript" src="/js/editor_toolbar.js"></script>
</c:verbatim>

<script type="text/javascript">
    function AddAttech() {
        if (document.all('form1:title').value==null){
            alert("请输入标题");
            return false;
        }
        if (document.all('form1:excelFile').value==null){
            alert("请选择文件");
            return false;
        }
        return true;
     }

    function forCheck() {
        
        if (document.all('form1:personName').value==null || document.all('form1:personName').value=="") {
            alert("请选择人员!");
            return false;
        }
        if (document.all('form1:trainstyle').value==null || document.all('form1:trainstyle').value=="") {
            alert("请选择培训形式!");
            return false;
        }
      
        
       
        return true;
    }
    function forSave() {
        PutTextareaValue(document.all('form1:textarea'),fGetContent());
        if (forCheck()) {
            return forsubmit(document.all('form1'));
        }
        return false;
    }
</script>
    <x:saveState value="#{train_personDemandEditbb}"/>
	<h:form id="form1" >
	  <h:inputHidden value="#{train_personDemandEditbb.initEdit}" />
      <h:inputHidden id="superID" value="#{train_personDemandEditbb.superId}" />
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1">
           <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value="培训管理>>个人培训需求"/>
           </h:panelGroup>
       </h:panelGrid>

        <f:verbatim>
            <br>
        </f:verbatim>
  <c:verbatim>
        <table border="0"  align="center" cellspacing="2"    cellpadding="10"	columnClasses="td_form01,td_form02" styleClass="table03">
		    <tr>
                <td class="td_form01">培训类型</td>
                <td class="td_form02">
</c:verbatim>
                  <h:inputText id="text1" readonly="true" styleClass="input" value="个人需求" size="80" maxlength="50" />
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_form01">关联公告</td>
                <td class="td_form02">
</c:verbatim>
                 <h:selectOneMenu value="#{train_personDemandEditbb.bo.bullId}">
				<c:selectItems value="#{train_personDemandEditbb.bullList}"/>
			</h:selectOneMenu>
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_form01">提出需求人员</td>
                <td class="td_form02">
</c:verbatim>
                  <h:inputHidden id="personId" value="#{train_personDemandEditbb.bo.personID}"></h:inputHidden>
                  <h:inputText readonly="true" id="personName" styleClass="input" value="#{train_personDemandEditbb.bo.personName}" size="65" maxlength="50"/>
              <h:commandButton value="选择人员" styleClass="button01"  onclick="fPopUpPerDlg('form1:personName', 'form1:personId',document.all('form1:superID').value,'2')"></h:commandButton>
<c:verbatim>
                </td>
            </tr>
            
           
            <tr>
                <td class="td_form01">培训形式</td>
                <td class="td_form02">
</c:verbatim>
                 <h:selectOneMenu id="trainstyle" value="#{train_personDemandEditbb.bo.demandStyle}" style="width:30%">
                   <c:selectItem itemLabel="------请选择------" itemValue=""/>
                   <c:selectItem itemLabel="课堂讲授" itemValue="0"/>
                   <c:selectItem itemLabel="进学校深造" itemValue="1"/>
                   <c:selectItem itemLabel="看录像或电影" itemValue="2"/>
                   <c:selectItem itemLabel="现场演练" itemValue="3"/>
                   <c:selectItem itemLabel="案例分析" itemValue="4"/>
                   <c:selectItem itemLabel="其他" itemValue="5"/>
                 </h:selectOneMenu>
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_form01">培训时间</td>
                <td class="td_form02">
</c:verbatim>
                 <h:selectOneRadio  value="#{train_personDemandEditbb.bo.demandTime}">
                        <f:selectItem itemValue="0" itemLabel="工作时间上午" />
                        <f:selectItem itemValue="1" value="true" itemLabel="工作时间下午" />
                        <f:selectItem itemValue="2" value="true" itemLabel="工作时间晚上" />
                        <f:selectItem itemValue="3" value="true" itemLabel="周末" />
                    </h:selectOneRadio>
<c:verbatim>
                </td>
            </tr>
            <tr>
            <td class="td_form01">提出时间</td>
			<td class="td_form02">
</c:verbatim>
				<h:inputText id="text5" styleClass="input" value="#{train_personDemandEditbb.bo.createDate}" size="19" readonly="true">
				</h:inputText>
			
<c:verbatim>
			</td>
            </tr>
            

           <tr >
               <td class="td_form01">说明</td>
               <td class="td_form02">
 </c:verbatim>
                    <h:inputTextarea id="textarea" rows="15" cols="80" style="display:none;"  value="#{train_personDemandEditbb.bo.memo}" />
<c:verbatim>
                    <script language="javascript">
                        gFrame = 1;//1-在框架中使用编辑器
                        gContentId = "form1:textarea";//要载入内容的content ID
                        OutputEditorLoading();
                    </script>
                    <iframe id="HtmlEditor" class="editor_frame" frameborder="0" marginheight="0" marginwidth="0" style="width:100%;height:300px;overflow:visible;" ></iframe>
               </td>
            </tr>

           
</c:verbatim>
				
                
<c:verbatim>
               
        </table>
			<br>
</c:verbatim>

        <h:panelGrid border="0" columns="2" cellpadding="8" align="center">
			<h:commandButton value="保存" onclick="return forSave();" action="#{train_personDemandEditbb.save}" styleClass="button01" />
			<h:commandButton value="返回" action="sys_newslist" styleClass="button01" />
		</h:panelGrid>
	</h:form>


