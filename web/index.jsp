
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js" lang="">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Charu</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/normalize.css">
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="icon" type="image/png" href="img/favicon.ico">

    </head>
    <body  id="main" style="background-color: #030303">
        <div class="container-fluid">
            <header style="background-color: #030303">
                <center><img style="margin-top: 1%;" src="img/logo.png"  class="img-responsive"><h1 style="font-family: serif;  font-size: 3vw; color: whitesmoke; text-shadow: 2px 2px 3px black; "><strong>M/S. CHARU  ENTERPRISE</strong></h1></center>
            </header>

            <div style="background-color: #CCC; border-style: none" class="panel panel-success text-center">
                    <div  class="panel-body">
                        <div class="row">
                            <div class="col-sm-4">
                                <center> <img style="height: 278px; width: 100%" src="img/charu2.jpg" class="img-responsive"></center>
                            </div>
                            <div  class="col-sm-4"><center>
                                    
                                    <div id="bg" class="col-sm-12">
                                <button class="btn btn-primary btn-sm" style=" border-radius: 80%; background-color: #030303">  <h4><b>LOGIN-INFO</b></h4></button>
                                <h5 style="text-align: center; font-family: fontawesome; color: red"><strong>${error}</strong></h5>
                                <form action="LoginServlet" method="POST" class="form-inline text-center" >
                                    <center>
                                        <select style="width: 200px" class="form-control" name="usertype" required="">
                                            <option value="">Select User-Type</option>
                                            <option value="Accountant">Accountant</option>
                                            <option value="Employee">Employee</option>
                                        </select>
                                    </center><br>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                        <input type="text" class="form-control" name="userid" value=""  placeholder="User ID" autofocus="" required>
                                    </div>
                                    <br><br>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                        <input type="password"   class="form-control" autocomplete="off" name="password" value="" placeholder="Password" required>
                                    </div>
                                    <br><br>
                                    <button type="submit"   class="btn btn-success form-control"><i class="fa fa-sign-in"></i> <b>LOG IN</b></button>
                                </form><br>
                                    </div>
                              
                                </center>
                            </div>
                                <div class="col-sm-4">
                                    <center> <img style="height: 278px; width: 100%;" src="img/factory1.jpg" class="img-responsive"></center>
                                </div>
                        </div>
                    </div>
                </div>

                <div style=" background-color: #030303; color: #ffffff; border-style: none" class="panel panel-primary">
                    <div style="background-color: #030303" class="panel-heading text-center"><h3><b>Our Address</b></h3></div>
                    <div class="panel-body">
                        <div class="col-sm-6">
                            <center>
                                <h3 class="text-primary">Corporate-Office</h3>
                                <h3 style=" color: green; font-family: serif;" class="text-success"><b>M/S. CHARU ENTERPRISE</b></h3>
                                <p style="font-style: italic; font-size: 15px;"><b>85/4, Khanpur Main Road.<br>Narayangonj-1400.<br>Tel:01686-325738,01951-697813<br>E-mail:abdullahsagor630@gmail.com</b></p>
                            </center>
                        </div>
                        <div class="col-sm-6">
                            <center>
                                <h3 class="text-primary text-center ">Factory-Info</h3>
                                <img src="img/cc-logo.png" class="img-responsive">
                                <p style="font-style: italic; font-size: 15px;"><b>West Mukterpur, Munshigonj.<br>Tel:880-2-7648077,Fax:880-2-7648070<br>E-mail:factory@crowncement.com</b></p>  
                            </center>
                        </div>
                    </div>
                </div>

            <div class="text-center">
                <a href="https://www.facebook.com/"><button class="btn btn-primary"><i class="fa fa-facebook fa-2x"></i></button></a>
                <a href="https://twitter.com/"><button class="btn btn-info"><i class="fa fa-twitter fa-2x"></i></button></a>
                <a href="https://www.google.com/"><button class="btn btn-danger"><i class="fa fa-google fa-2x"></i></button></a>
                <a href="https://www.youtube.com/"><button class="btn btn-danger"><i class="fa fa-youtube fa-2x"></i></button></a>
                <a href="https://www.instagram.com/"><button class="btn btn-primary"><i class="fa fa-instagram fa-2x"></i></button></a>
                <a href="https://www.yahoo.com/"><button style=" background-color: #430297;" class="btn btn-default"><i class="fa fa-yahoo fa-2x"></i></button> </a>
            </div>

        </div><br>
        <%@include file = "footerpage.jsp" %>
        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/vendor/modernizr-2.8.3.min.js"></script>
    </body>
</html>
