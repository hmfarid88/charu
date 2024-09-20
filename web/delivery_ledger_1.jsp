
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
                        <li><a href="employee.jsp"><span class="fa fa-home"> Home</span></a></li>
                        <li><a data-toggle="collapse" data-target="#datewise" href="#">Datewise</a></li>
                        <li>
                            <div id="datewise" class="collapse" style="margin: 10px 15px">
                                <form method="POST" action="datewise_deliveryLedger_1.jsp" class="form-inline">
                                    <input type="date" name="date1" autocomplete="off" class="form-control input-sm" placeholder="Start Date" required=""> To
                                    <input type="date" name="date2" autocomplete="off" class="form-control input-sm" placeholder="End Date" required="">
                                    <input type="submit" value="OK" class="btn btn-primary btn-sm">
                                </form>
                            </div>
                        </li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><input style="margin-top: 10px; width: 70%" class="form-control input-sm" id="myInput" type="text" placeholder="Search..."></li>
                        <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                    </ul> 
                </div>
            </nav>
        </header>
        <div id="div_print">
            <h3 class="text-center"><b>CHARU  ENTERPRISE</b></h3> 
            <h3 class="text-center">Delivery Ledger</h3> 
            <center><h4><div id="date"> </div> </h4></center>
            <table border="2" width="100%" class="table-striped table-responsive">
                <thead>
                    <tr style="background-color: #CCC">
                        <th style="text-align: center">SN</th>
                        <th style="text-align: center">Date</th>
                        <th style="text-align: center">Retailer</th>
                        <th style="text-align: center">Thana</th>
                        <th style="text-align: center">Area</th>
                        <th style="text-align: center">Product</th>
                        <th style="text-align: center">Qty</th>
                        <th style="text-align: center">Rate</th>
                        <th style="text-align: center">Total</th>
                        <th style="text-align: center">S.P Name</th>
                        <th style="text-align: center">Transport</th>
                        <th style="text-align: center">Truck No</th>
                        <th style="text-align: center">Rent</th>
                    </tr>
                </thead> 
                <tbody id="myTable">
                    <%
                        AccountPojo ap = new AccountPojo();
                        List<StockModel> list = ap.DeliveryLedger();
                        for (StockModel sm : list) {
                    %>
                    <tr>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"><%= sm.getDdate()%></td>
                        <td style="text-align: center"><%= sm.getDname()%> (<%= sm.getNote()%>)</td>
                        <td style="text-align: center"><%= sm.getThana() %></td>
                        <td style="text-align: center"><%= sm.getArea() %></td>
                        <td style="text-align: center"><%= sm.getDpname()%></td>
                        <th style="text-align: center"><%= sm.getDqty()%></th>
                        <td style="text-align: center"><%= sm.getSlrate()%></td>
                        <th style="text-align: center"><%= sm.getDqty() * sm.getSlrate()%></th>
                        <td style="text-align: center"><%= sm.getDspname()%></td>
                        <td style="text-align: center"><%= sm.getTransport()%></td>
                        <td style="text-align: center"><%= sm.getTrucno()%></td>
                        <th style="text-align: center"><%= sm.getTrent()%></th>
                        
                    </tr>
                    <% } %>
                     </tbody>
                <tfoot>
                    <tr style="background-color: #CCC">
                        <th style="text-align: center"></th>
                        <th style="text-align: center"></th>
                        <th style="text-align: center"></th>
                        <th style="text-align: center"></th>
                        <th style="text-align: center"></th>
                        <th style="text-align: center">TOTAL</th>
                        <td style="text-align: center"></td>
                        <th style="text-align: center"></th>
                        <td style="text-align: center"></td>
                        <th style="text-align: center"></th>
                        <th style="text-align: center"></th>
                        <th style="text-align: center"></th>
                        <td style="text-align: center"></td>
                    </tr>
                </tfoot>
               

            </table>
        </div>
    </div>

    <br><br>
    <%@include file = "footerpage.jsp" %>
    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <script>
                            window.onload = function () {
                                var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
                                ;
                                var date = new Date();

                                document.getElementById('date').innerHTML = months[date.getMonth()] + ' ' + date.getFullYear();
                            };
    </script>
    <script language="javascript">
        var addSerialNumber = function () {
            var i = 0;
            $('table tr').each(function (index) {
                $(this).find('td:nth-child(1)').html(index - 1 + 1);
            });
        };

        addSerialNumber();
    </script>
     <script>
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
    $('table thead th').each(function(i) {
                calculateColumn(i);
            });
            function calculateColumn(index) {
            var total = 0;
            $('table tr').each(function() {
                var value = parseInt($('th:visible', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('table tfoot td').eq(index).text(total);
        } 
  });
});
</script>
     <script>
        $(document).ready(function() {
            $('table thead th').each(function(i) {
                calculateColumn(i);
            });
        

        function calculateColumn(index) {
            var total = 0;
            $('table tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('table tfoot td').eq(index).text(total);
        }
        });
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
    <% }%>
</body>
</html>
