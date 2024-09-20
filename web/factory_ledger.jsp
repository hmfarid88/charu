
<%@page import="Model.DeleteModel"%>
<%@page import="Pojo.DeletePojo"%>
<%@page import="Model.Accountant"%>
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
                        <li><a href="factory_pay_details.jsp"> Payment Details</a></li>
                                                                                           
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                    </ul> 
                </div>
            </nav>
        </header>

        <div id="div_print">
            <center><h2><b>CHARU ENTERPRISE</b></h2>
                <h3>Factory Ledger</h3>
                <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
            </center>

            <table  border="2" width="100%" class="table-condensed table-responsive">
                <thead>
                    <tr style="background-color: #CCC">
                        <th style="text-align: center">Factory Name</th>
                        <th style="text-align: center">Product</th>
                        <th style="text-align: center">Qty</th>
                        <th style="text-align: center">Value</th>
                        <th style="text-align: center">Total Qty</th>
                        <th style="text-align: center">Total Value</th>
                        <th style="text-align: center">Payment</th>
                         <th style="text-align: center">Commission</th>
                        <th style="text-align: center">Balance</th>
                        <th style="text-align: center">Details</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        AccountPojo ap = new AccountPojo();
                        List<StockModel> list = ap.FactoryLedger();
                        for (StockModel sml : list) {
                    %>
                    <tr>
                        <td style="text-align: center"><%= sml.getFactory()%></td>
                        <td style="text-align: center"><%= sml.getStockpro()%></td>
                        <td style="text-align: center"><%= sml.getStockqty()%></td>
                        <td style="text-align: center"><%= sml.getStockqty() * sml.getStockrate() %></td>
                        <td style="text-align: center"><%= sml.getTotalproqty() %></td>
                        <td style="text-align: center"><%= sml.getTotalprovalue() %></td>
                        <td style="text-align: center"><%= sml.getStockpay()%></td>
                        <td style="text-align: center"><%= sml.getTotalcommission()%></td>
                        <td style="text-align: center"><%= sml.getStockbalance()%></td>
                        <td style="text-align: center">
                            <form method="POST" action="details_factoryLedger.jsp">
                                <input type="hidden" name="factory" value="<%= sml.getFactory()%>">
                                <input type="submit" value="Details">
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
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
