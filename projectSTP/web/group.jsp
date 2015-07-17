<%@page import="org.hibernate.Session"%>
<%@page import="com.pro.HibernateUtil"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="java.util.Date"%>
<%@page import="com.pro.Group"%>
<%
    Session s = HibernateUtil.getSessionFactory().openSession();
    String grp_name = request.getParameter("gr_name");
    String members = request.getParameter("members");
    
    Group g = new Group();
    
    g.setGroupName(grp_name);
    g.setMembers(members);
    g.setLastUpdate(new Date());
    
    Transaction t = s.beginTransaction();
    
    s.save(g);
    
    t.commit();
    
    response.sendRedirect("window.jsp");
    

%>