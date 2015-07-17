
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Query"%>
<%@page import="com.pro.HibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page import="com.pro.Member"%>
<%
    Session s = HibernateUtil.getSessionFactory().openSession();
    String team = request.getParameter("team");
    String email = request.getParameter("email");

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
            if (m.getEmail().equals(email)) {
                session.setAttribute("user",mIde);
                response.sendRedirect("signup.jsp");
            } else {
                request.setAttribute("msg", "User Name or Password Invalid !");
                request.getRequestDispatcher("accCheck.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("msg", "Invalid Team");
            request.getRequestDispatcher("accCheck.jsp").forward(request, response);

        }
    } else {
        request.setAttribute("msg", "Invalid User ! Check with your Team Admin !");
        request.getRequestDispatcher("index.jsp").forward(request, response);

    }

%>