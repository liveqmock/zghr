<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
   function modify(id){
	   window.showModalDialog("/employee/DChange/wageItemEdit.jsf?wageItemId="+id, null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
	   return true;
   }
</script>
<c:verbatim>
	<link href="/css/style.css" rel="stylesheet" type="text/css" />
</c:verbatim>
<x:saveState value="#{empDchangeWageMgrBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{empDchangeWageMgrBB.pageInit}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <h:panelGrid width="98%" columns="2">
						<h:panelGrid align="right" columns="2">
							<h:panelGroup>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1043", "记录数")%>：
			    </f:verbatim>
								<h:outputText value="#{empDchangeWageMgrBB.mypage.totalRecord}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1044", "页数")%>：
			    </f:verbatim>
								<h:outputText value="#{empDchangeWageMgrBB.mypage.totalPage}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1045", "每页有")%>
								</f:verbatim>
								<h:outputText value="#{empDchangeWageMgrBB.mypage.pageSize}"></h:outputText>
								<h:outputText value="  "></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1046", "当前为第")%>
								</f:verbatim>
								<h:outputText value="#{empDchangeWageMgrBB.mypage.currentPage}"></h:outputText>
                              <f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1047", "页")%>
								</f:verbatim>
								<h:commandButton value="首页"
									action="#{empDchangeWageMgrBB.first}" styleClass="button01"></h:commandButton>
								<h:commandButton value="上页" action="#{empDchangeWageMgrBB.pre}"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="下页" action="#{empDchangeWageMgrBB.next}"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="尾页" action="#{empDchangeWageMgrBB.last}"
									styleClass="button01"></h:commandButton>
							</h:panelGroup>

						</h:panelGrid>
					</h:panelGrid> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>
						<x:dataTable value="#{empDchangeWageMgrBB.wageItemList}"
							var="list" align="center" id="dateList" headerClass="td_top"
							columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
							styleClass="table03" width="90%" rowIndexVar="index">

							<h:column>
								<c:facet name="header">
									   <f:verbatim>
				     		<%=LanguageSupport.getResource("XTGL-1029", "序号")%>
			           </f:verbatim>
								</c:facet>
								<h:outputText value="#{index+1}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								     <f:verbatim>
				     		<%=LanguageSupport.getResource("RYGL-2041", "指标项")%>
			           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.fieldId}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								   <f:verbatim>
				     		<%=LanguageSupport.getResource("RYGL-2042", "指标名称")%>
			           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.fieldDes}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								       <f:verbatim>
				     		<%=LanguageSupport.getResource("RYGL-2043", "原值")%>
			           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.oldValue}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								    <f:verbatim>
				     		<%=LanguageSupport.getResource("JGGL-1101", "新值")%>
			           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.newValue}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								    <f:verbatim>
				     		<%=LanguageSupport.getResource("XTGL-1051", "状态")%>
			           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.statusDes}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								     <f:verbatim>
				     		<%=LanguageSupport.getResource("XTGL-1090", "生效时间")%>
			           </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.updateDate}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									<f:verbatim>
						     		<%=LanguageSupport.getResource("YXGL-1026", "操作")%>
					            </f:verbatim>
								</c:facet>
								<h:commandButton value="录入新值"
									onclick="return modify('#{list.wageItemId}')"
									styleClass="button01"></h:commandButton>
								<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
									action="#{empDchangeWageMgrBB.delete}" styleClass="button01">
									<x:updateActionListener
										property="#{empDchangeWageMgrBB.wageItemId}"
										value="#{list.wageItemId}" />
								</h:commandButton>
							</h:column>
						</x:dataTable>

						<c:verbatim>
					</div></td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
