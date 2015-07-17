<%@page import="java.util.Date"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="com.pro.Member"%>
<%@page import="com.pro.Hashtag"%>
<%@page import="com.pro.HibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page import="com.pro.Group"%>
<%@page import="com.pro.Posts"%>
<%
    Session s = HibernateUtil.getSessionFactory().openSession();

    String post = request.getParameter("post");

    Integer ghId = Integer.parseInt(session.getAttribute("ghId").toString());
    String type = session.getAttribute("type").toString();

    Posts p = new Posts();
    Member m = (Member) s.get(Member.class, (Integer) session.getAttribute("user"));

    p.setPostDescription(post);

    if (type.equals("H")) {
        Hashtag h = (Hashtag) s.get(Hashtag.class, ghId);
        p.setHashtag(h);
        p.setType("H");
    }
    else if(type.equals("G"))
    {
        Group g = (Group)s.get(Group.class,ghId);
        p.setGroup(g);
        p.setType("G");
        
    }
    p.setLastUpdate(new Date());

    p.setMember(m);

    Transaction t = s.beginTransaction();

    s.save(p);

    t.commit();

    response.sendRedirect("window.jsp");


%>
