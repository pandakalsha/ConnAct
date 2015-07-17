<%@page import="com.pro.Member"%>
<%@page import="com.pro.HibernateUtil"%>
<%@page import="org.hibernate.cache.ehcache.internal.util.HibernateEhcacheUtils"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="com.pro.Team"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
    Session s = HibernateUtil.getSessionFactory().openSession();
    String team = request.getParameter("team");
    String desc = request.getParameter("desc");
    String email = request.getParameter("email");
    String pass = request.getParameter("pass");
    String username = request.getParameter("username");

    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-mm-dd");

    Date dob = formatter.parse(request.getParameter("dob"));

    Team t = new Team();
    Member m = new Member();

    t.setTeamName(team);
    t.setTeamDescription(desc);
    t.setLastUpdate(new Date());

    Transaction tr = s.beginTransaction();

    s.save(t);


    m.setTeam(t);
    m.setPass(pass);
    m.setDob(dob);
    m.setEmail(email);
    m.setPrivilige("A");
    m.setUsername(username);


    s.save(m);

    tr.commit();

    response.sendRedirect("index.jsp");


%>
