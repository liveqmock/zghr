<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
 
    <script language="javascript" src="<%=request.getContextPath()%>/js/selectItem.js"></script>
    <script type="text/javascript">
    // 移出所有项目
    function removeAll(){
        var obj = form1.rsItem;
        var count = obj.options.length;
        for (i = count - 1; i >= 0; i--) {
             obj.remove(i);
        }
    }

    function forselect(){
        removeAll();
        var fl=document.all("form1:importconfig").value.split("|");
        document.all("form1:configID").value=fl[0];
        for(var i=1;i<fl.length;i++){
            var va=fl[i].split(",");
            addOptionItem(form1.all('rsItem'), va[0], va[1]);
            if (i==1){
                if (va[0]!="A001735"){
                    document.all("form1:useold").checked=true;
                }
                else {
                    document.all("form1:useold").checked=false;
                }
            }
        }
        document.all("form1:configname").value=document.all("form1:importconfig").options(document.all("form1:importconfig").selectedIndex).text;

    }

    function checkSave() {
        if (document.all("form1:configname").value==""){
            alert("请录入配置名称！")
            return false;
        }
        var obj = form1.rsItem;
        if (obj.options.length < 3) {
            alert("请选择输入项！")
            return false;
        } else {
            selectTotal(obj);
            obj.options[0].selected = false;
            obj.options[1].selected = false;
            return true;
        }
    }
    function checkDelete(){
        if (document.all("form1:configname").value==""){
            alert("请录入配置名称！")
            return false;
        }
        return true;
    }

        function checkSubmit() {
            if (document.all("form1:date")!=null && document.all("form1:date").value==""){
                alert("请选择业务时间");
                return false;
            }
            
            var filename = form1.all("form1:excelFile").value;
            var obj = form1.rsItem;
            if (filename.substr(filename.length - 3) == 'csv') {
                if (obj.options.length < 3) {
                    alert("请选择输入项！")
                    return false;
                } else {
                    selectTotal(obj);
                    obj.options[0].selected = false;
                    obj.options[1].selected = false;
                    return true;
                }
            } else {
                alert("请选择CSV文件！");
                return false;
            }
        }
        function removeInputItem() {
            var obj = form1.rsItem;
            var count = obj.options.length;
            for (i = count - 1; i >= 0; i--) {
                if (obj.options[i].selected) {
                    if (obj.options[i].value == "A001735" || obj.options[i].value == "A001001" ) {
                        obj.options[i].selected = false;
                    } else {
                        obj.remove(i);
                    }
                }
            }
        }
        function forUpInputItem() {
            var obj = form1.rsItem;
            var count = obj.options.length;
            for (i = 0; i < count; i++) {
                if (obj.options[i].selected) {
                    if (i == 0 || i == 1 ||i==2) {
                        continue;
                    }
                    var op1 = document.createElement("Option");
                    if (i - 1 > 1) {
                        op1.value = obj.options[i].value;
                        op1.text = obj.options[i].text;
                        obj.add(op1, i - 1);
                        obj.remove(i + 1);
                        obj.options[i - 1].selected = true;
                    }
                }
            }
        }
        function forDownInputItem() {
            var obj = form1.rsItem;
            var count = obj.options.length;
            for (i = 0; i < count; i++) {
                if (obj.options[i].selected) {
                    if (i == count - 1 || i == 0 || i == 1) {
                        continue;
                    }
                    var op1 = document.createElement("Option");
                    op1.value = obj.options[i].value;
                    op1.text = obj.options[i].text;
                    obj.add(op1, i + 2);
                    obj.remove(i);
                    obj.options[i + 1].selected = true;
                }
            }
            return;
        }
        function doSetUseOld(){
            if (document.all("form1:useold").checked){
                form1.all('rsItem').options[0].value=document.all('form1:secondKey').value;
                form1.all('rsItem').options[0].text=document.all('form1:secondKeyName').value;
            }
            else {
                form1.all('rsItem').options[0].value="A001735";
                form1.all('rsItem').options[0].text="人员编号";
            }
        }
    </script>

