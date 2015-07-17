<%@page import="com.pro.Posts"%>
<%@page import="java.util.Date"%>
<%@page import="com.pro.Group"%>
<%@page import="com.pro.Hashtag"%>
<%@page import="java.util.List"%>
<%@page import="com.pro.Messages"%>
<%@page import="org.hibernate.Query"%>
<%@page import="com.pro.Member"%>
<%@page import="java.lang.Integer"%>
<%@page import="com.pro.HibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <link id="favicon" rel="shortcut icon" href="img/CaptureWebnew.png" sizes="16x16 32x32 48x48" type="image/png" />

        <title>ConnAct - Connecting Teams</title>

        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="css/simple-sidebar.css" rel="stylesheet">
        <link href="css/style-new.css" rel="stylesheet">
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

    </head>

    <body>
        <%
            Session s = HibernateUtil.getSessionFactory().openSession();
            //int mid = Integer.parseInt(session.getAttribute("user").toString());
            Integer id = (Integer) session.getAttribute("user");
            Member m = (Member) s.get(Member.class, id);

            String ghId = request.getParameter("ghId");
            String type = request.getParameter("type");

            if (type == null && session.getAttribute("type") != null) {
                ghId = session.getAttribute("ghId").toString();
                type = session.getAttribute("type").toString();

            } else {
                session.setAttribute("ghId", ghId);
                session.setAttribute("type", type);
            }

            int mail = 0;

            Query q = s.createQuery("from Messages");
            List<Messages> list = q.list();

            for (Messages ma : list) {
                if (ma.getMemberByReceiverId().getMId() == id) {
                    mail++;
                }

            }


        %>


        <div id="wrapper">
            <!-- Sidebar -->
            <div id="sidebar-wrapper">
                <ul class="sidebar-nav">
                    <li class="sidebar-brand">
                        <a href="#">
                            ConnAct
                        </a>
                    </li>
                    <li>
                        <a href="#">Dashboard</a>
                    </li>

                    <li>
                        <a href="#">
                            Discussions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                            <b class="glyphicon glyphicon-plus-sign" data-toggle="modal" data-target="#myDiscuss"></b>
                        </a>
                        <ul>


                            <%                                    m = (Member) s.get(Member.class, id);
                                Query query = s.createQuery("from Hashtag");
                                List<Hashtag> l = query.list();
                                for (Hashtag h : l) {
                                    String mem[] = h.getMembers().split(",");
                                    for (String st : mem) {
                                        if (st.equals(m.getUsername())) {


                            %>

                            <li class="list-group-item-text">
                                <a href="window.jsp?ghId=<%=h.getHId()%>&&type=H"> # <%=h.getTag()%></a>
                            </li>
                            <%
                                        }
                                    }
                                }

                            %>
                        </ul>
                    </li>



                    <li> 
                        <a href="#"> 
                            Private Groups&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  

                            <b class="glyphicon glyphicon-plus-sign" data-toggle="modal" data-target="#myGroup"></b>

                        </a>

                        <ul>


                            <%                                    m = (Member) s.get(Member.class, id);
                                query = s.createQuery("from Group");
                                List<Group> l1 = query.list();
                                for (Group g : l1) {
                                    String mem[] = g.getMembers().split(",");
                                    for (String st : mem) {
                                        if (st.equals(m.getUsername())) {


                            %>

                            <li class="list-group-item-text">
                                <a href="window.jsp?ghId=<%=g.getGId()%>&&type=G">   <%=g.getGroupName()%></a>
                            </li>
                            <%
                                        }
                                    }
                                }

                            %>
                        </ul>

                    </li>      

                    <li>
                        <a href="#">
                            Direct Messages&nbsp;&nbsp;&nbsp;&nbsp; 
                            <b class="glyphicon glyphicon-plus-sign" data-toggle="modal" data-target="#myMessage"></b>
                        </a>
                    </li>

                </ul>
            </div>
            <!-- /#sidebar-wrapper -->

            <!-- Page Content -->

            <div id="page-content-wrapper">
                <div class="container-fluid">




                    <div class="dropdown">
                        <h1> <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <font color="black">
                                <%=m.getTeam().getTeamName()%>
                                </font>
                            </a> 
                            <ul class="dropdown-menu"> 
                                <li><a  data-toggle="modal" data-target="#myTeamSettings">Settings&nbsp;&nbsp;<span class="glyphicon glyphicon-wrench"></span></a></li>
                                <li><a href="teamReg.jsp">Add new team&nbsp;&nbsp;<span class="glyphicon glyphicon-plus"></span></a></li> 
                                <li><a href="logout.jsp">Switch to other team&nbsp;&nbsp;<span class="glyphicon glyphicon-log-out"></span></a></li>
                            </ul>

                        </h1>
                    </div>
                    <div align="right">

                        <div class="input-group col-xs-4" style="margin-top: -45px;">

                            <input type="text" class="form-control" name="post" placeholder="Search"> 
                            <span class="input-group-btn"> 
                                <button class="btn btn-default" type="submit"><span class="glyphicon glyphicon-search"></spans></button>

                                <button class="btn btn-default"><span>@</span></button>
                                <button onclick=""class="btn btn-default" data-toggle="modal" data-target="#myMail">&nbsp;<span class="badge"><%=mail%></span></button>
                            </span>
                        </div>
                    </div>

                    <div class="dropdown">

                        <h3>Welcome
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <font color="black">
                                <%=m.getUsername()%>
                                </font>
                            </a> 
                            <ul class="dropdown-menu"> 
                                <li><a data-toggle="modal" data-target="#myUserSettings">Edit Profile&nbsp;&nbsp;<span class="glyphicon glyphicon-edit"></span></a></li> 
                                <li><a href="logout.jsp">Logout&nbsp;&nbsp;<span class="glyphicon glyphicon-log-out"></span></a></li>

                            </ul>
                        </h3>
                    </div>
                    <p><%=m.getTeam().getTeamDescription()%></p>
                    <br>
                    <a href="#menu-toggle" class="btn btn-danger" id="menu-toggle">Sidebar is Evil !</a>
                    <br>


                    <%

                        Query query1 = s.createQuery("from Posts");
                        List<Posts> l2 = query1.list();
                        Hashtag ha = null;
                        Date d = new Date(0);
                        System.out.print(d.toString());
                        if (type == null) {


                    %>


                    <h3>Select a group or discussion !</h3>
                    <%                    } else if (type.equals("H")) {
                        Hashtag h2 = (Hashtag) s.get(Hashtag.class, Integer.parseInt(ghId));

                    %>
                    <h3># <%=h2.getTag()%></h3>
                    <%
                    } else if (type.equals("G")) {
                        Group g2 = (Group) s.get(Group.class, Integer.parseInt(ghId));


                    %>

                    <h3><%=g2.getGroupName()%></h3>

                    <%
                        }
                    %>

                    <br>

                    <!--input-group-->
                    <%
                        if (type == null) {
                    %>



                    <%
                    } else {

                    %>

                    <div>
                        <form method="post" action="post.jsp">
                            <div class="input-group"> 
                                <span class="input-group-btn"> 
                                    <button class="btn btn-default" type="submit">
                                        <span class="glyphicon glyphicon-pencil"></span>
                                    </button>
                                </span> 
                                <input type="text" class="form-control" name="post" placeholder="Create a post"> 
                            </div>
                        </form>
                    </div>
                    <%                         }
                    %>
                    <!-- /input-group -->
                    <br><br>
                    <div>
                        <ul class="list-group">

                            <%
                                if (type != null) {
                                    for (Posts p : l2) {
                                        if (p.getType().equals("H")) {
                                            if (p.getHashtag().getHId() == Integer.parseInt(ghId)) {

                            %>
                            <li class="list-group-item">
                                <h4><%=p.getPostDescription()%></h4>
                                <h6>created by <%=p.getMember().getUsername()%> at <%=p.getLastUpdate()%></h6>
                            </li>
                            <%
                                }
                            } else if (p.getType().equals("G")) {

                                if (p.getGroup().getGId() == Integer.parseInt(ghId)) {

                            %>
                            <li class="list-group-item">
                                <h4><%=p.getPostDescription()%></h4>
                                <h6>created by <%=p.getMember().getUsername()%> at <%=p.getLastUpdate()%></h6>
                            </li>
                            <%
                                            }
                                        }
                                    }
                                }
                            %>
                        </ul>
                    </div>




                    <!-- Modal1 -->
                    <div class="modal fade" id="myMessage" tabindex="-1" role="dialog" aria-labelledby="myMessage" aria-hidden="true"> 
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                        &times; 
                                    </button> 
                                    <h4 class="modal-title" id="myMessage">
                                        Send a message ....
                                    </h4> 
                                </div> 
                                <div class="modal-body">
                                    <form method="post" action="message.jsp">
                                        <input type="text" class="form-control" placeholder="Username" name="username"><br>
                                        <input type="text" class="form-control" placeholder="Subject" name="subject"><br>
                                        <textarea class="form-control" rows="5" placeholder="Type your message" name="mbody"></textarea>
                                </div>

                                <div class="modal-footer"> 
                                    
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close </button>
                                    <button type="submit" class="btn btn-default">Send </button> 
                                    </form>
                                </div>
                            </div><!-- /.modal-content -->
                        </div><!-- /.modal -->
                    </div>


                    <!-- Modal2 -->
                    <div class="modal fade" id="myDiscuss" tabindex="-1" role="dialog" aria-labelledby="myDiscuss" aria-hidden="true"> 
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                        &times; 
                                    </button> 
                                    <h4 class="modal-title" id="myDiscuss">
                                        Create a discussion ....
                                    </h4> 
                                </div> 
                                <div class="modal-body">
                                    <form method="post" action="hash.jsp">
                                        <input type="text" class="form-control" placeholder="Discussion Heading" name="header"><br>
                                        <textarea class="form-control" rows="5" placeholder="Write a short description" name="desc"></textarea><br>
                                        <textarea class="form-control" rows="3" placeholder="Comma seperated list of members" name="members"></textarea>

                                </div>

                                <div class="modal-footer"> 
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close </button>
                                    <button type="submit" class="btn btn-default">Create</button> 
                                    </form>
                                </div>
                            </div><!-- /.modal-content -->
                        </div><!-- /.modal -->
                    </div>


                    <!-- Modal3 -->
                    <div class="modal fade" id="myGroup" tabindex="-1" role="dialog" aria-labelledby="myGroup" aria-hidden="true"> 
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                        &times; 
                                    </button> 
                                    <h4 class="modal-title" id="myGroup">
                                        Create a group ....
                                    </h4> 
                                </div> 
                                <div class="modal-body">
                                    <form method="post" action="group.jsp">
                                        <input type="text" class="form-control" placeholder="Group Name" name="gr_name"><br>
                                        <textarea class="form-control" rows="3" placeholder="Comma seperated list of members" name="members"></textarea>
                                </div>

                                <div class="modal-footer"> 
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close </button>
                                    <button type="submit" class="btn btn-default">Create </button> 
                                    </form>
                                </div>
                            </div><!-- /.modal-content -->
                        </div><!-- /.modal -->
                    </div>



                    <!-- Modal4 -->
                    <div class="modal fade" id="myMail" tabindex="-1" role="dialog" aria-labelledby="myMail" aria-hidden="true"> 
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                        &times; 
                                    </button> 
                                    <h4 class="modal-title" id="myMail">
                                        Messages ...
                                    </h4> 
                                </div> 
                                <div class="modal-body">

                                    <ul class="list-group"> 
                                        <%                                            for (Messages ma : list) {
                                                if (ma.getMemberByReceiverId().getMId() == id) {

                                        %>

                                        <li class="list-group-item">
                                            <%=ma.getBody()%> sent by <%=ma.getMemberByReceiverId().getUsername()%>
                                        </li>
                                        <%
                                                }
                                            }
                                        %>
                                    </ul>                                      
                                </div>

                                <div class  

                                     ="modal-footer"> 
                                    <button type="button" class  

                                            ="btn btn-default" data-dismiss="modal">Close </button>
                                 
                                    </form>
                                </div>
                            </div><!-- /.modal-content -->
                        </div><!-- /.modal -->
                    </div>


                    <!-- Modal5 -->
                    <div class="modal fade" id="myUserSettings" tabindex="-1" role="dialog" aria-labelledby="myUserSettings" aria-hidden="true"> 
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                        &times; 
                                    </button> 
                                    <h4 class="modal-title" id="myUserSettings">
                                      User Settings
                                    </h4> 
                                </div> 
                                <div class="modal-body">
                                  <form method="post" action="edit.jsp">
                                        <input type="text" class="form-control" placeholder="New Username" name="username"><br>
                                        
                                </div>

                                <div class="modal-footer"> 
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close </button>
                                    <button type="submit" class="btn btn-default">Save </button> 
                                    </form>
                                </div>

                                
                            </div><!-- /.modal-content -->
                        </div><!-- /.modal -->
                    </div>

                    <!-- Modal6 -->
                    <div class="modal fade" id="myTeamSettings" tabindex="-1" role="dialog" aria-labelledby="myTeamSettings" aria-hidden="true"> 
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                        &times; 
                                    </button> 
                                    <h4 class="modal-title" id="myTeamSettings">
                                        Team Settings
                                    </h4> 
                                </div> 
                                <div class="modal-body">
                                    <form method="post" action="teamEdit.jsp">
                                        <input type="text" class="form-control" placeholder="Team Name" name="team"><br>
                                        <textarea class="form-control" rows="5" placeholder="Write a short description" name="desc"></textarea><br>
                                       
                                </div>

                                <div class="modal-footer"> 
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close </button>
                                    <button type="submit" class="btn btn-default">Create</button> 
                                    </form>
                                </div>
                            </div><!-- /.modal-content -->
                        </div><!-- /.modal -->
                    </div>





                </div>

            </div>

            <!-- /#page-content-wrapper -->

        </div>
        <!-- /#wrapper -->

        <!-- jQuery -->
        <script src="js/jquery.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="js/bootstrap.min.js"></script>

        <!-- Menu Toggle Script -->
        <script>
            $("#menu-toggle").click(function (e) {
                e.preventDefault();
                $("#wrapper").toggleClass("toggled");
            });

        </script>
    </body>
</html>