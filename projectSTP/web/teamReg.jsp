<!DOCTYPE html>
<html >
    <head>
        <meta charset="UTF-8">
        <title>ConnAct - Connecting Teams</title>
        <link id="favicon" rel="shortcut icon" href="img/CaptureWebnew.png" sizes="16x16 32x32 48x48" type="image/png" />
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <script type="text/javascript">
            $(function () {
                $(".btn").click(function () {
                    $(this).submit('loading').delay(1000).queue(function () {
                        $(this).submit('reset');
                    });
                });
            });
        </script>
    </head>

    <body>

        <div class="wrapper">
            <div class="container">
                <h1 style="color: #ffffff">ConnAct</h1>
                <img align="center" src="img/CaptureWebnew.png" width="112" height="80">

                <form class="form" method="post" action="teamR.jsp">
                    <input type="text" placeholder="Team Name" name="team">
                    <input type="text" placeholder="Team Description" name="desc">
                    <input type="text" placeholder="Email" name="email">
                    <input type="password" placeholder="Password" name="pass">
                    <input type="text" placeholder="Username" name="username">
                    <input type="date" placeholder="D.O.B" name="dob">
                    <button type="submit"  class="btn btn-lg" id="login-button" data-loading-text="Loading...">Login</button>
                    <p style="font-size: 1.3em;"><font color="white">${requestScope.msg}</font></p>
                </form>
            </div>

            <ul class="bg-bubbles">
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
            </ul>
        </div>
        <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>

    </body>
</html>
