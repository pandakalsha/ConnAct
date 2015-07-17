<%@page import="java.util.List"%>
<%@page import="org.hibernate.Query"%>
<%@page import="com.pro.Member"%>
<%@page import="com.pro.HibernateUtil"%>
<%@page import="org.hibernate.Session"%>

<%

    Session s = HibernateUtil.getSessionFactory().openSession();

    String team = request.getParameter("team");
    String email = request.getParameter("email");
    String pass = request.getParameter("pass");
    Integer mId;
    Query q = s.createQuery("from Member");
    List<Member> list = q.list();
    int mIde = 0;
    for (Member mem : list) {
        if (mem.getEmail().equals(email)) {
            mIde = mem.getMId();
            break;
        }
    }
    Member m;
    if (mIde == 0) {
        m = null;
    } else {
        m = (Member) s.load(Member.class, mIde);
    }
    System.out.print(m);
    if (m != null) {
        if (m.getTeam().getTeamName().equals(team)) {
            if (m.getPass().equals(pass)) {
                session.setAttribute("user", m.getMId());
                response.sendRedirect("window.jsp");
            } else {
                request.setAttribute("msg", "User Name or Password Invalid !");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("msg", "Invalid Team");
            request.getRequestDispatcher("index.jsp").forward(request, response);

        }
    } else {
        request.setAttribute("msg", "Invalid User !");
        request.getRequestDispatcher("index.jsp").forward(request, response);

    }
%>  
