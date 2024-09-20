
<%@page import="java.sql.SQLException"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.SaleModel"%>
<%@page import="java.util.List"%>
<%@page import="Pojo.Profit"%>
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
                            <li><a data-toggle="collapse" data-target="#datewise" href="#">Monthly</a></li>
                            <li><a data-toggle="collapse" data-target="#datetodate" href="#">Date to Date</a></li>
                            <li>
                                <div id="datewise" class="collapse" style="margin: 10px 15px">
                                    <form method="POST" action="datewise_sale_profit.jsp" class="form-inline">
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
                            <li>
                               <div id="datetodate" class="collapse" style="margin: 10px 15px">
                                   <form method="POST" action="datetodate_sale_profit.jsp" class="form-inline">
                                     <input type="date" name="date1" autocomplete="off" class="form-control input-sm" required="" > to 
                                       <input type="date" name="date2" autocomplete="off" class="form-control input-sm" required="" >
                                       <input type="submit" class="btn btn-primary btn-sm" value="GO">   
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

            <div id="div_print" style="font-family: fontawesome">
                <center><h2><b>CHARU ENTERPRISE</b></h2>
                    <h3>Sales & Profit Report</h3>
                    <center><h4><div id="date"> </div> </h4></center>
                </center>

                <table id="regprofit" border="2" width="100%" class="table-striped table-responsive">
                    <thead>
                        <tr style="background-color: #CCC">
                            <th style="text-align: center">SN</th>
                            <th style="text-align: center">Order Date</th>
                            <th style="text-align: center">Retailer</th>
                            <th style="text-align: center">Delivery Date</th>
                            <th style="text-align: center">Product</th>
                            <th style="text-align: center">Qty</th>
                            <th style="text-align: center">Purse Rate</th>
                            <th style="text-align: center">Sale Rate</th>
                            <th style="text-align: center">Profit</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Profit pf = new Profit();
                            SaleModel sml = pf.MonthlyTotalSale();
                            SaleModel tcomi=pf.TotalCommission();
                            SaleModel tcost=pf.TotalCost();
                            SaleModel tecost=pf.TotalEmpCost();
                            SaleModel rtcommi=pf.RetailerCommission();
                            List<SaleModel> list = pf.MonthlySaleShow();
                            for (SaleModel sm : list) {
                        %>
                        <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= sm.getDoddate()%></td>
                            <td style="text-align: center"><%= sm.getDodname()%></td>
                            <td style="text-align: center"><%= sm.getDsldate()%></td>
                            <td style="text-align: center"><%= sm.getDproname()%></td>
                            <td style="text-align: center"><%= sm.getDqty()%></td>
                            <td style="text-align: center"><%= sm.getDpurserate()%></td>
                            <td style="text-align: center"><%= sm.getDrate()%></td>
                            <td style="text-align: center"><%= (sm.getDrate() - sm.getDpurserate()) * sm.getDqty()%></td>
                        </tr>
                        <% } %>
                        <tr style="background-color: #CCCCCC">
                            <th style="text-align: center"></th> 
                            <th style="text-align: center"></th> 
                            <th style="text-align: center"></th> 
                            <th style="text-align: center"></th> 
                            <th style="text-align: center">AVERAGE</th> 
                            <th style="text-align: center"></th> 
                            <th style="text-align: center"><%= sml.getAvprate()%></th> 
                            <th style="text-align: center"><%= sml.getAvsrate()%></th> 
                            <th style="text-align: center"></th> 
                        </tr>
                        <tr style="background-color: #CCCCCC">
                            <th style="text-align: center"></th> 
                            <th style="text-align: center"></th> 
                            <th style="text-align: center"></th> 
                            <th style="text-align: center"></th> 
                            <th style="text-align: center">TOTAL</th> 
                            <th style="text-align: center"><%= sml.getDtotalqty()%></th> 
                            <th style="text-align: center"></th> 
                            <th style="text-align: center"></th> 
                            <th style="text-align: center"><%= sml.getDtotalrate() %></th> 
                        </tr>
                    </tbody>
                </table> 
                        <center>   <h4>Factory Commission</h4></center>
                        <table id="commission" border="2" width="100%" class="table-striped table-responsive">
                            <thead>
                                <tr style="background-color: #CCC">
                                    <th style="text-align: center">SN</th>
                                    <th style="text-align: center">Factory</th>
                                    <th style="text-align: center">Commission Name</th>
                                    <th style="text-align: center">Duration</th>
                                    <th style="text-align: center">Amount</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                List<SaleModel> list2 = pf.TargetShow();
                            for (SaleModel sm : list2) {
                                %>
                                <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= sm.getTrfname() %></td>
                            <td style="text-align: center"><%= sm.getTrname() %></td>
                            <td style="text-align: center"><%= sm.getStdate() %> To <%= sm.getEnddate() %></td>
                            <td style="text-align: center"><%= sm.getTramount() %></td>
                                </tr>
                                <% } %>
                                <tr style="background-color: #CCCCCC">
                                    <th style="text-align: center"></th> 
                                    <th style="text-align: center"></th> 
                                    <th style="text-align: center">TOTAL</th> 
                                    <th style="text-align: center"></th> 
                                    <th style="text-align: center"><%= tcomi.getCommission() %></th> 
                                </tr>
                            </tbody>
                        </table>
                        <center>   <h4>Office Cost</h4></center>
                        <table id="ofcost"  border="2" width="100%" class="table-striped table-responsive">
                            <thead>
                                <tr style="background-color: #CCC">
                                    <th style="text-align: center">SN</th>
                                    <th style="text-align: center">Date</th>
                                    <th style="text-align: center">Cost Name</th>
                                    <th style="text-align: center">Amount</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                List<SaleModel> list3 = pf.MonthlyCostShow();
                            for (SaleModel sm : list3) {
                                %>
                                <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= sm.getCostdate() %></td>
                            <td style="text-align: center"><%= sm.getCostname() %></td>
                            <td style="text-align: center"><%= sm.getCostamount() %></td>
                                </tr>
                                <% } %>
                                <tr style="background-color: #CCCCCC">
                                    <th style="text-align: center"></th> 
                                    <th style="text-align: center"></th> 
                                    <th style="text-align: center">TOTAL</th> 
                                    <th style="text-align: center"><%= tcost.getTotalcost() %></th> 
                                </tr>
                            </tbody>
                        </table>
                        <center>   <h4>Employee Cost</h4></center>
                        <table id="empcost"  border="2" width="100%" class="table-striped table-responsive">
                            <thead>
                                <tr style="background-color: #CCC">
                                    <th style="text-align: center">SN</th>
                                    <th style="text-align: center">Date</th>
                                    <th style="text-align: center">Employee Name</th>
                                    <th style="text-align: center">Cost Name</th>
                                    <th style="text-align: center">Amount</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                List<SaleModel> list4 = pf.MonthlyEmpCostShow();
                            for (SaleModel sm : list4) {
                                %>
                                <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= sm.getEmpcostdate() %></td>
                            <td style="text-align: center"><%= sm.getEmpname() %></td>
                            <td style="text-align: center"><%= sm.getEmpcost() %></td>
                            <td style="text-align: center"><%= sm.getEmpcostamount() %></td>
                                </tr>
                                <% } %>
                                <tr style="background-color: #CCCCCC">
                                    <th style="text-align: center"></th> 
                                    <th style="text-align: center"></th> 
                                    <th style="text-align: center"></th> 
                                    <th style="text-align: center">TOTAL</th> 
                                    <th style="text-align: center"><%= tecost.getTotalempcost() %></th> 
                                </tr>
                            </tbody>
                        </table>
                        <center>   <h4>Retailer Commission: <%=rtcommi.getTotalcommi() %> <a data-toggle="modal" data-target="#comilist" href="#">Details</a></h4>
                        
                        </center>
                        <center>
                            <h4>NET PROFIT : (<%= sml.getDtotalrate()%> + <%= tcomi.getCommission() %>) - (<%= tcost.getTotalcost() %> + <%= tecost.getTotalempcost() %> + <%=rtcommi.getTotalcommi() %>) = <%= (sml.getDtotalrate()+tcomi.getCommission())-(tcost.getTotalcost()-tecost.getTotalempcost()+rtcommi.getTotalcommi()) %> </h4> 
                        </center>
            </div>
