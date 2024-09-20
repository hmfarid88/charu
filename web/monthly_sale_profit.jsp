<%@page import="java.sql.SQLException"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
                           <li><a data-toggle="collapse" data-target="#datewise" href="#">Datewise</a></li>
                        <li>
                            <div id="datewise" class="collapse" style="margin: 10px 15px">
                                <form method="POST" action="datewise_monthly_sale_profit.jsp" class="form-inline">
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

            <div id="div_print" style="font-family: fontawesome">
                <center><h2><b>CHARU ENTERPRISE</b></h2>
                    <h3>Monthly Profit Report</h3>
                   <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                </center>

                <table id="regprofit" border="2" width="100%" class="table-striped table-responsive">
                    <thead>
                        <tr style="background-color: #CCC">
                            <th style="text-align: center">SN</th>
                            <th style="text-align: center">Month Name</th>
                            <th style="text-align: center">Profit</th>
                            <th style="text-align: center">Commission</th>
                            <th style="text-align: center">Cost</th>
                            <th style="text-align: center">Employee Cost</th>
                            <th style="text-align: center">Retailer Commission</th>
                            <th style="text-align: center">Nit Profit</th>
                            <th style="text-align: center">Proprietor Balance</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                ResultSet rs1 = null;
                ResultSet rs2 = null;
                ResultSet rs3 = null;
                ResultSet rs4 = null;
                ResultSet rs5 = null;
                ResultSet rs6 = null;
                try {
                    con = Database.getConnection();
                    String query = "select distinct MONTH(DATE), MONTHNAME(DATE), YEAR(DATE) from order_delevery order by DATE";
                    ps = con.prepareStatement(query);
                    rs = ps.executeQuery();
                     while(rs.next()){
                         String month = rs.getString(1);
                             String year = rs.getString(3);
                             String query1 = "select sum(AMOUNT) from fac_commission where MONTH=? and YEAR=?";
                             ps = con.prepareStatement(query1);
                             ps.setString(1, month);
                             ps.setString(2, year);
                             rs1 = ps.executeQuery();
                             while(rs1.next()){
                             String query2 = "select sum(AMOUNT) from cost where MONTH(DATE)=? and YEAR(DATE)=?";
                             ps = con.prepareStatement(query2);
                             ps.setString(1, month);
                             ps.setString(2, year);
                             rs2 = ps.executeQuery();
                             while(rs2.next()){
                             String query3 = "select sum(AMOUNT) from emp_cost where MONTH(DATE)=? and YEAR(DATE)=?";
                             ps = con.prepareStatement(query3);
                             ps.setString(1, month);
                             ps.setString(2, year);
                             rs3 = ps.executeQuery();
                             while(rs3.next()){
                             String query4 = "select sum(AMOUNT) from rtler_commission where MONTH(DATE)=? and YEAR(DATE)=?";
                             ps = con.prepareStatement(query4);
                             ps.setString(1, month);
                             ps.setString(2, year);
                             rs4 = ps.executeQuery();
                             while(rs4.next()){
                             String query5 = "select sum(PAYMENT), sum(RECEIVE) from proprietor_cost where MONTH(DATE)=? and YEAR(DATE)=?";
                             ps = con.prepareStatement(query5);
                             ps.setString(1, month);
                             ps.setString(2, year);
                             rs5 = ps.executeQuery();
                             while(rs5.next()){
                             String query6="select sum(QTY*RATE), sum(QTY*PURSE_RATE) from order_delevery where MONTH(DATE)=? and YEAR(DATE)=?";
                             ps = con.prepareStatement(query6);
                             ps.setString(1, month);
                             ps.setString(2, year);
                             rs6 = ps.executeQuery();
                             while(rs6.next()){
                        %>
                        <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= rs.getString(2) %>, <%= rs.getString(3) %></td>
                            <th style="text-align: center"><%= rs6.getLong(1)- rs6.getLong(2) %></th>
                            <th style="text-align: center"><%= rs1.getLong(1) %></th>
                            <th style="text-align: center"><%= rs2.getLong(1) %></th>
                            <th style="text-align: center"><%= rs3.getLong(1) %></th>
                            <th style="text-align: center"><%= rs4.getLong(1) %></th>
                            <th style="text-align: center"><%= (rs6.getLong(1)+rs1.getLong(1))- (rs6.getLong(2)+rs2.getLong(1)+rs3.getLong(1)+rs4.getLong(1)) %></th>
                            <th style="text-align: center"><%= rs5.getLong(1)-rs5.getLong(2) %></th>
                        </tr>
                        <% }}}}}}}
}catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
try { if (rs5 != null) rs5.close(); rs5=null; } catch (SQLException ex2) { }
try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { } 
try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                        %>
                      
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
        
        <script language="javascript">
                        var addSerialNumber = function () {
                            var i = 0;
                            $('#regprofit tr').each(function (index) {
                                $(this).find('td:nth-child(1)').html(index - 1 + 1);
                            });
                        };

                        addSerialNumber();
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
<% } %>
    </body>
</html>
