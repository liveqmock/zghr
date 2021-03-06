package com.hr319wg.custom.attence.web;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.faces.model.SelectItem;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.attence.pojo.bo.AttOvertimePayBO;
import com.hr319wg.custom.attence.pojo.bo.AttPutoff2BO;
import com.hr319wg.custom.attence.pojo.bo.AttTempDataBO;
import com.hr319wg.custom.attence.pojo.bo.AttYearBO;
import com.hr319wg.custom.attence.service.IAttBusiService;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.user.pojo.vo.UserQryVO;
import com.hr319wg.user.ucc.IUserQryUCC;
import com.hr319wg.util.CodeUtil;

public class AttPutoffMgrBackingBean extends BaseBackingBean {
	private PageVO mypage = new PageVO();
	private String pageInit;
	private String nameStr;
	private String personType;
	private String personTypeValue;
	private String selectedUserIDs;
	private String orgID;
	private String operUserID;
	private String applyYear;
	private String putoffsum;
	private List list;
	private List overtimeList;
	private List yearList;
	private UserAPI userapi;
	private IAttBusiService attBusiService;
	private String userid;
	private String editInit;
	private AttPutoff2BO bo;
	private String modifyInit;    
	private String putoffDays;
	private String leaveDays;
	private String bingjia;
	private String hunjia;
	private String sangjia;
	private String chanjia;
	private String nanchanjia;
	private String daixinjia;
	private String yinggai;
	private String shiji;
	private String rate;
	private IUserQryUCC userqryucc;
	private List<SelectItem> qryList;
	private String qryID;
	private String resetInit;	
    private String beginDate="";
    private String endDate="";
    private String overtimePayMonth="";
    private String overtimeInit;
    private String attYearInit;
    private String tempBeginDate;
    private String tempEndDate;
	private List<AttTempDataBO> attTempDataList;
	private String attTempDataInit;
	private String yearStr;
	private String overtimePay="20";
	private UploadedFile excelFile;
	
	public UploadedFile getExcelFile() {
		return excelFile;
	}

	public void setExcelFile(UploadedFile excelFile) {
		this.excelFile = excelFile;
	}

	
	public String getSelectedUserIDs() {
		return selectedUserIDs;
	}
	
	public void setSelectedUserIDs(String selectedUserIDs) {
		this.selectedUserIDs = selectedUserIDs;
	}
	public String getOvertimePay() {
		return overtimePay;
	}

	public void setOvertimePay(String overtimePay) {
		this.overtimePay = overtimePay;
	}

	public String getYearStr() {
		return yearStr;
	}

	public void setYearStr(String yearStr) {
		this.yearStr = yearStr;
	}

	public String getAttTempDataInit() {
		this.selectedUserIDs=null;
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			this.orgID=null;
			this.nameStr=null;
			this.personType=null;
		}
		String orgID1 = super.getRequestParameter("orgID");
		if(orgID1!=null && !"".equals(orgID1)){
			this.orgID=orgID1;
		}
		try {
			this.putoffsum = this.attBusiService.getPutoffSum();
		} catch (SysException e) {
			e.printStackTrace();
		}	
		