<div id="comilist" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Commission List</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <center> <h5> Retailer Commission</h5>  </center>
                          <table border="2" width="100%" class="table-striped table-responsive">
                            <thead>
                                <tr style="background-color: #CCCCCC">
                                    <th style="text-align: center">Date</th>
                                    <th style="text-align: center">Retailer Name</th>
                                    <th style="text-align: center">Commission Note</th>
                                    <th style="text-align: center">Amount</th>
                                </tr>
                            </thead>
                            <tbody>
                               <%
                                     Connection con = null;
                                     PreparedStatement ps = null;
                                     ResultSet rs = null;
                                     try {
                                     con = Database.getConnection();
                                         String query2 = "select RETAILER_NAME, NOTE, AMOUNT, DATE from rtler_commission where YEAR(DATE) = YEAR(CURRENT_DATE()) and MONTH(DATE) = MONTH(CURRENT_DATE())";
                                     ps = con.prepareStatement(query2);
                                     rs = ps.executeQuery();
                                     while (rs.next()) {
                               %>
                               <tr>
                                 <td style="text-align: center"><%= rs.getString("DATE")%> </td>
                                 <td style="text-align: center"><%= rs.getString("RETAILER_NAME")%> </td>
                                 <td style="text-align: center"><%= rs.getString("NOTE")%> </td>
                                 <td style="text-align: center"><%= rs.getFloat("AMOUNT")%> </td>
                               </tr>
                               <% } 
                               } catch (SQLException ex) {
                                    ex.printStackTrace();
                                 }finally {
  
try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                         }
                               %>
                            </tbody>
                          </table>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
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
                            $('#regprofit tr').each(function (index) {
                                $(this).find('td:nth-child(1)').html(index - 1 + 1);
                            });
                        };

                        addSerialNumber();
        </script>
        <script language="javascript">
                        var addSerialNumber = function () {
                            var i = 0;
                            $('#commission tr').each(function (index) {
                                $(this).find('td:nth-child(1)').html(index - 1 + 1);
                            });
                        };

                        addSerialNumber();
        </script>
        <script language="javascript">
                        var addSerialNumber = function () {
                            var i = 0;
                            $('#ofcost tr').each(function (index) {
                                $(this).find('td:nth-child(1)').html(index - 1 + 1);
                            });
                        };

                        addSerialNumber();
        </script>
        <script language="javascript">
                        var addSerialNumber = function () {
                            var i = 0;
                            $('#empcost tr').each(function (index) {
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
