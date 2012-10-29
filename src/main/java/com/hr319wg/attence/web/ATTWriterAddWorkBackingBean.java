package com.hr319wg.attence.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttOverTimeLogBO;
import com.hr319wg.attence.pojo.bo.AttOverTimeRecBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;

public class ATTWriterAddWorkBackingBean extends BaseBackingBean {
	private String status = "1";
	private String reasonValue;
	private String destValue;
	private String kqglLeaverDayValue;
	private String begindatevalueWdate;
	private String enddatevalueWdate;
	private List listscommon=new ArrayList();
	private String pageInit;
	private IAttenceSetUCC attenceSetUCC;

	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}

	public String getPageInit() {
		find();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	
	public List getListscommon() {
		return listscommon;
	}

	public void setListscommon(List listscommon) {
		this.listscommon = listscommon;
	}

	public String getReasonValue() {
		return reasonValue;
	}

	public void setReasonValue(String reasonValue) {
		this.reasonValue = reasonValue;
	}

	public String getDestValue() {
		return destValue;
	}

	public void setDestValue(String destValue) {
		this.destValue = destValue;
	}

	public String getKqglLeaverDayValue() {
		return kqglLeaverDayValue;
	}

	public void setKqglLeaverDayValue(String kqglLeaverDayValue) {
		this.kqglLeaverDayValue = kqglLeaverDayValue;
	}

	public String getBegindatevalueWdate() {
		return begindatevalueWdate;
	}

	public void setBegindatevalueWdate(String begindatevalueWdate) {
		this.begindatevalueWdate = begindatevalueWdate;
	}

	public String getEnddatevalueWdate() {
		return enddatevalueWdate;
	}

	public void setEnddatevalueWdate(String enddatevalueWdate) {
		this.enddatevalueWdate = enddatevalueWdate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String find(){
		try{
			if(listscommon!=null && listscommon.size()>0){
				listscommon=new ArrayList();
			}
            List list1=(List)super.getHttpSession().getAttribute("perIdListsCommon");
            if(list1!=null && list1.size()>0){
            	for(int i=0;i<list1.size();i++){
            		String id=(String)list1.get(i);
					AttClassGroupVO attclassgroupvo=attenceSetUCC.findAttClassGroupVObyId(id);
					OrgBO a=SysCacheTool.findOrgById(attclassgroupvo.getDeptId());
					attclassgroupvo.setDeptName(a.getName());
					OrgBO b1 = SysCacheTool.findOrgById(attclassgroupvo.getOrgId());
					attclassgroupvo.setOrgName(b1.getName());
					listscommon.add(attclassgroupvo);
            	}
            }
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public String remove(){
		String ids[] = getServletRequest().getParameterValues("selected_ids");
        List list=(List)super.getHttpSession().getAttribute("perIdListsCommon");
        if(list!=null && list.size()>0){
            int i=0;
            while(i<list.size()){
            	String id=(String)list.get(i);
            	if(id!=null && !"".equals(id)){
                  if(ids!=null){
                	  String name="";
                	for(int j=0;j<ids.length;j++){
                		String id1=(String)ids[j];
                		if(id.equals(id1)){
                			name="name";
                		}
                	}
                	if(!"".equals(name)){
                		list.remove(i);
                	}else{
                		i++;
                	}
                }
            	}
            }
        }
        super.getHttpSession().removeAttribute("perIdListsCommon");
        super.getHttpSession().setAttribute("perIdListsCommon",list);
		return "";
	}
	
	/*
	 * 确认
	 */
		public String makesure(){
			try{
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date date1 = df.parse(begindatevalueWdate+":00");
				Date date2 = df.parse(enddatevalueWdate+":00");
				float w=((float) (date2.getTime() - date1.getTime()))/(1000 * 60 * 60 * 24);
				w = (float) (Math.round(w * 100)) / 100;
				kqglLeaverDayValue=""+w;
			}catch(Exception e){
				e.printStackTrace();
			}
			return "";
		}
		
		public String save(){
			try{
			  List list=(List)super.getHttpSession().getAttribute("perIdListsCommon");
			  if(list!=null && list.size()>0){
				  for(int i=0;i<list.size();i++){
					    String id=(String)list.get(i);
					    AttOverTimeRecBO bo = new AttOverTimeRecBO();
		        		bo.setPersonID(id);
		        		bo.setApplyDate(CommonFuns.getSysDate("yyyy-MM-dd"));
		        		bo.setBeginTime(begindatevalueWdate);
		        		bo.setEndTime(enddatevalueWdate);
		        		bo.setLastDate(kqglLeaverDayValue);
		        		bo.setReason(reasonValue);
		        		bo.setStatusValue("3");
						bo.setTypeStatus(status);
						attenceSetUCC.saveAttOverTimeRecBO(bo);
						AttOverTimeRecBO attovertimerecbo= attenceSetUCC.findAttOverTimeRecBObyId(bo.getOverTimeNO());
						AttOverTimeLogBO attovertimelogbo=new AttOverTimeLogBO();
						attovertimelogbo.setPersonID(attovertimerecbo.getPersonID());
						attovertimelogbo.setApplyDate(attovertimerecbo.getApplyDate());
						attovertimelogbo.setBeginTime(attovertimerecbo.getBeginTime());
						attovertimelogbo.setEndTime(attovertimerecbo.getEndTime());
						attovertimelogbo.setLastDate(attovertimerecbo.getLastDate());
						attovertimelogbo.setTypeStatus(attovertimerecbo.getTypeStatus());
						attovertimelogbo.setProcess("0");
						attenceSetUCC.saveorupdateAttOverTimeLogBO(attovertimelogbo);
                        bo.setSuperFurloughNo(attovertimelogbo.getOverTimeLogNO());
                        attenceSetUCC.saveAttOverTimeRecBO(bo);
				  }
				    super.showMessageDetail("操作成功！");
			  }else{
					super.showMessageDetail("请选择人员！");
					return "";
			  }
			}catch(Exception e){
				e.printStackTrace();
			}
			return "";
		}
	
}
