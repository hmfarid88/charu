
<%@page import="Model.EmpModel"%>
<%@page import="java.util.List"%>
<%@page import="Pojo.AccountPojo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <html class="no-js" lang="">
        <head>
            <meta charset="utf-8">
            <meta http-equiv="x-ua-compatible" content="ie=edge">
            <title>Charu</title>
            <meta name="description" content="">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <link rel="stylesheet" href="css/bootstrap.min.css">
            <link rel="stylesheet" href="css/font-awesome.min.css">
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
                                <li><a data-toggle="collapse" data-target="#datewise" href="#">Datewise</a></li>
                                <li>
                                    <div id="datewise" class="collapse" style="margin: 10px 15px">
                                        <form method="POST" action="datewise_proprietor_ledger.jsp" class="form-inline">
                                            <input type="date" name="date1" autocomplete="off" class="form-control input-sm" placeholder="Start Date" required=""> To
                                            <input type="date" name="date2" autocomplete="off" class="form-control input-sm" placeholder="End Date" required="">
                                            <input type="submit" value="OK" class="btn btn-primary btn-sm">
                                        </form>
                                    </div>
                                </li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul> 
                        </div>
                    </nav>
                </header>

                <div id="div_print">
                    <%
                                AccountPojo ap = new AccountPojo();
                                EmpModel acc = ap.ProprietorTotal();
                    %>
                    <center><h2><b>CHARU ENTERPRISE</b></h2>
                        <h3>Proprietor Ledger</h3>
                        <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script> </h4>
                        <h4 class="text-primary">   BALANCE :   <%= acc.getPaytotal()-acc.getRecvtotal() %></h4>
                    </center><br>

                    <table  border="2" width="100%" class="table-striped table-responsive">
                        <thead>
                            <tr style="background-color: #CCC">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Date</th>
                                <th style="text-align: center">Description</th>
                                <th style="text-align: center">Payment</th>
                                <th style="text-align: center">Receive</th>
                                <th style="text-align: center">Balance</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<EmpModel> list = ap.ProprietorLedger();
                                for (EmpModel ac : list) {
                            %>
                            <tr>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= ac.getProdate()%></td>
                                <td style="text-align: center"><%= ac.getProcost()%>, <%= ac.getPronote() %></td>
                                <td style="text-align: center"><%= ac.getPropayamount() %></td>
                                <td style="text-align: center"><%= ac.getProrecvamount() %></td>
                                <td style="text-align: center"><%= ac.getProbl()+ac.getPropayamount()-ac.getProrecvamount() %></td>
                            </tr>
                            <% } %>
                            <tr style="background-color: #CCC">
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <th style="text-align: center">Total</th>
                                <th style="text-align: center"><%= acc.getPaytotal() %></th>
                                <th style="text-align: center"><%= acc.getRecvtotal() %></th>
                                <th style="text-align: center"></th>
                            </tr>
                            <tr>
                                <th style="text-align: center"></th>
                                <th style="text-align: center; border-left: hidden"></th>
                                <th style="text-align: center; border-left: hidden"></th>
                                <th style="text-align: center; border-left: hidden"></th>
                                <th style="text-align: center; border-left: hidden">Balance</th>
                                <th style="text-align: center; border-left: hidden"><%= acc.getPaytotal()-acc.getRecvtotal() %></th>
                                   
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <br><br>
            <%@include file = "footerpage.jsp" %>

            <script src="js/jquery-3.1.1.min.js"></script>
            <script src="js/bootstrap.min.js"></script>
            
          
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
