
<%@page import="java.sql.SQLException"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.ResultSet"%>
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
            <%
                String date1=request.getParameter("date1");
                String date2=request.getParameter("date2");
                
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                ResultSet rs1 = null;
                ResultSet rs2 = null;
                ResultSet rs3 = null;
                ResultSet rs4 = null;
                ResultSet rs5 = null;
                ResultSet rs6 = null;
                ResultSet rs7 = null;
                ResultSet rs8 = null;
                ResultSet rs9 = null;
                try {
                    con = Database.getConnection();
                    String query = "select ORDER_NAME, ORDER_DATE, PRODUCT_NAME, QTY, PURSE_RATE, RATE, DATE from order_delevery where QTY>0 and DATE between '"+ date1 +"' and '"+ date2 +"'";
                    ps = con.prepareStatement(query);
                    rs = ps.executeQuery();
                    String query1 = "select sum(QTY), sum(QTY*RATE), sum(QTY*PURSE_RATE) from order_delevery where DATE between '"+ date1 +"' and '"+ date2 +"'";
                    ps = con.prepareStatement(query1);
                    rs1 = ps.executeQuery();
                    rs1.next();
                   
                    request.setAttribute("tqty", rs1.getInt(1));
                    request.setAttribute("tsale", rs1.getLong(2));
                    request.setAttribute("tbuy", rs1.getLong(3));
                    String query2="select sum(AMOUNT) from fac_commission where END_DATE between '"+ date1 +"' and '"+ date2 +"'";
                    ps = con.prepareStatement(query2);
                    rs2 = ps.executeQuery();
                    rs2.next();
                    request.setAttribute("commission", rs2.getLong(1));
                    String query3 = "select MONTHNAME(DATE) from order_delevery where DATE between '"+ date1 +"' and '"+ date2 +"'";
                    ps = con.prepareStatement(query3);
                    rs3=ps.executeQuery();
                    rs3.next();
                    request.setAttribute("mnth", rs3.getString(1));
                    String query4="select FACTORY_NAME, COM_NAME, AMOUNT, START_DATE, END_DATE from fac_commission where END_DATE between '"+ date1 +"' and '"+ date2 +"'";
                    ps = con.prepareStatement(query4);
                    rs4 = ps.executeQuery();
                    String query5="select COST_NAME, AMOUNT, DATE from cost where DATE between '"+ date1 +"' and '"+ date2 +"'";
                    ps = con.prepareStatement(query5);
                    rs5 = ps.executeQuery();
                    String query6="select sum(AMOUNT) from cost where DATE between '"+ date1 +"' and '"+ date2 +"'";
                    ps = con.prepareStatement(query6);
                    rs6 = ps.executeQuery();
                    rs6.next();
                    request.setAttribute("tcost", rs6.getLong(1));
                    String query7="select EMP_NAME, COST_NAME, AMOUNT, DATE from emp_cost where DATE between '"+ date1 +"' and '"+ date2 +"'";
                    ps = con.prepareStatement(query7);
                    rs7 = ps.executeQuery();
                    String query8="select sum(AMOUNT) from emp_cost where DATE between '"+ date1 +"' and '"+ date2 +"'";
                    ps = con.prepareStatement(query8);
                    rs8 = ps.executeQuery();
                    rs8.next();
                    request.setAttribute("tempcost", rs8.getLong(1));
                    String query9="select sum(AMOUNT) from rtler_commission where DATE between '"+ date1 +"' and '"+ date2 +"'";
                    ps = con.prepareStatement(query9);
                    rs9 = ps.executeQuery();
                    rs9.next();
                    request.setAttribute("rtcommi", rs9.getLong(1));
                    
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
                        <center><h4>Date: ${param.date1} to ${param.date2}</h4></center>
                    </center>

                    <table id="profittable" border="2" width="100%" class="table-striped table-responsive">
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
                               while(rs.next()){
                            %>
                            <tr>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= rs.getString(2) %></td>
                                <td style="text-align: center"><%= rs.getString(1) %></td>
                                <td style="text-align: center"><%= rs.getString(7) %></td>
                                <td style="text-align: center"><%= rs.getString(3) %></td>
                                <td style="text-align: center"><%= rs.getInt(4) %></td>
                                <td style="text-align: center"><%= rs.getFloat(5) %></td>
                                <td style="text-align: center"><%= rs.getFloat(6) %></td>
                                <td style="text-align: center"><%= (rs.getLong(6) - rs.getLong(5)) * rs.getInt(4) %></td>
                            </tr>
                            <% } %>
                                <tr style="background-color: #CCCCCC">
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th> 
                                <th style="text-align: center"></th> 
                                <th style="text-align: center"></th> 
                                <th style="text-align: center">AVERAGE</th> 
                                <th style="text-align: center"></th> 
                                <th style="text-align: center">${tbuy/tqty}</th> 
                                <th style="text-align: center">${tsale/tqty}</th> 
                                <th style="text-align: center"></th> 
                            </tr>                      
                            <tr style="background-color: #CCCCCC">
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th> 
                                <th style="text-align: center"></th> 
                                <th style="text-align: center"></th> 
                                <th style="text-align: center">TOTAL</th> 
                                <th style="text-align: center">${tqty}</th> 
                                <th style="text-align: center"></th> 
                                <th style="text-align: center"></th> 
                                <th id="regtotal" style="text-align: center">${tsale-tbuy}</th> 
                            </tr>
                        </tbody>
                    </table> <br>
                    <h4 class=" text-center">Commission List</h4>
                    <table id="comisiontable" border="2" width="100%" class="table-striped table-responsive">
                        <thead>
                            <tr style="background-color: #CCC">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Factory Name</th>
                                <th style="text-align: center">Commission Name</th>
                                <th style="text-align: center">Duration</th>
                                <th style="text-align: center">Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                               while(rs4.next()){
                            %>
                            <tr>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= rs4.getString(1) %></td>
                                <td style="text-align: center"><%= rs4.getString(2) %></td>
                                <td style="text-align: center"><%= rs4.getString(4) %> TO <%= rs4.getString(5) %></td>
                                <td style="text-align: center"><%= rs4.getFloat(3) %></td>
                            </tr>
                            <% } %>
                   
                            <tr style="background-color: #CCC ">
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th> 
                                <th style="text-align: center"></th> 
                                <th style="text-align: center">TOTAL</th> 
                                <th style="text-align: center">${commission}</th> 
                            </tr>
                        </tbody>
                    </table><br>
                             <center>   <h4>Office Cost</h4></center>
                        <table id="officecost" border="2" width="100%" class="table-striped table-responsive">
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
                                    while(rs5.next()){  
                               %>
                                <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= rs5.getString(3) %></td>
                            <td style="text-align: center"><%= rs5.getString(1) %></td>
                            <td style="text-align: center"><%= rs5.getFloat(2) %></td>
                                </tr>
                                <% } %>
                                <tr style="background-color: #CCCCCC">
                                    <th style="text-align: center"></th> 
                                    <th style="text-align: center"></th> 
                                    <th style="text-align: center">TOTAL</th> 
                                    <th style="text-align: center">${tcost}</th> 
                                </tr>
                            </tbody>
                        </table><br>
                        <center>   <h4>Employee Cost</h4></center>
                        <table id="empcost" border="2" width="100%" class="table-striped table-responsive">
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
                               while(rs7.next()){
                                %>
                                <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= rs7.getString(4) %></td>
                            <td style="text-align: center"><%= rs7.getString(1) %></td>
                            <td style="text-align: center"><%= rs7.getString(2) %></td>
                            <td style="text-align: center"><%= rs7.getFloat(3) %></td>
                                </tr>
                                <% } %>
 
                                <tr style="background-color: #CCCCCC">
                                    <th style="text-align: center"></th> 
                                    <th style="text-align: center"></th> 
                                    <th style="text-align: center"></th> 
                                    <th style="text-align: center">TOTAL</th> 
                                    <th style="text-align: center">${tempcost}</th> 
                                </tr>
                            </tbody>
                        </table>
                                          <%
                                          }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