<x:saveState value="#{emp_DataUploadBB}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:inputHidden value="#{emp_DataUploadBB.initBySet}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
          
        <h:outputText value=" 导入数据"/>
        </h:panelGroup>
    </h:panelGrid>
     <c:verbatim><br></c:verbatim>
    <h:panelGrid width="95%" columns="1" align="center" styleClass="table03" columnClasses="td_form01">
        <c:verbatim escape="false">
           <font color=red> <%=LanguageSupport.getResource("RYGL-1006","文件格式说明")%>： </font><br>
           <%=LanguageSupport.getResource("RYGL-2240","1. 导入文件的格式为CSV文件(Excel打开,选csv格式另存为即可)")%> <br>
           <%=LanguageSupport.getResource("RYGL-1008"," 2. 选择的指标集和需要的导入的数据指标集一致，且按文件中各项的顺序选择数据项")%> <br>
           <%=LanguageSupport.getResource("RYGL-2241"," 3. 电子表格的第一行为标题行，数据从第二行开始，电子表格的前两列固定为：人员编号、姓名.人员编号不能为空值")%><br>
           <%=LanguageSupport.getResource("RYGL-1010"," 4. 电子表格的所有列的数据格式设置为文本格式")%> <br>
           <%=LanguageSupport.getResource("RYGL-1011","  6. 如果是代码项，那么必须是代码值而不是代码名称。")%> <br>
           <%=LanguageSupport.getResource("RYGL-1012", "7. 如果是6位日期类型数据，数据格式为6位数字，如'200609',如果是8位日期类型数据，数据格式为8位数字，如'20060918'。")%> <br>
         </c:verbatim>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid width="95%" columns="1" align="center" styleClass="table03"
                 columnClasses="td_form01,td_form01,td_form01">
        <h:panelGroup>
             <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-A002","选择需要上传的指标集")%> 
           </f:verbatim>
            <h:selectOneMenu id="mType" onchange="submit()" value="#{emp_DataUploadBB.perSelSet}"
                             valueChangeListener="#{emp_DataUploadBB.selChanged}">
                <c:selectItems value="#{emp_DataUploadBB.perSetList}"/>
            </h:selectOneMenu>
              <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-2246","业务时间")%> 
           </f:verbatim>
            <h:inputText readonly="true" id="date" value="#{emp_DataUploadBB.date}"></h:inputText>
            <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:date')"></f:verbatim>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="4" align="center" width="95%"
                  styleClass="table03" columnClasses="td_middle,td_middle,td_middle,td_middle">
         <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-A004","备选输入项")%> 
           </f:verbatim>
        <h:outputText value=" "/>

        <h:panelGroup>
            <h:selectBooleanCheckbox id="useold" value="false"  onclick="doSetUseOld()" />
            <h:inputHidden id="secondKey" value="#{emp_DataUploadBB.secondKey}"></h:inputHidden>
            <h:inputHidden id="secondKeyName" value="#{emp_DataUploadBB.secondKeyName}"></h:inputHidden>
              <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-2247","使用")%> 
           </f:verbatim>
            <h:outputText value="#{emp_DataUploadBB.secondKeyName}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:selectOneMenu id="importconfig" onchange="forselect();">
                 <f:selectItems value="#{emp_DataUploadBB.selitem}"/>
             </h:selectOneMenu>
        </h:panelGroup>
        <h:outputText value=" "/>

        <h:selectManyListbox size="15" style="width:250px" id="preTreat">
            <c:selectItems value="#{emp_DataUploadBB.perSetItemList}"/>
        </h:selectManyListbox>

        <h:panelGroup>
            <c:verbatim escape="false">
                <input name=rightBnt type=button class="button01"
                       onclick="forAddItem(form1.all('rsItem'),form1.all('form1:preTreat'))" value=">>">
                <br>
                <br>
                <INPUT name=leftBnt type=button class="button01" onclick="removeInputItem()" value="<<">
            </c:verbatim>
        </h:panelGroup>

        <h:panelGroup>
            <c:verbatim>
            <select size="15" style="width:250px" name="rsItem" multiple="true">
                <option value="A001735"><%=LanguageSupport.getResource("RYGL-2122","人员编号")%> </option>
                <option value="A001001"><%=LanguageSupport.getResource("RYGL-1016","姓名")%></option>
            </select>
            <br>
        </c:verbatim>
            <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-2248","配置名称")%>
            </f:verbatim>
            <h:inputText  id="configname" value="#{emp_DataUploadBB.configname}"/>
            <h:inputHidden  id="configID" value="#{emp_DataUploadBB.configID}"/>
            <h:commandButton value="保存" styleClass="button01" onclick="return checkSave();" action="#{emp_DataUploadBB.saveconfig}"/>
            <h:commandButton value="删除" styleClass="button01" onclick="return checkDelete();" action="#{emp_DataUploadBB.deleteconfig}"/>
         </h:panelGroup>


        <h:panelGroup>
            <c:verbatim escape="false">
                <input name=upbnt type=button class="button01" onclick="forUpInputItem()" value="<%=LanguageSupport.getResource("RYGL-1017","上移")%> ">
                <br>
                <br>
                <INPUT name=downbnt type=button class="button01" onclick="forDownInputItem()" value="<%=LanguageSupport.getResource("RYGL-1018","下移")%> ">
            </c:verbatim>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="2" align="center" width="95%" styleClass="table03" columnClasses="td_form01,td_form02">
        <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-2245","上传导入excel文件")%>:
           </f:verbatim>
        <h:panelGrid columns="3" cellspacing="3">
            <x:inputFileUpload id="excelFile" styleClass="input" value="#{emp_DataUploadBB.excelFile}" storage="file" size="40"/>
            <h:commandButton styleClass="button01" value="上传" action="#{emp_DataUploadBB.uploadFile}"
                             onclick="return checkSubmit();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
