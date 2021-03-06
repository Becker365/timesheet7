<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.timesheet.bean.Employee" %>
<%@page import="com.timesheet.bean.Project" %>
<%@page import="com.timesheet.bean.AssignBy" %>
<%@page import="com.timesheet.bean.EmpTransaction" %>
<%
            java.util.ArrayList<AssignBy> assignbyList = new java.util.ArrayList<AssignBy>();
            java.util.ArrayList<Employee> proxyEmpList = new java.util.ArrayList<Employee>();
            java.util.ArrayList<Project> projectList = new java.util.ArrayList<Project>();

            assignbyList = (java.util.ArrayList) request.getSession().getAttribute("assign_by_list");
            proxyEmpList = (java.util.ArrayList) request.getSession().getAttribute("proxy_emp_list");
            projectList = (java.util.ArrayList) request.getSession().getAttribute("project_list");
            Object o = request.getSession().getAttribute("time_right");
            String time_right = o.toString();
%>
<% EmpTransaction et = (EmpTransaction) session.getAttribute("trans_list");%>
<% int assignby_id = et.getAssign_by_id();%>
<% System.out.println("assignby_id in jsp: " + assignby_id);%>
<c:set var="assign_by" value="<%=et.getAssign_by_id() %>"/>
<c:set var="proxy_name" value="<%=et.getProxy_empid() %>"/>
<c:set var="proj_name" value="<%=et.getProj_id() %>" />
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <script type='text/javascript' src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script type='text/javascript' src="${pageContext.request.contextPath}/js/jRounded.js"></script>
        <link rel="stylesheet" href="default.css" type="text/css" />
        <script>

            $(document).ready(function() {
                $('.boxMe').box();
                $('.oxMe').box();
                $('.otherOne, .anotherOne').box();
            });
            function loginfocus()
            {
                document.updatetimesheet.start_time.focus();
            }
            function isNumberKey(evt){

                var charCode = (evt.which) ? evt.which : event.keyCode
                if (charCode > 31  && charCode!=99 && charCode!=118 && (charCode < 48 || charCode > 58))
                    return false;
                else
                    return true;

            }
        </script>
        <style>
            .error{
                color:#ff0000;
                font-style:normal;
            }
        </style>

    </head>
    <body onload="loginfocus()">
        <div class="anotherOne">
            <center><font face="arial" style="font-size:16px;font-weight:bold;" color="#FFFFFF">Update TimeSheet</font></center>
        </div>
        <form:form name="updatetimesheet" commandName="updatetimesheet">
            <div class="anotherOne bg-white" style="padding-left:15px;height:277px;" >
                <div align="right" style="color:red">  Fields marked with  * are mandatory  </div>
                <input type="hidden" name="trans_date" value="<%=et.getTrans_date() %>" />
                <input type="hidden" name="isLate" value="<%=et.getIsLate()%>"/>
                <table>
                    <tr>
                        <td>
                            <input type="hidden" name="emp_id" value="<%=et.getEmp_id() %>"/>
                        </td>
                       
                       
                    </tr>
                    <c:set var="timer" value="${time_right}"/>
                    <c:if test="${timer eq 'T'}">
                        <tr>
                            <td>Start Time<span style="color:red">* </span></td>
                            <td>
                                <input style="border:1px solid #520000;" type="text" name="start_time" id="start_time" maxlength="8" value="<%=request.getParameter("start_time")==null? et.getStart_time() : request.getParameter("start_time") %>"  onkeypress="return isNumberKey(event)" />
                                (HH:MM)/(24 Hour Format)
                            </td>
                           
                             <td> <form:errors path="start_time" cssClass="error" /> </td>
                        </tr>

                        <tr>
                            <td>End Time<span style="color:red">* </span></td>
                            <td>
                                <input type="text" style="border:1px solid #520000;" name="end_time" id="end_time" maxlength="8" value="<%=request.getParameter("end_time")==null? et.getEnd_time() : request.getParameter("end_time") %>" onkeypress="return isNumberKey(event)"/>
                            (HH:MM)/(24 Hour Format)
                            </td>
                             <td> <form:errors path="end_time" cssClass="error" /> </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td>AssignBy Name<span style="color:red">* </span></td>
                        <td>

                            <select style="border:1px solid #520000"  name="assign_by_id">
                                <option value="0">--Select--</option>
                                <% for (int i = 0; i < assignbyList.size(); i++) {
                AssignBy ab = (AssignBy) assignbyList.get(i);
                                %>
                                <option value="<%=ab.getAssign_by_id()%>"<c:set var="assign" value="<%=ab.getAssign_by_id() %>"/> <c:if test="${assign eq assign_by}"> selected </c:if>><%=ab.getAssign_by_name()%></option>
                                <%}%>
                            </select>
                        </td>
                        <td> <form:errors path="assign_by_id" cssClass="error" /> </td>
                    </tr>
                    <tr>
                        <td>Proxy Employee Name</td>
                        <td>
                            <select style="border:1px solid #520000" name="proxy_empid">
                                <option value="0">--Select--</option>
                                <% for (int i = 1; i < proxyEmpList.size(); i++) {
                Employee emp = (Employee) proxyEmpList.get(i);

                                %>
                                <c:set var="roll" value="<%=emp.getRole_id()%>"/>
                                <c:set var="rollid" value="2"/>
                                <c:set value="<%= emp.getEmp_fname()%>" var="name"/>

                                <c:if test="${roll eq rollid}">
                                    <option value="<%=emp.getEmp_id()%>" <c:set var="proxyempname" value="<%=emp.getEmp_id()%>"/>  <c:if test="${proxyempname eq proxy_name}"> selected </c:if> > <c:out value="${name}"/> </option>
                                </c:if>
                                <%}%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Project Name<span style="color:red">* </span></td>
                        <td>
                            <select style="border:1px solid #520000" name="proj_id" >
                                <option value="0">--Select--</option>
                                <% for (int i = 0; i < projectList.size(); i++) {
                Project proj = (Project) projectList.get(i);
                                %>
                                <option value="<%=proj.getProj_id()%>"<c:set var="proj" value="<%=proj.getProj_id() %>"/> <c:if test="${proj eq proj_name}"> selected </c:if>><%=proj.getProj_name()%></option>
                                <%}%>
                            </select>
                        </td>
                        <td><form:errors path="proj_id" cssClass="error" /> </td>
                    </tr>
                    <tr>
                        <td>Work Description<span style="color:red">* </span></td>
                        <td>
                            <textarea wrap="virtual" style="border:1px solid #520000;" cols="30" rows="5" name="work_desc"><%= request.getParameter("work_desc") == null ? et.getWork_desc() : request.getParameter("work_desc")%></textarea>
                        </td>
                        <td> <form:errors path="work_desc" cssClass="error" /> </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input class="button" type="submit" value="Save">
                            <input class="button" type="button" value="Cancel" onclick="javascript:history.go(-1);">
                            <input class="button" type="reset" value="Reset">
                        </td>
                    </tr>
                </table>
            </div>
        </form:form>
    </body>
</html>
