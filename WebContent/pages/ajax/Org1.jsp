<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.sys.api.UserAPI" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.TreeMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.hr319wg.emp.ucc.teamManagerUcc" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.emp.pojo.bo.EmpTeamInfoBo" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");                           // 上级
    String rightFlag = CommonFuns.filterNull(request.getParameter("rightFlag"));     // 权限方式  //   0-不使用 1-使用查询权限过滤,2-使用维护权限过滤
    String rootId = CommonFuns.filterNull(request.getParameter("rootId"));           // 根节点
    String cancelFlag = CommonFuns.filterNull(request.getParameter("cancelFlag"));   // 是否显示撤销机构
    String showGroup = CommonFuns.filterNull(request.getParameter("showGroup"));    //   是否显示班组
    String onlyOrg = CommonFuns.filterNull(request.getParameter("onlyOrg"));          //  只显示机构
    String showTeam = CommonFuns.filterNull(request.getParameter("showTeam"));          // 显示团队
    String secDeptTreeId = CommonFuns.filterNull(request.getParameter("secDeptTreeId"));          // 二级部门树id
    ArrayList list = null;

    User user = (User) (session.getAttribute(Constants.USER_INFO));
    teamManagerUcc teamucc = (teamManagerUcc) SysContext.getBean("teamucc");

    if (!"".equals(rootId) && !"undefined".equals(rootId) && !"null".equals(rootId)) {
        if ("-1".equals(superId)) {   // 如果指定了首层机构
            String[] ids = rootId.split(",");
            if (ids != null && ids.length > 0) {
                list = new ArrayList();
                for (int i = 0; i < ids.length; i++) {
                    OrgBO o = SysCacheTool.findOrgById(ids[i]);
                    if (o != null) list.add(o);
                }
            }
        } else {
            list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, superId);// 全部
        }
    } else if ("1".equals(rightFlag)) { //查询范围
        try {
            UserAPI api = (UserAPI) SysContext.getBean("user_pmsAPI");
            if ("-1".equals(superId)) {
                OrgBO[] os = (OrgBO[]) api.getTreeRoot("0", (User) session.getAttribute(Constants.USER_INFO));
                if (os != null && os.length > 0) {
                    list = new ArrayList();
                    for (int i = 0; i < os.length; i++) {
                        list.add(SysCacheTool.findOrgById(os[i].getOrgId()));
                    }
                }
            } else {
                list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, superId);
                //过滤排除机构
                for (int i = 0; i < list.size(); i++) {
                    OrgBO o = (OrgBO) list.get(i);
                    if (api.checkOrgTreeId((User) session.getAttribute(Constants.USER_INFO), o, "0") == 1) {
                        list.remove(i);
                        i--;
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("PmsApi:" + e);
        }
    } else if ("2".equals(rightFlag)) { //维护范围
        try {
            UserAPI api = (UserAPI) SysContext.getBean("user_pmsAPI");
            if ("-1".equals(superId)) {
                OrgBO[] os = (OrgBO[]) api.getOptTreeRoot("0", (User) session.getAttribute(Constants.USER_INFO));
                if (os != null && os.length > 0) {
                    list = new ArrayList();
                    for (int i = 0; i < os.length; i++)
                        list.add(os[i]);
                }
            } else {
                list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, superId);
                //过滤排除机构
                for (int i = 0; i < list.size(); i++) {
                    OrgBO o = (OrgBO) list.get(i);
                    if (api.checkOrgTreeId((User) session.getAttribute(Constants.USER_INFO), o, "1") == 1) {
                        list.remove(i);
                        i--;
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("PmsAPI异常:" + e);
        }
    } else {
        list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, superId);
    }

    if ("-1".equals(superId)) {
        if (list != null && list.size() > 1) {
            TreeMap tree = new TreeMap();
            for (int i = 0; i < list.size(); i++) {
                OrgBO org = (OrgBO) list.get(i);
                tree.put(org.getTreeId(), org);
            }
            Iterator it = tree.values().iterator();
            if (it.hasNext()) {
                OrgBO prevOrg = (OrgBO) it.next();
                while (it.hasNext()) {
                    OrgBO posOrg = (OrgBO) it.next();
                    if (posOrg.getTreeId().startsWith(prevOrg.getTreeId())) {
                        it.remove();
                    } else {
                        prevOrg = posOrg;
                    }
                }
            }
            if (tree.size() != 0) {
                list = new ArrayList(tree.values());
            }
        }
    }

    OrgBO org = SysCacheTool.findOrgById(superId);
    String icon = "";
    String childnum = "";
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");

    // 返回结果
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
            OrgBO o = (OrgBO) list.get(i);
            if(o.getTreeId().length()>6 && secDeptTreeId!=null && !"".equals(secDeptTreeId) && !"null".equals(secDeptTreeId) && !o.getTreeId().startsWith(secDeptTreeId)){
				continue;
			}
            if (!"1".equals(cancelFlag) && Constants.YES.equals(o.getOrgCancel()))//如果cancelFlag 为空或undefined则过滤掉"已撤消结构(即org.orgCancel = yes);如果给值且值为1,则显示全部机构
                continue;
            if (!"1".equals(showGroup) && OrgBO.GROUPTYPE.equals(o.getorgType())) {  // 过滤掉班组
                continue;
            }
            if ("1".equals(onlyOrg) && !OrgBO.UNITTYPE.equals(o.getorgType()) && !OrgBO.VIRTUALTYPE.equals(o.getorgType())) {      // 过滤部门
                continue;
            }
            childnum = "0";
            out.println("<org>");

            //判断下级是否有节点,并且如果不显示撤消机构 则判下级是否都是撤消机构
            if (o != null) {
                ArrayList list1 = SysCacheTool.querySubObject(SysCache.OBJ_ORG, null, o.getOrgId()); // 取得所有下级
                if (list1 != null && list1.size() > 0) {
                    try {
                        for (int j = 0; j < list1.size(); j++) {
                            OrgBO o1 = (OrgBO) list1.get(j);
                            if (!"1".equals(showGroup) && OrgBO.GROUPTYPE.equals(o1.getorgType())) continue;   // 过滤掉班组
                            if ("1".equals(onlyOrg) && !OrgBO.UNITTYPE.equals(o1.getorgType()) && !OrgBO.VIRTUALTYPE.equals(o1.getorgType())) {      // 过滤部门
                                continue;
                            }
                            if ( !"0".equals(rightFlag)){
                                if (user.isBusinessUser() || user.isSysOper()) {    // 业务用户需检查权限
                                    // 没有权限
                                    UserAPI api = (UserAPI) SysContext.getBean("user_pmsAPI");
                                    if (api.checkOrgTreeId((User) session.getAttribute(Constants.USER_INFO), o1, "1") == 1)
                                        continue;
                                }
                            }

                            if ("1".equals(cancelFlag)) {
                                childnum = "1";
                                break;
                            } else if (!Constants.YES.equals(o1.getOrgCancel())) {
                                childnum = "1";
                                break;
                            }
                        }
                    }
                    catch (Exception e) {

                    }
                }
                if ("1".equals(showTeam)) { // 显示团队
                    List teamlist = teamucc.getAllEmpTeamInfoBo(o.getOrgId());
                    if (teamlist!=null && teamlist.size()>0) {
                        childnum = "1";
                    }
                }
                String cancel = o.getOrgCancel();
                if (cancel == null || cancel.equals("")) {
                    cancel = "0";
                } else if (Constants.YES.equals(cancel)) {
                    cancel = "1";
                } else {
                    cancel = "0";
                }
                if (OrgBO.UNITTYPE.equals(o.getorgType())) {
                    icon = "org";
                } else if (OrgBO.DEPTTYPE.equals(o.getorgType())) {
                    icon = "dept";
                } else if (OrgBO.GROUPTYPE.equals(o.getorgType())) {
                    icon = "group";
                } else if (OrgBO.VIRTUALTYPE.equals(o.getorgType())) {
                    icon = "virtual";
                } else {
                    icon = "folder";
                }
                out.println("<key>" + o.getTreeId() + "</key>");
                out.println("<name>" + o.getName() + "</name>");
                out.println("<id>" + o.getOrgId() + "</id>");
                out.println("<cancel>" + cancel + "</cancel>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + childnum + "</childnum>");
            }
            out.println("</org>");
        }
        if ("1".equals(showTeam)) { // 显示团队
            List teamlist = teamucc.getAllEmpTeamInfoBo(superId);
            if (teamlist != null) {
                for (int j = 0; j < teamlist.size(); j++) {
                    EmpTeamInfoBo em=(EmpTeamInfoBo)teamlist.get(j);
                    out.println("<org>");
                    out.println("<key>" + em.getTeamId() + "</key>");
                    out.println("<name>" + em.getTeamName() + "</name>");
                    out.println("<id>" + em.getTeamId() + "</id>");
                    out.println("<cancel>0</cancel>");
                    out.println("<icon>group</icon>");
                    out.println("<childnum>0</childnum>");
                    out.println("</org>");
                }
            }
        }
    }

    if (org != null) {
        out.println("<supertree>");
        out.println("<treeid>" + org.getTreeId() + "</treeid>");
        out.println("</supertree>");
    }

    out.println("</tree>");
%>