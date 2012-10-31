package com.hr319wg.custom.attence.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.faces.event.ValueChangeEvent;

import org.activiti.engine.task.Task;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.attence.pojo.bo.AttLogBO;
import com.hr319wg.custom.attence.pojo.bo.AttRestBO;
import com.hr319wg.custom.attence.service.IAttBusiService;
import com.hr319wg.custom.attence.util.AttConstants;
import com.hr319wg.custom.pojo.bo.UserBO;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.workflow.service.ActivitiToolsService;
import com.hr319wg.xys.workflow.service.SelPersonsToolService;

public class AttRestBackingBean extends BaseBackingBean {
	//浏览申请
	private IAttBusiService attBusiService;
	private String pageInit;
	private List list;
	private PageVO mypage = new PageVO();
	private boolean selApply=true;
	private boolean selAuditing=true;
	private boolean selAudited;
	private boolean selRefuse=true;
	private String id;
	private ActivitiToolsService activitiToolService;
	private SelPersonsToolService selPersonsTool;
	private String queryInit;
	private boolean querySelf=true;
	private String beginDate;
	private String endDate;
	private String nameStr;
	private String personType;
	private String personTypeValue;
	private String orgID;
	private UserAPI userapi;
	private String inputInit;
	private String createType;
	private String selectedUserIds;
	private String selectPersonNames;
	private String inputEditBeginDate;
	private String inputEditEndDate;
	private String inputEditReason;
	private String inputEditApplyDays;
	private String inputEditInit;
	private String operItemID;
	private List<UserBO> currApproverList = new ArrayList();
	private Map<String,Object> days;
	private String inself;
	private String toRest;
	private String ismanager;	
	private String userId;
	private boolean selMyAtt;
	
	public boolean isSelMyAtt() {
		return selMyAtt;
	}

	public void setSelMyAtt(boolean selMyAtt) {
		this.selMyAtt = selMyAtt;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getIsmanager() {
		return ismanager;
	}

	public void setIsmanager(String ismanager) {
		this.ismanager = ismanager;
	}


	public String getToRest() {
		return toRest;
	}

	
	public void setToRest(String toRest) {
		this.toRest = toRest;
	}

	public String getInself() {
		return inself;
	}

	public void setInself(String inself) {
		this.inself = inself;
	}

	public Map<String, Object> getDays() {
		return days;
	}

	public void setDays(Map<String, Object> days) {
		this.days = days;
	}

	public List<UserBO> getCurrApproverList() {
		return currApproverList;
	}

	public void setCurrApproverList(List<UserBO> currApproverList) {
		this.currApproverList = currApproverList;
	}

	public String getOperItemID() {
		return operItemID;
	}

	public void setOperItemID(String operItemID) {
		this.operItemID = operItemID;
	}

	public String getSelectPersonNames() {
		return selectPersonNames;
	}
	
	public void setSelectPersonNames(String selectPersonNames) {
		this.selectPersonNames = selectPersonNames;
	}
	
	public String getInputEditBeginDate() {
		return inputEditBeginDate;
	}
	
	public void setInputEditBeginDate(String inputEditBeginDate) {
		this.inputEditBeginDate = inputEditBeginDate;
	}

	public String getInputEditEndDate() {
		return inputEditEndDate;
	}

	public void setInputEditEndDate(String inputEditEndDate) {
		this.inputEditEndDate = inputEditEndDate;
	}

	public String getInputEditReason() {
		return inputEditReason;
	}

	public void setInputEditReason(String inputEditReason) {
		this.inputEditReason = inputEditReason;
	}

	public String getInputEditApplyDays() {
		return inputEditApplyDays;
	}

	public void setInputEditApplyDays(String inputEditApplyDays) {
		this.inputEditApplyDays = inputEditApplyDays;
	}

	public void setInputInit(String inputInit) {
		this.inputInit = inputInit;
	}

	public void setInputEditInit(String inputEditInit) {
		this.inputEditInit = inputEditInit;
	}

	public String getSelectedUserIds() {
		return selectedUserIds;
	}

	public void setSelectedUserIds(String selectedUserIds) {
		this.selectedUserIds = selectedUserIds;
	}

	public String getInputEditInit() {
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			this.selectedUserIds=null;
			this.selectPersonNames=null;
			this.inputEditBeginDate=null;
			this.inputEditEndDate=null;
			this.inputEditApplyDays=null;
			this.inputEditApplyDays=null;
		}
		this.createType="1";
		doQuery();
		return null;
	}
	
