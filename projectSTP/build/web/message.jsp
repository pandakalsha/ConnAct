<%@page import="java.util.Date"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="com.pro.Messages"%>
<%@page import="java.util.List"%>
<%@page import="com.pro.Member"%>
<%@page import="com.pro.HibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.Query"%>
<%
    Session s = HibernateUtil.getSessionFactory().openSession();
    
    Integer sender_id = (Integer) session.getAttribute("user");
    Integer receiver_id = 0;
    String message = "Subject : " + request.getParameter("subject") + "\n" + request.getParameter("mbody");
    String username = request.getParameter("username");
    
    Query q = s.createQuery("from Member");
    List<Member> list = q.list();
    
    for (Member m : list) {
        if (m.getUsername().equals(username)) {
            receiver_id = m.getMId();
        }
    }
    
    out.print(receiver_id);
    Member mem = (Member) s.get(Member.class, sender_id);
    
    Messages messages = new Messages();
    
    messages.setMemberBySenderId(mem);
    
    mem = (Member) s.get(Member.class, receiver_id);
    
    messages.setMemberByReceiverId(mem);
    
    messages.setBody(message);
    messages.setLastUpdate(new Date());
    
    Transaction t = s.beginTransaction();
    
    s.save(messages);
    
    t.commit();
    
    response.setHeader("status", "sent");
    //request.setAttribute("status","sent");
    response.sendRedirect("window.jsp");
    
%>