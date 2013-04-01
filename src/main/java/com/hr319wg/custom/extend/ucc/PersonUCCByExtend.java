package com.hr319wg.custom.extend.ucc;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.emp.ucc.impl.PersonUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CommonFuns;

public class PersonUCCByExtend extends PersonUCC {

	@Override
	public String queryInsChangePersonList(TableVO table, String name, String superId, int pageNum, int rowNum, User user) throws SysException {
		StringBuffer where = new StringBuffer();
	    if ((superId != null) && (!"".equals(superId))) {
	      where.append(" and B731.orguid ='").append(superId).append("'");
	    }

	    ArrayList liitems = SysCacheTool.queryInfoItemBySetId("B731");
	    for (int i = 0; i < liitems.size(); i++) {
	      InfoItemBO ib = (InfoItemBO)liitems.get(i);
	      if (ib.getItemId().toLowerCase().equals("orguid")) {
	        InfoItemBO ia = SysCacheTool.findInfoItem("A001", "ID");
	        liitems.set(i, ia);
	      }
	    }
	    CellVO[] c1 = new CellVO[liitems.size()];
	    for (int i = 0; i < liitems.size(); i++) {
	      c1[i] = new CellVO();
	      CommonFuns.copyProperties(c1[i], liitems.get(i));
	    }
	    table.setHeader(c1);
	    table.setSetType("A");
	    StringBuffer sql = new StringBuffer("");
	    sql.append("select ");
	    for (int i = 0; i < liitems.size(); i++) {
	      InfoItemBO b = (InfoItemBO)liitems.get(i);
	      sql.append(b.getItemId());
	      if (i == liitems.size() - 1) continue; sql.append(",");
	    }
	    sql.append(" from B731 left join A001 on B731.B731700=A001.ID");
	    OrgBO org = SysCacheTool.findOrgById(superId);
	    if(org!=null && !"-1".equals(org.getSuperId())){
	    	sql.append(" where B731.orguid ='").append(superId).append("'");	    	
	    }
	    if ((name != null) && (!name.equals(""))) {
	      sql.append(" and ( A001.A001001 like '%").append(name).append("%' or A001.A001735 like '%").append(name).append("%' or A001.A001002 like '%").append(name.toLowerCase()).append("%')");
	    }
	    sql.append(" order by B731.B731701 desc");
	    getActivepageservice().querySql(table, sql.toString(), user, pageNum, rowNum, true);
	    return sql.toString();
	}
	
	public String queryPersonList(TableVO table, String name, String perType, String superId, int pageNum, int rowNum, String cancel, User user, String qryID, String addConditon) throws SysException {
	    try {
	      StringBuffer where = new StringBuffer();

	      name = CommonFuns.filterNull(name).trim();
	      if ((name != null) && (!"".equals(name.trim()))) {
	        String namecon = "1=0";
	        String[] namestr = name.split(",");
	        for (int i = 0; i < namestr.length; i++) {
	          if (!"".equals(namestr[i])) {
	            namecon = namecon + " or A001.A001001 LIKE '%" + namestr[i] + "%' or A001.A001735 like '%" + namestr[i] + "%' or A001002 like '%" + namestr[i] + "%' or A001999 like '%" + namestr[i] + "%'";
	          }
	        }
	        namecon = " and (" + namecon + ")";
	        where.append(namecon);
	      }
	      if ((perType != null) && (!"".equals(perType.trim()))) {
	        String[] pers = perType.split(",");
	        where.append(" and ").append(CommonFuns.splitInSql(pers, "A001.A001054"));
	      }

	      if ((superId != null) && (!"".equals(superId.trim()))) {
	        OrgBO bo = SysCacheTool.findOrgById(superId);
	        if (bo != null) {
	          if (OrgBO.GROUPTYPE.equals(bo.getorgType())) {
	            where.append(" and A001.A001706='" + bo.getOrgId() + "'");
	          }
	          else {
	            where.append(" and A001.A001738 LIKE '" + bo.getTreeId() + "%'");
	          }
	        }
	      }

	      String addCondition = "";
	      if (!"".equals(cancel)) {
	        addCondition = "A001730 = '" + cancel + "'";
	      }
	      if ((qryID == null) || ("".equals(qryID))) {
	        qryID = "156";
	      }
	      CellVO[] c1 = this.getQueryapi().queryInfoItem(qryID);

	      table.setHeader(c1);
	      table.setSetType("A");
	      Hashtable hash = this.getQueryapi().getQuerySqlHash(user, qryID, addCondition);
	      String select = CommonFuns.filterNull((String)hash.get("SQL_SELECT_PART"));
	      String from = CommonFuns.filterNull((String)hash.get("SQL_FROM_PART"));
	      String condition = CommonFuns.filterNull((String)hash.get("SQL_WHERE_PART"));
	      String scale = CommonFuns.filterNull((String)hash.get("SQL_SCALE_PART"));
	      String order = CommonFuns.filterNull((String)hash.get("SQL_ORDER_PART"));
	      StringBuffer sql = new StringBuffer();
	      if ((!"".equals(select)) && (!"".equals(from))) {
	        sql.append("SELECT ").append(select).append(" FROM ").append(from);
	        if ((!"".equals(condition)) || (!"".equals(scale)) || ((where != null) && (where.length() > 0))) {
	          sql.append(" WHERE 1=1 ");
	        }
	        if (!"".equals(condition)) {
	          sql.append(" and ").append(condition);
	        }
	        if (!"".equals(scale)) {
	          sql.append(" and ").append(scale);
	        }
	        if ((where != null) && (where.length() > 0)) {
	          sql.append(where);
	        }
	        if ((addConditon != null) && (!"".equals(addConditon))) {
	          sql.append(" and ").append(addConditon);
	        }
	        
	        if (!"".equals(order))
	          sql.append(" order by A001.A001746,").append(order);
	        else {
	          sql.append(" order by A001.A001746");
	        }
	      }
	      this.getActivepageservice().querySql(table, sql.toString(), user, pageNum, rowNum, true);
	      return sql.toString(); 
	      } catch (Exception e) {
			throw new SysException("", "��ѯʧ��", e, getClass());
	    }
	  }
}
