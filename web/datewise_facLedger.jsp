
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
            String date1=request.getParameter("date1");
            String date2=request.getParameter("date2");
            request.setAttribute("date1", date1);
            request.setAttribute("date2", date2);
            String factory =request.getParameter("factory");
            request.setAttribute("factory", factory);
            Connection con=null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            ResultSet rs1 = null;
            ResultSet rs2 = null;
               try{
            con=Database.getConnection();
            String query="select SI_NO, PRODUCT_NAME, QUANTITY, PURSE_PRICE, PAYMENT, COM_NAME, COM_AMOUNT, DATE from factory_stock where DATE between '"+ date1 +"' and '"+ date2 +"' and PURSE_FROM=? order by DATE";
            ps=con.prepareStatement(query);
            ps.setString(1, factory);
            rs=ps.executeQuery();
                  String query1="select sum(QUANTITY), sum(QUANTITY*PURSE_PRICE), sum(PAYMENT), sum(COM_AMOUNT) from factory_stock where DATE between '"+ date1 +"' and '"+ date2 +"' and  PURSE_FROM=?";
            ps=con.prepareStatement(query1);
            ps.setString(1, factory);
            rs1=ps.executeQuery();
            rs1.next();
            request.setAttribute("tqty", rs1.getInt(1));
            request.setAttribute("total", rs1.getLong(2));
            request.setAttribute("totalpay", rs1.getLong(3));
            request.setAttribute("totalcommi", rs1.getLong(4));       
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
           
            <div class="row">
                <div class="col-sm-12">
                    <div id="div_print">
                        <center>
                            <h3><b>Factory Ledger</b></h3>
                            <h4> Factory Name : ${factory}</h4>
                            <h5>Date : ${date1} TO ${date2} </h5>
                            
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
                                    <th style="text-align: center">Commission</th>
                                    <th style="text-align: center">Note</th>
                                    <th style="text-align: center">Percent</th>
                                    <th style="text-align: center">Balance</th>
                                    <th style="text-align: center">Edit</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                   while(rs.next()){
                                       int sino=rs.getInt("SI_NO");
                                       
                String pay="select sum(QUANTITY*PURSE_PRICE), sum(PAYMENT), sum(COM_AMOUNT) from factory_stock where  PURSE_FROM=? and SI_NO<?";
                ps = con.prepareStatement(pay);
                ps.setString(1, factory);
                ps.setInt(2, sino);
                rs2 = ps.executeQuery();
                while(rs2.next()){
              
                                %>
                                <tr>
                                   <td style="text-align: center"></td>
                                    <td style="text-align: center"><%= rs.getString("DATE")%> </td>
                                    <td style="text-align: center"><%= rs.getString("PRODUCT_NAME")%> </td>
                                    <td style="text-align: center"><%= rs.getInt("QUANTITY") %></td>
                                    <td style="text-align: center"><%= rs.getFloat("PURSE_PRICE") %></td>
                                    <td style="text-align: center"><%= rs.getInt("QUANTITY")*rs.getFloat("PURSE_PRICE") %></td>
                                    <td style="text-align: center"><%= rs.getLong("PAYMENT") %></td>
                                    <td style="text-align: center"><%= rs.getLong("COM_AMOUNT")%></td>
                                    <td style="text-align: center"><%= rs.getString("COM_NAME") %></td>
                                    <td style="text-align: center"><%= rs2.getLong(2)*100/(rs2.getLong(1)-rs2.getLong(3)) %> %</td>
                                    <td style="text-align: center"><%= (rs2.getLong(1)-(rs2.getLong(2)+rs2.getLong(3)+rs.getLong("PAYMENT")))+(rs.getInt("QUANTITY")*rs.getLong("PURSE_PRICE")) %></td>
                                    <td style="text-align: center">
                            <form  method="POST" action="FacLegUpServlet" class="form-inline">
                                <input type="hidden" value="<%= rs.getInt("SI_NO") %>" name="sino">
                                <button  type="submit"><i class="fa fa-edit"></i></button>
                            </form>
                            </td>      
                                </tr>
                               <% }} %>
                                <tr style="background-color: #CCC">
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center">TOTAL</th>
                                    <th style="text-align: center">${tqty}</th>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center">${total}</th>
                                    <th style="text-align: center">${totalpay}</th>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center">${(totalpay*100)/(total-totalcommi)} %</th>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center"></th>
                                </tr>
                           
                            </tbody>
                        </table>
                      
                           <% 
                                } catch (SQLException ex) {
                                    ex.printStackTrace();
                                 }finally {
try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }  
try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }        
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
                         var addSerialNumber = function () {
                             var i = 0;
                             $('.com tr').each(function (index) {
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
