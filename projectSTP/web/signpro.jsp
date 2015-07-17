<%@page import="org.hibernate.Transaction"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.pro.HibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page import="com.pro.Member"%>
<%
    Session s = HibernateUtil.getSessionFactory().openSession();
    Integer id = (Integer) session.getAttribute("user");
    Member m = (Member) s.get(Member.class, id);

    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");

    String username = request.getParameter("username");
    Date dob = formatter.parse(request.getParameter("dob"));
    String pass = request.getParameter("pass");

    m.setUsername(username);
    m.setDob(dob);
    m.setPass(pass);
    m.setPrivilige("U");

    Transaction t = s.beginTransaction();

    s.update(m);

    t.commit();
    
    request.getRequestDispatcher("window.jsp").forward(request, response);

%>