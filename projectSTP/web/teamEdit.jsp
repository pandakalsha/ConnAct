<%@page import="java.util.Date"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="com.pro.Member"%>
<%@page import="com.pro.HibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%
    Session s = HibernateUtil.getSessionFactory().openSession();
    String team = request.getParameter("team");
    String desc = request.getParameter("desc");

    Integer id = Integer.parseInt(session.getAttribute("user").toString());
    Member m = (Member) s.get(Member.class,id);
    
    if(m.getPrivilige().equals("A"))
    {
        m.getTeam().setTeamName(team);
        m.getTeam().setTeamDescription(desc);
    }
    
    m.getTeam().setLastUpdate(new Date());
    
    Transaction t = s.beginTransaction();
    
    s.update(m);
    
    t.commit();
    
    response.sendRedirect("window.jsp");


%>