		attTempDataDoQuery();
		return attTempDataInit;
	}

	public void setAttTempDataInit(String attTempDataInit) {
		this.attTempDataInit = attTempDataInit;
	}

	
	public List getAttTempDataList() {
		return attTempDataList;
	}

	public void setAttTempDataList(List attTempDataList) {
		this.attTempDataList = attTempDataList;
	}

	public String getTempBeginDate() {
		return tempBeginDate;
	}

	public void setTempBeginDate(String tempBeginDate) {
		this.tempBeginDate = tempBeginDate;
	}

	public String getTempEndDate() {
		return tempEndDate;
	}

	public void setTempEndDate(String tempEndDate) {
		this.tempEndDate = tempEndDate;
	}

	public List getYearList() {
		return yearList;
	}

	public void setYearList(List yearList) {
		this.yearList = yearList;
	}
    public String getAttYearInit() {
    	String act = super.getRequestParameter("act");
		if("init".equals(act)){
			this.orgID=null;
			this.nameStr=null;
			this.personType=null;
		}
		String orgID1 = super.getRequestParameter("orgID");
		if(orgID1!=null && !"".equals(orgID1)){
			this.orgID=orgID1;
		}
		try {
			this.putoffsum = this.attBusiService.getPutoffSum();
		} catch (SysException e) {
			e.printStackTrace();
		}	
		
		attYearDoQuery();
		return attYearInit;
	}

	public void setAttYearInit(String attYearInit) {
		this.attYearInit = attYearInit;
	}

	public List getOvertimeList() {
		return overtimeList;
	}

	public void setOvertimeList(List overtimeList) {
		this.overtimeList = overtimeList;
	}

	public String getOvertimeInit() {
    	String act = super.getRequestParameter("act");
		if("init".equals(act)){
			this.orgID=null;
			this.nameStr=null;
			this.personType=null;
		}
		String orgID1 = super.getRequestParameter("orgID");
		if(orgID1!=null && !"".equals(orgID1)){
			this.orgID=orgID1;
		}
		try {
			this.putoffsum = this.attBusiService.getPutoffSum();
		} catch (SysException e) {
			e.printStackTrace();
		}	
		
		overtimeReset();
		overtimeDoQuery();
		return overtimeInit;
	}

	public void setOvertimeInit(String overtimeInit) {
		this.overtimeInit = overtimeInit;
	}

	public String getOvertimePayMonth() {
		return overtimePayMonth;
	}

	public void setOvertimePayMonth(String overtimePayMonth) {
		this.overtimePayMonth = overtimePayMonth;
	}

	public String getYinggai() {
		return yinggai;
	}

	public void setYinggai(String yinggai) {
		this.yinggai = yinggai;
	}

	public String getShiji() {
		return shiji;
	}

	public void setShiji(String shiji) {
		this.shiji = shiji;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
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

	public String getResetInit() {
		try {
			List<UserQryVO> list = this.userqryucc.queryUserQry(super.getUserInfo().getUserId(), "0311");
			qryList = new ArrayList();
			SelectItem item1 = new SelectItem("-1", "--选择查询方案--");
			qryList.add(item1);
			for (int i = 0; i < list.size(); i++) {
				UserQryVO role = (UserQryVO)list.get(i);
				SelectItem item = new SelectItem();
				item.setLabel(role.getQryName());
				item.setValue(role.getQryID());
				qryList.add(item);
			}
			
		} catch (SysException e1) {
			e1.printStackTrace();
		}
		return resetInit;
	}

	public void setResetInit(String resetInit) {
		this.resetInit = resetInit;
	}

	public String getQryID() {
		return qryID;
	}

	public void setQryID(String qryID) {
		this.qryID = qryID;
	}

	public IUserQryUCC getUserqryucc() {
		return userqryucc;
	}

	public void setUserqryucc(IUserQryUCC userqryucc) {
		this.userqryucc = userqryucc;
	}

	public List<SelectItem> getQryList() {
		return qryList;
	}

	public void setQryList(List<SelectItem> qryList) {
		this.qryList = qryList;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getPutoffDays() {
		return putoffDays;
	}

	public void setPutoffDays(String putoffDays) {
		this.putoffDays = putoffDays;
	}

	public String getLeaveDays() {
		return leaveDays;
	}

	public void setLeaveDays(String leaveDays) {
		this.leaveDays = leaveDays;
	}

	public String getBingjia() {
		return bingjia;
	}

	public void setBingjia(String bingjia) {
		this.bingjia = bingjia;
	}

	public String getHunjia() {
		return hunjia;
	}

	public void setHunjia(String hunjia) {
		this.hunjia = hunjia;
	}

	public String getSangjia() {
		return sangjia;
	}

	public void setSangjia(String sangjia) {
		this.sangjia = sangjia;
	}

	public String getChanjia() {
		return chanjia;
	}

	public void setChanjia(String chanjia) {
		this.chanjia = chanjia;
	}

	public String getNanchanjia() {
		return nanchanjia;
	}

	public void setNanchanjia(String nanchanjia) {
		this.nanchanjia = nanchanjia;
	}

	public String getDaixinjia() {
		return daixinjia;
	}

	public void setDaixinjia(String daixinjia) {
		this.daixinjia = daixinjia;
	}

	public String getModifyInit() {
		String subID = super.getRequestParameter("subID");
		try {
			PersonBO p=SysCacheTool.findPersonByCode(subID);
			this.bo =(AttPutoff2BO)this.attBusiService.findBOById(AttPutoff2BO.class, p.getPersonId());
			this.bo.setName(p.getName());
			this.bo.setDeptName(p.getDeptName());
			this.putoffDays=bo.getPutoffDays();
			this.leaveDays=bo.getLeaveDays();
			this.bingjia=bo.getBingjia();
			this.hunjia=bo.getHunjia();
			this.sangjia=bo.getSangjia();
			this.chanjia=bo.getChanjia();
			this.nanchanjia=bo.getNanchanjia();
			this.daixinjia=bo.getDaixinjia();
			this.yinggai=bo.getYearAttence();
			this.shiji=bo.getYearRealAttence();
			this.rate=bo.getAttenceRate();
		} catch (SysException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		return modifyInit;
	}

	public void setModifyInit(String modifyInit) {
		this.modifyInit = modifyInit;
	}

	public AttPutoff2BO getBo() {
		return bo;
	}

	public void setBo(AttPutoff2BO bo) {
		this.bo = bo;
	}

	public String getEditInit() {
		return editInit;
	}

	public void setEditInit(String editInit) {
		this.editInit = editInit;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPutoffsum() {
		return putoffsum;
	}

	public void setPutoffsum(String putoffsum) {
		this.putoffsum = putoffsum;
	}

	public String getOperUserID() {
		return operUserID;
	}

	public void setOperUserID(String operUserID) {
		this.operUserID = operUserID;
	}

	public String getApplyYear() {
		return applyYear;
	}

	public void setApplyYear(String applyYear) {
		this.applyYear = applyYear;
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

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public UserAPI getUserapi() {
		return userapi;
	}

	public void setUserapi(UserAPI userapi) {
		this.userapi = userapi;
	}

	public IAttBusiService getAttBusiService() {
		return attBusiService;
	}

	public void setAttBusiService(IAttBusiService attBusiService) {
		this.attBusiService = attBusiService;
	}
	
	public String first() {
		mypage.setCurrentPage(1);
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		return "";
	}
	
	public String getPageInit() {
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			this.orgID=null;
			this.nameStr=null;
			this.personType=null;
		}
		String orgID1 = super.getRequestParameter("orgID");
		if(orgID1!=null && !"".equals(orgID1)){
			this.orgID=orgID1;
		}
		try {
			this.putoffsum = this.attBusiService.getPutoffSum();
		} catch (SysException e) {
			e.printStackTrace();
		}	
		
		//reset();
		doQuery();
		return pageInit;
	}

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}
	public void doQuery() {
		try {
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
			List list1 = this.attBusiService.getAllAttPutoffDataBO(mypage, orgID, nameStr, personType);
			if(list1==null){
				list1 = new ArrayList();
			}
			this.list = new ArrayList<AttPutoff2BO>();
			for(int i=0;i<list1.size();i++){
				Object[]obj = (Object[])list1.get(i);
				AttPutoff2BO bo=(AttPutoff2BO)obj[0];
				bo.setSecDeptName(CodeUtil.interpertCode(obj[1].toString()));
				PersonBO p=SysCacheTool.findPersonById(bo.getId());
				try{
					bo.setId(p.getPersonCode());
				}catch(Exception e) {
					bo.setId("无");
				}
				
				try{
					bo.setName(p.getName());
				}catch(Exception e) {
					bo.setName("无");
				}
				try{
					bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
				}catch(Exception e) {
					bo.setDeptName("无");
				}
				this.list.add(bo);
			}
//			for(AttPutoffDataBO bo : list){
//				PersonBO p = SysCacheTool.findPersonById(bo.getID());
//				bo.setName(p.getName());
//				bo.setPersonCode(p.getPersonCode());
//				bo.setPersonTypeName(CodeUtil.interpertCode(p.getPersonType()));
//				bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
//			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//计入工资
	public void addToWage(){
		try {
			this.attBusiService.updatePutoff(this.applyYear);
			super.showMessageDetail("操作完成");
		} catch (SysException e) {
			super.showMessageDetail("操作失败");			
			e.printStackTrace();
		}
	}
	//清空带薪假存休数据
	public void cleanData1(){
		try {
				this.attBusiService.cleanData1();
			
			super.showMessageDetail("操作完成");
		} catch (SysException e) {
			super.showMessageDetail("操作失败");			
			e.printStackTrace();
		}catch(Exception e){
			
		}
	}
	//清空带薪假存休数据
		public void cleanData2(){
			try {
					this.attBusiService.cleanData2();
				
				super.showMessageDetail("操作完成");
			} catch (SysException e) {
				super.showMessageDetail("操作失败");			
				e.printStackTrace();
			}catch(Exception e){
				
			}
		}
	//修改某个人的带薪假存休数据
	public String save(){
		try {
			this.bo.setPutoffDays(this.getPutoffDays());
			this.bo.setLeaveDays(this.getLeaveDays());
			this.bo.setBingjia(this.getBingjia());
		    this.bo.setHunjia(this.getHunjia());
		    this.bo.setSangjia(this.getSangjia());
		    this.bo.setChanjia(this.getChanjia());
		    this.bo.setNanchanjia(this.getNanchanjia());
		    this.bo.setDaixinjia(this.getDaixinjia());
		    this.bo.setYearAttence(this.yinggai);
		    this.bo.setYearRealAttence(this.shiji);
		    this.bo.setAttenceRate(this.rate);
		    this.attBusiService.saveOrUpdateBO(this.bo);
			
			return "success";
		} catch (SysException e) {
			super.showMessageDetail("修改失败");
			e.printStackTrace();
		}
		return null;
	}
	
	public void toWage(){
			try {
				PersonBO p=SysCacheTool.findPersonByCode(this.userid);
				this.bo =(AttPutoff2BO)this.attBusiService.findBOById(AttPutoff2BO.class, p.getPersonId());
				
				this.bo.setName(p.getName());
				this.bo.setDeptName(p.getDeptName());
			} catch (SysException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				String id=bo.getId();
				//得到存休小时数
				if(bo.getPutoffDays()==null){
					bo.setPutoffDays("0");
				}
				String hours=String.valueOf(Double.parseDouble(bo.getPutoffDays()));
				//更新加班费子集的信息
				this.attBusiService.updateOvertimePay(id, hours,this.overtimePayMonth,overtimePay);
			} catch (SysException e) {
				super.showMessageDetail("修改失败");
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
	}
	public String resetData(){
		try {
			this.attBusiService.updateResetData(this.qryID);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "success";
	}
	public String yearAttence(){
		try {
			if(!this.beginDate.equals("")||!this.endDate.equals("")){
				this.attBusiService.getYearAttence(this.beginDate,this.endDate);
			}
			
		} catch (SysException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "success";
	}
	public String overtimeReset(){
		String subID = super.getRequestParameter("subID");
		String set = super.getRequestParameter("set");
		if(set!=null){
			try {
				PersonBO p=SysCacheTool.findPersonByCode(subID);
				this.bo =(AttPutoff2BO)this.attBusiService.findBOById(AttPutoff2BO.class, p.getPersonId());
				
				this.bo.setName(p.getName());
				this.bo.setDeptName(p.getDeptName());
			} catch (SysException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				String id=bo.getId();
				//得到存休小时数
				if(bo.getPutoffDays()==null){
					bo.setPutoffDays("0");
				}
				String hours=String.valueOf(Double.parseDouble(bo.getPutoffDays()));
				//更新加班费子集的信息
				this.overtimePayMonth=super.getRequestParameter("selectMonth");
				this.attBusiService.updateOvertimePay(id, hours,this.overtimePayMonth,overtimePay);
				return "success";
			} catch (SysException e) {
				super.showMessageDetail("修改失败");
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return null;
	}
	
	public void overtimeDoQuery() {
		try {
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
			List list1 = this.attBusiService.getOvertimePayBO(mypage, orgID, nameStr, personType,this.overtimePayMonth);
			if(list1==null){
				list1 = new ArrayList();
			}
			this.overtimeList = new ArrayList<AttOvertimePayBO>();
			for(int i=0;i<list1.size();i++){
				Object[]obj = (Object[])list1.get(i);
				AttOvertimePayBO bo=(AttOvertimePayBO)obj[0];
				bo.setSecDeptName(CodeUtil.interpertCode(obj[1].toString()));
				PersonBO p=SysCacheTool.findPersonById(bo.getUserID());
				bo.setPersonCode(p.getPersonCode());
				try{
					bo.setName(p.getName());
				}catch(Exception e) {
					bo.setName("无");
				}
				try{
					bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
				}catch(Exception e) {
					bo.setDeptName("无");
				}
				this.overtimeList.add(bo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void attYearDoQuery() {
		try {
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
			List list1 = this.attBusiService.getYearBO(mypage, orgID, nameStr, personType,yearStr);
			if(list1==null){
				list1 = new ArrayList();
			}
			this.yearList = new ArrayList<AttYearBO>();
			for(int i=0;i<list1.size();i++){
				Object[]obj = (Object[])list1.get(i);
				AttYearBO bo=(AttYearBO)obj[0];
				bo.setSecDeptName(CodeUtil.interpertCode(obj[1].toString()));
				PersonBO p=SysCacheTool.findPersonById(bo.getPersonId());
				try{
					bo.setPersonCode(p.getPersonCode());
				}catch(Exception e) {
					bo.setPersonId("无");
				}
				
				try{
					bo.setName(p.getName());
				}catch(Exception e) {
					bo.setName("无");
				}
				try{
					bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
				}catch(Exception e) {
					bo.setDeptName("无");
				}
				this.yearList.add(bo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//计算临时考勤
	public String updateCalcAttTempData(){
		try {
			this.attBusiService.updateCalcAttTempData("1651", this.tempBeginDate, this.tempEndDate);
			this.attBusiService.updateAttTempDate(this.tempBeginDate, this.tempEndDate);
			super.showMessageDetail("计算完成");
		} catch (SysException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block 
			e.printStackTrace();
		} 
		return null;
	}
	public void attTempDataDoQuery() {
		try {
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
			List list1 = this.attBusiService.getAttTempDataBO(mypage, orgID, nameStr, personType);
			if(list1==null){
				list1 = new ArrayList();
			}
			this.attTempDataList = new ArrayList<AttTempDataBO>();
			for(int i=0;i<list1.size();i++){
				Object[]obj = (Object[])list1.get(i);
				AttTempDataBO bo=(AttTempDataBO)obj[0];
				bo.setSecDeptName(CodeUtil.interpertCode(obj[1].toString()));
				PersonBO p=SysCacheTool.findPersonById(bo.getPersonId());
				bo.setPersonCode(p.getPersonCode());
				
				try{
					bo.setName(p.getName());
				}catch(Exception e) {
					bo.setName("无");
				}
				try{
					bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
				}catch(Exception e) {
					bo.setDeptName("无");
				}
				this.attTempDataList.add(bo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void uploadFile(){
		try {
			Workbook wb = Workbook.getWorkbook(this.excelFile.getInputStream());
			Sheet st=wb.getSheet(0);
			int stRow=st.getRows();
			int success=0;
			int fail=0;
			String errperson="";
			
			for(int i=1;i<stRow;i++){
				String pCode = st.getCell(0, i).getContents();
				if(pCode==null || "".equals(pCode)){
					break;
				}else{
					PersonBO p = SysCacheTool.findPersonByCode(pCode.trim());
					if(p!=null){
						try {
							this.bo =(AttPutoff2BO)this.attBusiService.findBOById(AttPutoff2BO.class, p.getPersonId());
							this.attBusiService.updateOvertimePay(p.getPersonId(), bo.getPutoffDays(),this.overtimePayMonth,overtimePay);
							success++;
						} catch (SysException e) {
							fail++;
							e.printStackTrace();
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}else{
						fail++;
						errperson+=pCode+",";
					}
				}
			}
			if(fail==0){
				this.orgID=null;
				super.showMessageDetail("成功"+success+"个");				
			}else{
				String err="成功"+success+"个失败"+fail+"个";
				if(errperson.length()!=0){
					err+=",其中人员编号"+errperson+"的人员不存在";
				}
				super.showMessageDetail(err);								
			}
		} catch (BiffException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		}}
		
	public void sendEmail(){
		List<Map> list = new ArrayList<Map>();
		try {
			List detailList = this.attBusiService.getAttTempDataBO(orgID, nameStr, personType, selectedUserIDs);
			this.selectedUserIDs=null;
			if(detailList==null){
				detailList=new ArrayList();
			}
			for(int i=0;i<detailList.size();i++){
				Object[]obj = (Object[])detailList.get(i);
				Map m = new HashMap();
				m.put("OAName", obj[0]);
				m.put("detail", obj[1]);
				list.add(m);
			}
			if(list.size()>0){
				this.attBusiService.batchSendEmail(list);
			}
		} catch (SysException e) {
			e.printStackTrace();
			super.showMessageDetail("发送失败");
		}
		super.showMessageDetail("发送完毕");
	}

}
