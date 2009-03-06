<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
    	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>
            Registration
        </title>
        <% 
            String skin = request.getParameter("skin");
            if (skin != null) {
        %>
        <link rel="stylesheet" type="text/css" href="css/<%= skin %>.css"/>
        <%
            }
         %>
    </head>
    <body>
        <!-- CSS reference:     devguru.com -->
        <!-- Skinning examples: csszengarden.com -->
        <div class="registration">
            <div class="header">
                <div class="logo">
                    <a href="/">Logo</a>
                </div>
                <div class="nav">
                    <ul>
                        <li class="home">
                            <a href="/">Home</a>
                        </li>
                        <li class="about">
                            <a href="/about">About</a>
                        </li>
                        <li class="download">
                            <a href="/download">Download</a>
                        </li>
                        <li class="buy">
                            <a href="/buy">Buy</a>
                        </li>
                        <li class="help">
                            <a href="/help">Help</a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="main">
                <form action="/register" method="post">
                    <div class="email">
                        <label>
                            Email:
                        </label>
                        <input type="text" name="email"/>
                    </div>
                    <div class="password">
                        <label>
                            Password:
                        </label>
                        <input type="text" name="password"/>
                    </div>
                    <div class="submit">
                        <input type="image" src="images/empty.gif"/>
                    </div>               
                </form>
            </div>
        </div>
    </body>
</html>
