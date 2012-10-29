package com.hr319wg.xys.eva.web;

import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.post.util.PostTool;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiDeptObjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiObjKeyBO;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;
import com.hr319wg.xys.eva.ucc.IXysKpiDeptUCC;

public class SelfDeptKpiGradeBackBean extends BaseBackingBean {
	 private IXysKpiDeptUCC xysKpiDeptUCC;
	    private IXysEvaPlanUCC xysEvaPlanUCC;
	    private String pageInit;
	    private List objList;
	    private String objId;
	    private boolean selectAll = false;


	    public boolean isSelectAll() {
	        return selectAll;
	    }

	    public void setSelectAll(boolean selectAll) {
	        this.selectAll = selectAll;
	    }

	    public void queryAll(ValueChangeEvent event) {
	        selectAll = "true".equals(event.getNewValue().toString());
	        doQuery();
	    }

	    public IXysKpiDeptUCC getXysKpiDeptUCC() {
	        return xysKpiDeptUCC;
	    }

	    public void setXysKpiDeptUCC(IXysKpiDeptUCC xysKpiDeptUCC) {
	        this.xysKpiDeptUCC = xysKpiDeptUCC;
	    }

	    public IXysEvaPlanUCC getXysEvaPlanUCC() {
	        return xysEvaPlanUCC;
	    }

	    public void setXysEvaPlanUCC(IXysEvaPlanUCC xysEvaPlanUCC) {
	        this.xysEvaPlanUCC = xysEvaPlanUCC;
	    }

	    public void doQuery() {
	        try {
	            if (selectAll) {
	                objList = xysKpiDeptUCC.getXysKpiDeptObjBOInSelf(super.getUserInfo().getUserId(), null);
	            } else {
	                String where = " and bo.planId in(select vo.planId from XysEvaPlanBO vo " +
	                        "where vo.status='"+XysEvaPlanBO.STATUS_ZHIXING+"' and vo.deptKpiStatus!='1')";
	                objList = xysKpiDeptUCC.getXysKpiDeptObjBOInSelf(super.getUserInfo().getUserId(), where);
	            }
	            if (objList != null && objList.size() > 0) {
	                for (int i = 0; i < objList.size(); i++) {
	                    XysKpiDeptObjBO obj = (XysKpiDeptObjBO) objList.get(i);
	                    XysEvaPlanBO plan = xysEvaPlanUCC.findXysEvaPlanBOById(obj.getPlanId());
	                    PersonBO pbo = SysCacheTool.findPersonById(obj.getPersonId());
	                    obj.setPlanName(CommonFuns.filterNull(plan.getPlanName()));
	                    obj.setYear(CommonFuns.filterNull(plan.getYear()));
	                    obj.setPersonName(pbo.getName());
	                    obj.setDeptName(SysCacheTool.findOrgById(obj.getDeptId()).getName());
	                    obj.setPostName(PostTool.getPostName(pbo.getPostId()));
	                    if(plan.getStatus()!=null&&plan.getStatus().equals(XysEvaPlanBO.STATUS_ZHIXING)){
	                    	if(plan.getDeptKpiStatus()!=null&&!plan.getDeptKpiStatus().equals("")){
	                    		if(plan.getDeptKpiStatus().equals("2")){
	                    			obj.setSelfGrade("1");
	                    		}else{
	                    			obj.setSelfGrade("2");
	                    		}
	                    	}else{
	                    		obj.setSelfGrade("1");
	                    	}
	                    }else{
	                    	obj.setSelfGrade("2");
	                    }
	                    objList.set(i, obj);
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


	    public List getObjList() {
	        return objList;
	    }

	    public void setObjList(List objList) {
	        this.objList = objList;
	    }

	    public String getObjId() {
	        return objId;
	    }

	    public void setObjId(String objId) {
	        this.objId = objId;
	    }

	    // ���
	 	private String initInput;

		public String saveScore() {
	 		try {
	 			List keyList = xysKpiDeptUCC.getXysKpiObjKeyBOByObjId(objId);
	 			if (keyList != null && keyList.size() > 0) {
	 				for (int i = 0; i < keyList.size(); i++) {
	 					XysKpiObjKeyBO key = (XysKpiObjKeyBO) keyList.get(i);
	 					String score = super.getRequestParameter(key.getObjKeyId());
	 					String execlution=super.getRequestParameter(key.getObjKeyId()+"_execution");
	 					key.setExecution(execlution);
	 					key.setSelfGrade(score);
	 					xysKpiDeptUCC.saveXysKpiObjKeyBO(key);
	 				}
	 			}
	 		} catch (Exception e) {
	 			e.printStackTrace();
	 		}
	 		return "success";
	 	}

	 	public String getInitInput() {
	 		try {
	 			if (super.getRequestParameter("objId") != null) {
	 				objId = super.getRequestParameter("objId");
	 				super.getHttpSession().setAttribute("objId", objId);
	 			}
	 		} catch (Exception e) {
	 			e.printStackTrace();
	 		}
	 		return initInput;
	 	}

	 	public void setInitInput(String initInput) {
	 		this.initInput = initInput;
	 	}

}
