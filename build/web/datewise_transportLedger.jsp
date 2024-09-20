
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
            String transport =request.getParameter("transport");
            request.setAttribute("transport", transport);
            Connection con=null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            ResultSet rs1 = null;
            ResultSet rs2 = null;
            try{
            con=Database.getConnection();
            String query = "select RETAILER, PRODUCT_NAME, TRUCK_NO, QTY, RENT, PAYMENT, NOTE, DATE, TRANSPORT_NAME, SI_NO from transport_pay where DATE between '"+ date1 +"' and '"+ date2 +"' and TRANSPORT_NAME=?";
                ps = con.prepareStatement(query);
                ps.setString(1, transport);
                rs = ps.executeQuery();

                String query1 = "select sum(QTY), sum(RENT), sum(PAYMENT) from transport_pay where DATE between '"+ date1 +"' and '"+ date2 +"' and TRANSPORT_NAME=?";
                ps = con.prepareStatement(query1);
                ps.setString(1, transport);
                rs1 = ps.executeQuery();
                rs1.next();
                request.setAttribute("totalqty", rs1.getLong(1));
                request.setAttribute("totalrent", rs1.getLong(2));
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
                            <h3><b>Transport Ledger</b></h3>
                            <h4> Transport Name : ${transport}</h4>
                            <h5><b>Date : ${date1} TO ${date2} </b></h5>
                       </center>
                        <table border="2" width="100%" class="table-striped table-responsive">
                            <thead>
                                <tr style="background-color: #CCCCCC">
                                     <th style="text-align: center">SN</th>
                                    <th style="text-align: center">Date</th>
                                    <th style="text-align: center">Retailer</th>
                                    <th style="text-align: center">Product</th>
                                    <th style="text-align: center">Qty</th>
                                    <th style="text-align: center">Truck No</th>
                                    <th style="text-align: center">Rent</th>
                                    <th style="text-align: center">Payment</th>
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
                                    String tranport=rs.getString("TRANSPORT_NAME");
               String pay="select sum(RENT),  sum(PAYMENT) from transport_pay where TRANSPORT_NAME=? and SI_NO<?";
               ps = con.prepareStatement(pay);
                ps.setString(1, tranport);
                ps.setInt(2, sino);
                rs2 = ps.executeQuery();
                while(rs2.next()){
                                %>
                                <tr>
                                   <td style="text-align: center"></td>
                                    <td style="text-align: center"><%= rs.getString(8)%> </td>
                                    <td style="text-align: center"><%= rs.getString(1)%> </td>
                                    <td style="text-align: center"><%= rs.getString(2)%> </td>
                                    <td style="text-align: center"><%= rs.getInt(4) %></td>
                                    <td style="text-align: center"><%= rs.getString(3)%> </td>
                                    <td style="text-align: center"><%= rs.getFloat(5) %></td>
                                    <td style="text-align: center"><%= rs.getFloat(6) %></td>
                                    <td style="text-align: center"><%= rs.getString(7)%></td>
                                    <td style="text-align: center"><%= rs.getFloat(6)*100/rs.getFloat(5) %> %</td>
                                    <td style="text-align: center"><%= (rs2.getLong(2)+rs.getFloat(6))-(rs2.getLong(1)+rs.getFloat(5)) %></td>
                                    <td style="text-align: center">
                            <form  method="POST" action="TportSelectServlet" class="form-inline">
                                <input type="hidden" value="<%= rs.getInt("SI_NO") %>" name="trsi">
                                <button  type="submit"><i class="fa fa-edit"></i></button>
                            </form>
                            </td>    
                                </tr>
                              <% }} %>
                                <tr style="background-color: #CCC">
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center">TOTAL</th>
                                    <th style="text-align: center">${totalqty}</th>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center">${totalrent}</th>
                                    <th style="text-align: center">${totalpay}</th>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center"></th>
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
