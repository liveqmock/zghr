package com.hr319wg.xys.eva.web;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.eva.pojo.bo.EvaGradeBO;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;

import javax.faces.event.ValueChangeEvent;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-11
 * Time: 上午9:22
 * To change this template use File | Settings | File Templates.
 */
public class XysPlanKeySetBackBean extends BaseBackingBean{
    //查看计划
    private IXysEvaPlanUCC xysEvaPlanUCC;
    private String pageInit;
    private PageVO mypage = new PageVO();
    private List planList;
    private IEvaGradeUCC evaGradeUCC;
    private String planId;
    private boolean selectAll = false;

    public void queryAll(ValueChangeEvent event) {
        selectAll = "true".equals(event.getNewValue().toString());
        doQuery();
    }
    public boolean isSelectAll() {
        return selectAll;
    }

    public void setSelectAll(boolean selectAll) {
        this.selectAll = selectAll;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
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
            if(mypage.getCurrentPage()==0){
               mypage.setCurrentPage(1);
            }
            if(selectAll){
                planList = xysEvaPlanUCC.getXysEvaPlanBO(mypage,super.getUserInfo().getOrgId(),null);
            }else{
                planList = xysEvaPlanUCC.getXysEvaPlanBO(mypage,super.getUserInfo().getOrgId(),new String[]{XysEvaPlanBO.STATUS_ZBGJ,XysEvaPlanBO.STATUS_ZHIXING});
            }
            if(planList!=null&&planList.size()>0){
                for(int i=0;i<planList.size();i++){
                    XysEvaPlanBO bo=(XysEvaPlanBO)planList.get(i);
                    EvaGradeBO grade=evaGradeUCC.getGradeByID(bo.getPlanGrade());
                    bo.setPlanGrade(grade.getGradeName());
                    bo.setPlanType(CodeUtil.interpertCode(bo.getPlanType()));
                    planList.set(i,bo);
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

    public PageVO getMypage() {
        return mypage;
    }

    public void setMypage(PageVO mypage) {
        this.mypage = mypage;
    }

    public List getPlanList() {
        return planList;
    }

    public void setPlanList(List planList) {
        this.planList = planList;
    }

    public IEvaGradeUCC getEvaGradeUCC() {
        return evaGradeUCC;
    }

    public void setEvaGradeUCC(IEvaGradeUCC evaGradeUCC) {
        this.evaGradeUCC = evaGradeUCC;
    }

    public IXysEvaPlanUCC getXysEvaPlanUCC() {
        return xysEvaPlanUCC;
    }

    public void setXysEvaPlanUCC(IXysEvaPlanUCC xysEvaPlanUCC) {
        this.xysEvaPlanUCC = xysEvaPlanUCC;
    }
}
