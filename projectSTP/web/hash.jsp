<%@page import="org.hibernate.Transaction"%>
<%@page import="java.util.Date"%>
<%@page import="com.pro.Hashtag"%>
<%@page import="com.pro.HibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page import="com.pro.Member"%>
<%
    Session s = HibernateUtil.getSessionFactory().openSession();
    
    String header = request.getParameter("header");
    String desc = request.getParameter("desc");
    String members = request.getParameter("members");
    
    Integer creator = (Integer) session.getAttribute("user");
    
    Member m = (Member) s.get(Member.class, creator);
    
    Hashtag hashtag = new Hashtag();
    
    hashtag.setTag(header);
    hashtag.setDescription(desc);
    hashtag.setMember(m);
    hashtag.setMembers(members);
    hashtag.setLastUpdate(new Date());
    
    Transaction t = s.beginTransaction();
    
    s.save(hashtag);
    
    t.commit();
    
    response.sendRedirect("window.jsp");
    

%>