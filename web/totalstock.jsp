
<%@page import="Model.DeleteModel"%>
<%@page import="Pojo.DeletePojo"%>
<%@page import="Model.StockModel"%>
<%@page import="java.util.List"%>
<%@page import="Pojo.AccountPojo"%>
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
    <body id="main">
        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
        <div class="container-fluid">
           <header>
                <nav style="margin: 0 auto" class="navbar navbar-inverse">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar"> 
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                    </div>
                    <div class="collapse navbar-collapse" id="myNavbar">
                        <ul class="nav navbar-nav">
                            <li><a href="accountant.jsp"><span class="fa fa-home"> Home</span></a></li>
                            <li><a href="#" data-toggle="collapse" data-target="#predate">Previous Stock</a></li>
                            <li>
                                <div style="margin: 10px 15px" id="predate" class="collapse">
                                    <form method="POST" action="prviousstock.jsp" class="form-inline">
                                        <input type="date" autocomplete="off" name="date" value="" class="form-control input-sm">
                                        <input type="submit" value="GO" class="btn btn-primary btn-sm">
                                    </form>  
                                </div>
                            </li>
                            <li><a href="#" data-toggle="collapse" data-target="#preentry">Entry-Info</a></li>
                            <li>
                                <div id="preentry" class="collapse" style="margin: 10px 15px">
                                    <form method="POST" action="prviousentry.jsp" class="form-inline">
                                       <select name="month" class="form-control input-sm" required="">
                                            <option class="active" value=""> Select Month</option>
                                            <option value="1">January</option>
                                            <option value="2">February</option>
                                            <option value="3">March</option>
                                            <option value="4">April</option>
                                            <option value="5">May</option>
                                            <option value="6">June</option>
                                            <option value="7">July</option>
                                            <option value="8">August</option>
                                            <option value="9">September</option>
                                            <option value="10">October</option>
                                            <option value="11">November</option>
                                            <option value="12">December</option>
                                        </select>
                                        <select name="year" class="form-control input-sm" required="">
                                            <option value=""> Select Year</option>
                                            <option value="2018">2018</option>
                                            <option value="2019">2019</option>
                                            <option value="2020">2020</option>
                                            <option value="2021">2021</option>
                                            <option value="2022">2022</option>
                                            <option value="2023">2023</option>
                                            <option value="2024">2024</option>
                                            <option value="2025">2025</option>
                                        </select>
                                        <input type="submit" value="GO" class="btn btn-primary btn-sm">
                                    </form>
                                </div>
                            </li>
<!--                            <li>
                                <div style="margin: 10px 15px" id="preentry" class="collapse">
                                    <form method="POST" action="prviousentry.jsp" class="form-inline">
                                        <input type="date" autocomplete="off" name="date" value="" class="form-control input-sm">
                                        <input type="submit" value="GO" class="btn btn-primary btn-sm">
                                    </form>  
                                </div>
                            </li>-->
                            
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                        </ul> 
                    </div>
                </nav>
            </header>
            <div id="div_print">
                <h3 style="font-family: fontawesome" class="text-center"><b>CHARU  ENTERPRISE</b></h3> 
                <h3 style="font-family: fontawesome" class="text-center">Stock Details</h3>
                <h4 class="text-center">Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                <table border="2" width="100%" class="table-striped table-responsive">
                    <thead>
                        <tr style="background-color: #CCC">
                            <th style="text-align: center">SN</th>
                            <th style="text-align: center">Date</th>
                            <th style="text-align: center">Product</th>
                            <th style="text-align: center">Purse From</th>
                            <th style="text-align: center">Qty</th>
                            <th style="text-align: center">Rate</th>
                            <th style="text-align: center">Total</th>
                        </tr>
                    </thead> 
                    <tbody>
                        <%
                            AccountPojo ap = new AccountPojo();
                            StockModel stm=ap.TotalStock();
                            List<StockModel> list = ap.StockShow();
                            for (StockModel sm : list) {
                        %>
                        <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= sm.getDate()%></td>
                            <td style="text-align: center"><%= sm.getProname()%></td>
                            <td style="text-align: center"><%= sm.getPfrom()%></td>
                            <td style="text-align: center"><%= sm.getQty()%></td>
                            <td style="text-align: center"><%= sm.getRate()%></td>
                            <td style="text-align: center"><%= sm.getTotal()%></td>
                        </tr>
                        <% }%>
                        
                    </tbody>
                    <tfoot>
                        <tr style="background-color: #CCCCCC">
                            <th style="text-align: center"></th> 
                            <th style="text-align: center"></th>
                            <th style="text-align: center"></th>
                            <th style="text-align: center">Total</th>
                            <th style="text-align: center"><%= stm.getTotalqty() %></th>
                            <th style="text-align: center"></th>
                            <th style="text-align: center"><%= stm.getTotalvalu() %></th>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
        <br><br>
        <%@include file = "footerpage.jsp" %>
        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/vendor/modernizr-2.8.3.min.js"></script>
       
        <script language="javascript">
                                var addSerialNumber = function () {
                                    var i = 0;
                                    $('table tr').each(function (index) {
                                        $(this).find('td:nth-child(1)').html(index - 1 + 1);
                                    });
                                };

                                addSerialNumber();
        </script>
        <script language="javascript">
            function printdiv(printpage)
            {
                var headstr = "<html><head><title></title></head><body>";
                var footstr = "</body>";
                var newstr = document.all.item(printpage).innerHTML;
                var oldstr = document.body.innerHTML;
                document.body.innerHTML = headstr + newstr + footstr;
                window.print();
                document.body.innerHTML = oldstr;
                return false;
            }
        </script>
        <% } %>
    </body>
</html>
