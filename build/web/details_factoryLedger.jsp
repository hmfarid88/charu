
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="DB.Database"%>
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
        <%
            String factory =request.getParameter("factory");
            request.setAttribute("factory", factory);
            Connection con=null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            ResultSet rs1 = null;
            ResultSet rs2 = null;
            ResultSet rs3 = null;
            try{
            con=Database.getConnection();
            String query="select PRODUCT_NAME, QUANTITY, PURSE_PRICE, PAYMENT, DATE, SI_NO from factory_stock where  PURSE_FROM=? and YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps=con.prepareStatement(query);
            ps.setString(1, factory);
            rs=ps.executeQuery();
            String query1="select sum(QUANTITY), sum(QUANTITY*PURSE_PRICE), sum(PAYMENT) from factory_stock where  PURSE_FROM=? and YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps=con.prepareStatement(query1);
            ps.setString(1, factory);
            rs1=ps.executeQuery();
            rs1.next();
            request.setAttribute("tqty", rs1.getInt(1));
            request.setAttribute("total", rs1.getLong(2));
            request.setAttribute("totalpay", rs1.getLong(3));
            
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
                                    <form method="POST" action="datewise_facLedger.jsp" class="form-inline">
                                        <input type="hidden" name="factory" value="${factory}">
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
            
            <div class="row">
                <div class="col-sm-12">
                    <div id="div_print">
                        <center>
                            <h3><b>Factory Ledger</b></h3>
                            <h4> Factory Name : ${factory}</h4>
                            <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                        </center>
                        <table border="2" width="100%" class="table-striped table-responsive">
                            <thead>
                                <tr style="background-color: #CCCCCC">
                                    <th style="text-align: center">SN</th>
                                    <th style="text-align: center">Date</th>
                                    <th style="text-align: center">Product</th>
                                    <th style="text-align: center">Qty</th>
                                    <th style="text-align: center">Rate</th>
                                    <th style="text-align: center">Total</th>
                                    <th style="text-align: center">Payment</th>
                                    <th style="text-align: center">Percent</th>
                                    <th style="text-align: center">Balance</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                     while(rs.next()){
                                     int sino=rs.getInt("SI_NO");
                                     String date=rs.getString("DATE");
                String pay="select sum(QUANTITY*PURSE_PRICE),  sum(PAYMENT) from factory_stock where PURSE_FROM=? and SI_NO<?";
                ps = con.prepareStatement(pay);
                ps.setString(1, factory);
                ps.setInt(2, sino);
                rs2 = ps.executeQuery();
                String commi="select sum(AMOUNT) from fac_commission where FACTORY_NAME=? and END_DATE<?";
                ps = con.prepareStatement(commi);
                ps.setString(1, factory);
                ps.setString(2, date);
                rs3 = ps.executeQuery();
                while(rs2.next()){
                while(rs3.next()){
                                %>
                                <tr>
                                    <td style="text-align: center"></td>
                                    <td style="text-align: center"><%= rs.getString(5)%> </td>
                                    <td style="text-align: center"><%= rs.getString(1)%> </td>
                                    <td style="text-align: center"><%= rs.getInt(2) %></td>
                                    <td style="text-align: center"><%= rs.getFloat(3) %></td>
                                    <td style="text-align: center"><%= rs.getInt(2)*rs.getFloat(3) %></td>
                                    <td style="text-align: center"><%= rs.getLong(4) %></td>
                                    <td style="text-align: center"><%= rs.getLong(4)*100/(rs.getInt(2)*rs.getFloat(3)) %> %</td>
                                    <td style="text-align: center"><%= (rs2.getLong(1)-(rs2.getLong(2)+rs.getLong(4)+rs3.getLong(1)))+(rs.getInt(2)*rs.getLong(3)) %></td>
                                </tr>
                              <% }}} %>
                         
                                <tr style="background-color: #CCC">
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center">TOTAL</th>
                                    <th style="text-align: center">${tqty}</th>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center">${total}</th>
                                    <th style="text-align: center">${totalpay}</th>
                                    <th style="text-align: center">${(totalpay*100)/total} %</th>
                                    <th style="text-align: center"></th>
                                </tr>
                                
                            </tbody>
                        </table>
                       
                                <%
                                } catch (SQLException ex) {
                                    ex.printStackTrace();
                                 }finally {
try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }        
try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                         }
                                %>
                                                    
                    </div>
                </div>
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
