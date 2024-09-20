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
                        <li><a href="retailer_pay_details.jsp">Payment Details</a></li>
                        <li><a href="#" data-toggle="modal" data-target="#cominfo" >Pay-Commission</a></li> 
                     <li><a href="#" data-toggle="collapse" data-target="#dateinfo" >Date-Wise</a></li> 
                             <li>
                                 <div id="dateinfo" class="collapse" style="margin-top: 12px" >
                                         <form method="POST" action="datewise_retailer_ledger.jsp" class="form-inline">
                                             <input type="date" name="date" autocomplete="off" class="form-control input-sm" required="" >
                                             <input type="submit" class="btn btn-primary btn-sm" value="GO">
                                         </form> 
                                 </div>
                         </li>
                         <li><a href="#" data-toggle="modal" data-target="#datetodate" >Date-To-Date</a></li>
                        
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><input style="margin-top: 10px; width: 70%" class="form-control input-sm" id="myInput" type="text" placeholder="Search..."></li>
                        <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                    </ul> 
                </div>
            </nav>
        </header>

        <div id="div_print" style="font-family: fontawesome">
            <center><h2><b>CHARU ENTERPRISE</b></h2>
                <h3>Retailer Ledger</h3>
                <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
            </center>

            <table  border="2" width="100%" class="table-condensed table-responsive">
                <thead>
                    <tr style="background-color: #CCC">
                        <th style="text-align: center">SN</th>
                        <th style="text-align: center">Retailer</th>
                        <th style="text-align: center">Number</th>
                        <th style="text-align: center">Pending Order</th>
                        <th style="text-align: center">Last Delivery</th>
                        <th style="text-align: center">Total Delivery</th>
                        <th style="text-align: center">Total Value</th>
                        <th style="text-align: center">Total Payment</th>
                        <th style="text-align: center">Total Commission</th>
                        <th style="text-align: center">Percent</th>
                        <th style="text-align: center">Balance</th>
                        <th style="text-align: center">S.P Name</th>
                        <th style="text-align: center">Details</th>
                    </tr>
                </thead>
                <tbody id="myTable">
                    <%
                        AccountPojo ap = new AccountPojo();
                        List<StockModel> list = ap.RetailerLedger();
                        for (StockModel sml : list) {
                    %>
                    <tr>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"><%= sml.getRetiler()%></td>
                        <th style="text-align: center">1</th>
                        <th style="text-align: center"><%= sml.getPod()%></th>
                        <th style="text-align: center"><%= sml.getDelivery()%></th>
                        <th style="text-align: center"><%= sml.getTqty()%></th>
                        <th style="text-align: center"><%= sml.getValutotal() %></th>
                        <th style="text-align: center"><%= sml.getTpay()%></th>
                        <th style="text-align: center"><%= sml.getTcommi()%></th>
                        <td style="text-align: center"><%= sml.getTpay()*100/sml.getTvalue() %> %</td>
                        <th style="text-align: center"><%= sml.getRetailledger() %></th>
                        <td style="text-align: center"><%= sml.getSpname()%></td>
                        <td style="text-align: center">
                            <form method="POST" action="dtails_retLedger.jsp">
                                <input type="hidden" name="retailer" value="<%= sml.getRetiler()%>">
                                <input type="submit" class="btn btn-success" value="Details">
                            </form>
                        </td>
                    </tr>
                    
                    <% } %>
                    
                </tbody>
                <tfoot>
                   <tr style="background-color: #CCC">
                        <th style="text-align: center"></th>
                        <th style="text-align: center">TOTAL</th>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <th style="text-align: center"></th>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <th style="text-align: center"></th>
                        <th style="text-align: center"></th>
                     </tr> 
                </tfoot>
            </table>
        </div>
    </div>
   
    <br><br>
    
<div id="cominfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Retailer Commission</h4>
                </div>
                <div class="modal-body">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Commission Entry</legend>
                        <form method="POST" action="Rtler_commiServlet" class="form-inline">
                            <div class="row">
                                <div class="col-sm-3">
                                    <select style="width: 98%" class="form-control input-sm" name="retailer" required="" >
                                        <option value="">Select-Retailer</option>
                                        <%
                                            List<Accountant> list003 = ap.retailerView();
                                            for (Accountant ac : list003) {
                                        %>
                                        <option value="<%= ac.getRetailer()%>"> <%= ac.getRetailer()%></option>
                                        <%}%>
                                    </select>
                                </div>
                                <div class="col-sm-3">
                                    <input style="width: 95%" type="text" name="note" class="form-control input-sm" value="" required="" placeholder="Note"> 
                                </div>
                                <div class="col-sm-3">
                                    <input style="width: 95%" type="text" name="amount" class="form-control input-sm" value="" required="" placeholder="Amount">
                                </div>
                                    <div class="col-sm-3">
                                    <input style="width: 98%" type="date" name="date" class="form-control input-sm" value="" required="">
                                </div>

                            </div><br>
                            <input type="submit" class="btn btn-info btn-sm" value="OK">  
                        </form>  
                    </fieldset>  

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>
    <div id="datetodate" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    
                </div>
                <div class="modal-body">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Date to Date</legend>
                     
                            <div class="row">
                                <div class="col-sm-12">
                                    <center>
                                   <form method="POST" action="datetodate_retailer_ledger.jsp" class="form-inline">
                                       <input type="date" name="date1" autocomplete="off" class="form-control input-sm" required="" ><br> to <br>
                                       <input type="date" name="date2" autocomplete="off" class="form-control input-sm" required="" ><br>
                                       <br> <input type="submit" class="btn btn-primary btn-sm" value="GO">
                                   </form> 
                                    </center>
                                </div>
                                
                            </div><br>
                         
                      
                    </fieldset>  

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>
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
