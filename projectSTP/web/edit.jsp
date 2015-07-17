<%@page import="org.hibernate.Transaction"%>
<%@page import="com.pro.Member"%>
<%@page import="com.pro.Hashtag"%>
<%@page import="java.util.List"%>
<%@page import="com.pro.Group"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Session"%>
<%@page import="com.pro.HibernateUtil"%>
<%
    Session s = HibernateUtil.getSessionFactory().openSession();
    String username = request.getParameter("username");
    Integer id = Integer.parseInt(session.getAttribute("user").toString());
    Query q = s.createQuery("from Group");

    List<Group> listG = q.list();

    q = s.createQuery("from Hashtag");
    Member m = (Member) s.get(Member.class, id);
    List<Hashtag> listH = q.list();

    for (Group g : listG) {
        String st[] = g.getMembers().split(",");
        String str = "";
        for (String ct : st) {
            if (ct.equals(m.getUsername())) {
                str += "," + username;
            } else {
                str += "," + ct;
            }
        }

        str = str.substring(1);
        g.setMembers(str);
    }

    for (Hashtag h : listH) {
        String st[] = h.getMembers().split(",");
        String str = "";
        for (String ct : st) {
            if (ct.equals(m.getUsername())) {
                str += "," + username;
            } else {
                str += "," + ct;
            }
        }

        str = str.substring(1);
        h.setMembers(str);
    }

    m.setUsername(username);

    Transaction t = s.beginTransaction();

    s.update(m);

    t.commit();

    response.sendRedirect("window.jsp");


%>