	public void selPerson(){
		if(this.selectedUserIds!=null && !"".equals(this.selectedUserIds)){
			String[]userIDs=this.selectedUserIds.split(",");
			for(int i=0;i<userIDs.length;i++){
				PersonBO p = SysCacheTool.findPersonById(userIDs[i]);
				this.selectPersonNames+=p.getName();
				if(i!=userIDs.length){
					this.selectPersonNames+=",";
				}
			}
		}
	}
	
	public String saveInput(){
		if(this.selectedUserIds!=null && !"".equals(this.selectedUserIds)){
			String[]userIDs=this.selectedUserIds.split(",");
			for(int i=0;i<userIDs.length;i++){
				AttRestBO bo = new AttRestBO();
				bo.setPersonId(userIDs[i]);
				bo.setBeginTime(this.inputEditBeginDate);
				bo.setEndTime(this.inputEditEndDate);
				bo.setApplyDays(this.inputEditApplyDays);
				bo.setApplyTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
				bo.setStatus(AttConstants.STATUS_AUDIT_SUCCES);
				bo.setReason(this.inputEditReason);
				bo.setCreateType("1");
				try {
					this.attBusiService.saveOrUpdateBO(bo);
					this.attBusiService.updateLeaveDays("-1", bo.getApplyDays(), userIDs[i]);
				} catch (SysException e) {
					e.printStackTrace();
				}
			}
		}
		return "success";
	}
	
	public void deleteInput(){
		try {
			this.attBusiService.deleteBO(AttRestBO.class, this.operItemID);
		} catch (SysException e) {
			super.showMessageDetail("删除失败");
			e.printStackTrace();
		}
	}
	

	public String getCreateType() {
		return createType;
	}

	public void setCreateType(String createType) {
		this.createType = createType;
	}