try { if (rs8 != null) rs8.close(); rs8=null; } catch (SQLException ex2) { }
try { if (rs7 != null) rs7.close(); rs7=null; } catch (SQLException ex2) { }
try { if (rs6 != null) rs6.close(); rs6=null; } catch (SQLException ex2) { }
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
                        <br>
                        <center>   <h4>Retailer Commission: ${rtcommi} <a data-toggle="modal" data-target="#comilist" href="#">Details</a></h4>
                        
                        </center>
                        <center>
                            <h4>NET PROFIT : (${tsale-tbuy} + ${commission}) - (${tcost} + ${tempcost} + ${rtcommi}) = ${((tsale-tbuy) + commission) - (tcost+ tempcost+rtcommi)} </h4> 
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
                                     
                                     try {
                                     con = Database.getConnection();
                                     String query2 = "select RETAILER_NAME, NOTE, AMOUNT, DATE from rtler_commission where DATE between '"+ date1 +"' and '"+ date2 +"'";
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
                        
            <script language="javascript">
                var addSerialNumber = function () {
                    var i = 0;
                    $('#profittable tr').each(function (index) {
                        $(this).find('td:nth-child(1)').html(index - 1 + 1);
                    });
                };

                addSerialNumber();
            </script>
             <script language="javascript">
                var addSerialNumber = function () {
                    var i = 0;
                    $('#comisiontable tr').each(function (index) {
                        $(this).find('td:nth-child(1)').html(index - 1 + 1);
                    });
                };

                addSerialNumber();
            </script>
            <script language="javascript">
                var addSerialNumber = function () {
                    var i = 0;
                    $('#officecost tr').each(function (index) {
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
