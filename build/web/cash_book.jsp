
<%@page import="java.util.List"%>
<%@page import="Model.CashModel"%>
<%@page import="Pojo.CashBook"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Charu</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/jquery-ui.css">
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
                                        <form method="POST" action="datewise_cash_book.jsp" class="form-inline">
                                            <input type="date" name="date1" autocomplete="off" class="form-control input-sm" placeholder="Select Date" required="">
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

        <div class="row">

            <div class="col-sm-12">
                <div id="div_print">
                    <center>
                        <h3 style="font-family: fontawaesome" class="text-primary text-center"><b>Cash-Book</b></h3>
                        <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                        <table  border="2" width="90%" class="table-striped table-responsive" >
                            <thead>
                                <tr style=" background-color: #ccc">
                                    <th style="text-align: center">Description</th>
                                    <th style="text-align: center">Debit</th>
                                    <th style="text-align: center">Credit</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    CashBook cb = new CashBook();
                                    CashModel cmm = cb.DailyCashShow();

                                %>
                                <tr>
                                    <th style="text-align: center">Opening Balance</th>
                                    <th style="text-align: center"><%= cmm.getOpenbalance()%></th>
                                    <td></td>
                                </tr>
                                <%
                                    List<CashModel> list = cb.DebitShow();
                                    for (CashModel cm : list) {
                                %>
                                <tr>   
                                    <td style="text-align: center"><%= cm.getDebitname()%></td> 
                                    <td style="text-align: center"><%= cm.getDebitamount()%></td> 
                                    <td></td> 
                                </tr>

                                <%  }
                                    List<CashModel> list1 = cb.CreditShow();
                                    for (CashModel cm : list1) {
                                %>
                                <tr>
                                    <td style="text-align: center"><%= cm.getCrname()%></td> 
                                    <td></td>
                                    <td style="text-align: center"><%= cm.getCramount()%></td> 
                                </tr>
                                <%}%>


                                <tr style="border-bottom-color: black">

                                    <th style="text-align: center;border-left-style: hidden"></th>
                                    <th style="text-align: center;border-left-style: hidden"><u><%= cmm.getTotaldebit()%></u></th>
                                    <th style="text-align: center;border-left-style: hidden;border-right-style: hidden"><u><%= cmm.getTotalcredit()%></u></th>
                                </tr>
                                <tr style="border-style: hidden">
                                    <th style="text-align: center;border-style: hidden">Net Balance</th>
                                    <th style="text-align: center;border-style: hidden"><u><%= cmm.getNetbalance()%></u></th>
                                    <th style="text-align: center;border-style: hidden"></th>
                                </tr>

                            </tbody>
                        </table>

                    </center>
                </div>
            </div>

        </div>

        <br><br>
        <%@include file = "footerpage.jsp" %>

        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
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