	//补录
	public String getInputInit() {
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			this.orgID=null;
			this.nameStr=null;
			this.personType=null;
			this.beginDate=null;
			this.endDate=null;
		}
		String orgID1 = super.getRequestParameter("orgID");
		if(orgID1!=null && !"".equals(orgID1)){
			this.orgID=orgID1;
		}
		this.querySelf=false;
		this.selAudited=true;
		this.createType="1";
		doQuery();
		return inputInit;
	}
	//查询
	public String getQueryInit() {
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			this.orgID=null;
			this.nameStr=null;
			this.personType=null;
			this.beginDate=null;
			this.endDate=null;
			this.selApply=true;
			this.selAuditing=true;
			this.selAudited=true;
			this.selRefuse=true;
			this.inself=null;
		}
		String orgID1 = super.getRequestParameter("orgID");
		if(orgID1!=null && !"".equals(orgID1)){
			this.orgID=orgID1;
		}
		String inself1 = super.getRequestParameter("inself");
		if(inself1!=null && !"".equals(inself1)){
			this.inself=inself1;
		}
		this.querySelf=false;
		try {
			int role = CommonUtil.getRoleCount("07", super.getUserInfo().getUserId());
			if(role>0){
				this.ismanager="1";
			}else{
				this.ismanager=null;
			}
		} catch (SysException e) {
			e.printStackTrace();
		}


		doQuery();
		this.userId=super.getUserInfo().getUserId();
		return queryInit;
	}
	
	public boolean isQuerySelf() {
		return querySelf;
	}

	public void setQuerySelf(boolean querySelf) {
		this.querySelf = querySelf;
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getNameStr() {
		return nameStr;
	}

	public void setNameStr(String nameStr) {
		this.nameStr = nameStr;
	}

	public String getPersonType() {
		return personType;
	}

	public void setPersonType(String personType) {
		this.personType = personType;
	}

	public String getPersonTypeValue() {
		return personTypeValue;
	}

	public void setPersonTypeValue(String personTypeValue) {
		this.personTypeValue = personTypeValue;
	}

	public String getOrgID() {
		return orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}

	public UserAPI getUserapi() {
		return userapi;
	}

	public void setUserapi(UserAPI userapi) {
		this.userapi = userapi;
	}

	public void setQueryInit(String queryInit) {
		this.queryInit = queryInit;
	}

	public AttRestBO getRestBo() {
		return restBo;
	}
	public void setRestBo(AttRestBO restBo) {
		this.restBo = restBo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public IAttBusiService getAttBusiService() {
		return attBusiService;
	}
	public void setAttBusiService(IAttBusiService attBusiService) {
		this.attBusiService = attBusiService;
	}
	public SelPersonsToolService getSelPersonsTool() {
		return selPersonsTool;
	}
	public void setSelPersonsTool(SelPersonsToolService selPersonsTool) {
		this.selPersonsTool= selPersonsTool;
	}
	public ActivitiToolsService getActivitiToolService() {
		return activitiToolService;
	}
	public void setActivitiToolService(ActivitiToolsService activitiToolService) {
		this.activitiToolService = activitiToolService;
	}
	public void delete(){
		try{
			this.attBusiService.deleteRest(id);
			super.showMessageDetail("操作成功！");
		}catch(Exception e){
			e.printStackTrace();
			super.showMessageDetail("操作失败！");
		}
	}
	
	
	/**
	 * 重新报批，重点更改流程状态
	 */
	public void applyAgain(){
		try{
			AttRestBO bo=(AttRestBO)this.attBusiService.findBOById(AttRestBO.class, id);
			Task task=this.activitiToolService.getTaskByInstanceId(bo.getProcessId());
			Map map=new HashMap();
			map.put("currPersonId", super.getUserInfo().getUserId());
			activitiToolService.completeTask(task.getId(), map);
			bo.setStatus(AttConstants.STATUS_AUDIT);
			attBusiService.saveOrUpdateBO(bo);
		}catch(Exception e){
			e.printStackTrace();
			super.showMessageDetail("操作失败！");
		}
	}
	
//	
//	
//	
//	public void apply(){
//		try{
//			String keyId="";//流程key
//			String code=this.selPersonsTool.getGroupCodeByPersonId(super.getUserInfo().getUserId());
//			if(code!=null&&!code.equals("")){
//				keyId=AttConstants.getAttFlowKey(code);
//				if(keyId!=null&&!keyId.equals("")){
//					
//					//为流程下审批几点配置参数并启动流程
//					Map map=new HashMap();
//					map.put("deptId",super.getUserInfo().getDeptId());
//					String distanceId=this.activitiToolService.startProcessInstance(keyId, id,map);
//					
//					AttRestBO bo=(AttRestBO)this.attBusiService.findBOById(AttRestBO.class, id);
//					bo.setStatus(AttConstants.STATUS_AUDIT);
//					bo.setProcessId(distanceId);
//					attBusiService.saveOrUpdateBO(bo);
//				}else{
//					super.showMessageDetail("当前登录人的团队标识未设置流程！");
//				}
//			}else{
//				super.showMessageDetail("当前登录人没有团队标识，操作失败！");
//			}
//		}catch(Exception e){
//			e.printStackTrace();
//			super.showMessageDetail("操作失败！");
//		}
//	}
//	public void applyAgain(){
//		try{
//			AttRestBO bo=(AttRestBO)this.attBusiService.findBOById(AttRestBO.class, id);
//			Task task=this.activitiToolService.getTaskByInstanceId(bo.getProcessId());
//			Map map=new HashMap();
//			map.put("reApplay", new Boolean(true));
//			activitiToolService.completeTask(task.getId(), map);
//			bo.setStatus(AttConstants.STATUS_AUDIT);
//			attBusiService.saveOrUpdateBO(bo);
//		}catch(Exception e){
//			e.printStackTrace();
//			super.showMessageDetail("操作失败！");
//		}
//	}
	
	public void cancelApply(){
		try{
			AttRestBO bo=(AttRestBO)this.attBusiService.findBOById(AttRestBO.class, id);
			Task task=this.activitiToolService.getTaskByInstanceId(bo.getProcessId());
			Map map=new HashMap();
			map.put("reApplay", new Boolean(true));
			activitiToolService.completeTask(task.getId(), map);
		}catch(Exception e){
			e.printStackTrace();
			super.showMessageDetail("操作失败！");
		}
	}

	public void qryApply(ValueChangeEvent event) {
		selApply = event.getNewValue().toString().equals("true");
		doQuery();
	}

	public void qryAuditing(ValueChangeEvent event) {
		selAuditing = event.getNewValue().toString().equals("true");
		doQuery();
	}

	public void qryAudited(ValueChangeEvent event) {
		selAudited = event.getNewValue().toString().equals("true");
		doQuery();
	}

	public void qryRefuse(ValueChangeEvent event) {
		selRefuse = event.getNewValue().toString().equals("true");
		doQuery();
	}

	public boolean getSelApply() {
		return selApply;
	}

	public void setSelApply(boolean selApply) {
		this.selApply = selApply;
	}

	public boolean getSelAuditing() {
		return selAuditing;
	}

	public void setSelAuditing(boolean selAuditing) {
		this.selAuditing = selAuditing;
	}

	public boolean getSelAudited() {
		return selAudited;
	}

	public void setSelAudited(boolean selAudited) {
		this.selAudited = selAudited;
	}

	public boolean getSelRefuse() {
		return selRefuse;
	}

	public void setSelRefuse(boolean selRefuse) {
		this.selRefuse = selRefuse;
	}

	public String first() {
		mypage.setCurrentPage(1);
		doQuery();
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		doQuery();
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		doQuery();
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		doQuery();
		return "";
	}

	public void doQuery() {
		try {
			List sList = new ArrayList();
			if (selAuditing) {
				sList.add(AttConstants.STATUS_AUDIT);
			}
			if (selAudited) {
				sList.add(AttConstants.STATUS_AUDIT_SUCCES);
			}
			if (selRefuse) {
				sList.add(AttConstants.STATUS_AUDIT_LOSE);
			}
			String[] status=new String[sList.size()];
			if(sList!=null&&sList.size()>0){
				for(int i=0;i<sList.size();i++){
					status[i]=(String)sList.get(i);
				}
			}
			
			if(mypage.getCurrentPage()==0){
				mypage.setCurrentPage(1);
			}
			if(this.personType==null || "".equals(this.personType)){
				try {
					this.personType=CommonUtil.getAllPersonTypes(super.getUserInfo());
				} catch (SysException e) {
					e.printStackTrace();
				}
			}
			String userID = null;
			if(querySelf){
				userID = super.getUserInfo().getUserId();
			}
			list = attBusiService.getAttRestBO(mypage, userID, status, beginDate, endDate, orgID, personType, nameStr, createType, this.inself, this.ismanager, super.getUserInfo().getUserId(), this.selMyAtt);
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++){
					AttRestBO bo=(AttRestBO)list.get(i);
					PersonBO p = SysCacheTool.findPersonById(bo.getPersonId());
					bo.setPersonName(p.getName());
					bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
					bo.setPersonType(CodeUtil.interpertCode(p.getPersonType()));
					bo.setPersonCode(p.getPersonCode());
					int count = CommonUtil.getAttLogCount(bo.getId());
					if(count>0){
						bo.setAppro(true);
					}
					list.set(i, bo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getPageInit() {
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}
	//公出编辑
	private String initEdit;
	private AttRestBO restBo;
	private String personName;
	private String personId;
	
	
	public String getPersonId() {
		return personId;
	}
	public void setPersonId(String personId) {
		this.personId = personId;
	}
	public String save(){
		try{
			restBo.setPersonId(personId);
			restBo.setApplyTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
			if("1".equals(createType)){
				restBo.setStatus(AttConstants.STATUS_AUDIT_SUCCES);
			}else if(restBo.getStatus()==null||restBo.getStatus().equals("")){
				restBo.setStatus(AttConstants.STATUS_APPLY);
			}
			attBusiService.saveOrUpdateBO(restBo);
			this.id=restBo.getId();
			String result = this.attBusiService.applyRest(super.getUserInfo().getUserId(),this.id);
			if(result==null){
				this.toRest="1";//到中间页面后，跳转到
				return "successleave";				
			}else{
				super.showMessageDetail(result);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	public String getPersonName() {
		return personName;
	}
	public void setPersonName(String personName) {
		this.personName = personName;
	}
	public String getInitEdit() {
		try{
			if(super.getRequestParameter("new")!=null){
				restBo=new AttRestBO();
			}else if(super.getRequestParameter("id")!=null){
				id=super.getRequestParameter("id");
				restBo=(AttRestBO)this.attBusiService.findBOById(AttRestBO.class,id);
			}
			if(restBo.getPersonId()!=null&&!restBo.getPersonId().equals("")){
				personId=restBo.getPersonId();
				personName=SysCacheTool.findPersonById(restBo.getPersonId()).getName();
			}else{
				personId=super.getUserInfo().getUserId();
				personName=super.getUserInfo().getName();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		//获得带薪假存休子集的数据
				try {
					List list=this.attBusiService.getDays(personId);
					Map<String,Object> map=(Map<String,Object>)list.get(0);
					this.days=map;
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		return initEdit;
	}
	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}
	
	//查看审批流程
		private String initLog;
		private List logList;


		public void queryLog(){
			
			try{
				String distanceId="";
				AttRestBO lbo=(AttRestBO)this.attBusiService.findBOById(AttRestBO.class, id);
				if(lbo.getProcessId()!=null&&!lbo.getProcessId().equals("")){
					distanceId=lbo.getProcessId();
				}
				super.getHttpSession().setAttribute("distanceId", distanceId);
				logList=attBusiService.getAttLogBOById(id);
				if(logList!=null&&logList.size()>0){
					for(int i=0;i<logList.size();i++){
						AttLogBO log=(AttLogBO)logList.get(i);
						log.setPersonId(SysCacheTool.findPersonById(log.getPersonId()).getName());
						logList.set(i, log);
					}
				}
				if(!"4".equals(lbo.getStatus())){
					List<String> userIDs = this.activitiToolService.getOwners(distanceId);
					if(userIDs!=null && userIDs.size()>0){
						String[]userIDs2 = new String[userIDs.size()];
						for(int i=0;i<userIDs.size();i++){
							userIDs2[i]=userIDs.get(i);
						}
						this.currApproverList = this.attBusiService.getAllCurrApprover(userIDs2);
						if(this.currApproverList!=null){
							for(UserBO bo : currApproverList){
								PersonBO p = SysCacheTool.findPersonById(bo.getUserID());
								bo.setSecondDeptName(CodeUtil.interpertCode(bo.getSecDeptID()));
								bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
								bo.setPersonType(CodeUtil.interpertCode(p.getPersonType()));
							}
						}
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			
//			try{
//				String distanceId="";
//				AttRestBO bo=(AttRestBO)this.attBusiService.findBOById(AttRestBO.class, id);
//				if(bo.getProcessId()!=null&&!bo.getProcessId().equals("")){
//					distanceId=bo.getProcessId();
//				}
//				super.getHttpSession().setAttribute("distanceId", distanceId);
//				logList=attBusiService.getAttLogBOById(id);
//				if(logList!=null&&logList.size()>0){
//					for(int i=0;i<logList.size();i++){
//						AttLogBO log=(AttLogBO)logList.get(i);
//						log.setPersonId(SysCacheTool.findPersonById(log.getPersonId()).getName());
//						logList.set(i, log);
//					}
//				}
//			}catch(Exception e){
//				e.printStackTrace();
//			}
		}
		public String getInitLog() {
			this.currApproverList=new ArrayList();
			if(super.getRequestParameter("id")!=null){
				id=super.getRequestParameter("id");
			}
			queryLog();
			return initLog;
		}
		public void setInitLog(String initLog) {
			this.initLog = initLog;
		}
		public List getLogList() {
			return logList;
		}
		public void setLogList(List logList) {
			this.logList = logList;
		}
		public void qryMyAtt(ValueChangeEvent event) {
			selMyAtt = event.getNewValue().toString().equals("true");
		}
		
}
