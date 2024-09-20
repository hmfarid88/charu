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
        <link rel="stylesheet" href="css/normalize.css">
        <link rel="stylesheet" href="css/main.css">
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
            String spname =request.getParameter("spname");
            request.setAttribute("spname", spname);
            Connection con=null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            ResultSet rs1 = null;
            try{
            con=Database.getConnection();
            String query="select ORDER_NAME, PRODUCT_NAME, QTY, RATE, PAYMENT, DATE from order_delevery where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) and SP_NAME=? order by DATE";
            ps=con.prepareStatement(query);
            ps.setString(1, spname);
            rs=ps.executeQuery();
            String query1="select sum(QTY), sum(QTY*RATE), sum(PAYMENT) from order_delevery where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) and SP_NAME=?";
            ps=con.prepareStatement(query1);
            ps.setString(1, spname);
            rs1=ps.executeQuery();
            rs1.next();
            request.setAttribute("totalqty", rs1.getInt(1));
            request.setAttribute("total", rs1.getDouble(2));
            request.setAttribute("totalpay", rs1.getDouble(3));
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
                            <!--<li><a href="accountant.jsp"><span class="fa fa-home"> Home</span></a></li>-->
                            <li><a data-toggle="collapse" data-target="#datewise" href="#">Datewise</a></li>
                            <li>
                                <div id="datewise" class="collapse" style="margin: 10px 15px">
                                    <form method="POST" action="datewise_emp_sale.jsp" class="form-inline">
                                        <input type="hidden" name="spname" value="${spname}">
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
                            <h3><b>Employee's Sale Info</b></h3>
                            <center><h4><div id="date"> </div> </h4></center>
                            <h4> Employee Name : ${spname}</h4>
                        </center>
                        <table border="2" width="100%" class="table-striped table-responsive">
                            <thead>
                                <tr style="background-color: #CCCCCC">
                                    <th style="text-align: center">SN</th>
                                    <th style="text-align: center">Retailer</th>
                                    <th style="text-align: center">Product</th>
                                    <th style="text-align: center">Qty</th>
                                    <th style="text-align: center">Rate</th>
                                    <th style="text-align: center">Total</th>
                                    <th style="text-align: center">Payment</th>
                                    <th style="text-align: center">Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                   while(rs.next()){
                                %>
                                <tr>
                                    <td style="text-align: center"></td>
                                    <td style="text-align: center"><%= rs.getString(1)%> </td>
                                    <td style="text-align: center"><%= rs.getString(2) %></td>
                                    <td style="text-align: center"><%= rs.getInt(3) %></td>
                                    <td style="text-align: center"><%= rs.getFloat(4) %></td>
                                    <td style="text-align: center"><%= rs.getInt(3)*rs.getFloat(4) %></td>
                                    <td style="text-align: center"><%= rs.getFloat(5) %></td>
                                    <td style="text-align: center"><%= rs.getString(6)%> </td>
                                 </tr>
                                <% }
                                } catch (SQLException ex) {
                                    ex.printStackTrace();
                                 }finally {
try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }        
try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                         }
                                %>
                                <tr style="background-color: #CCC">
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center">TOTAL</th>
                                    <th style="text-align: center">${totalqty}</th>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center">${total}</th>
                                    <th style="text-align: center">${totalpay}</th>
                                    <th style="text-align: center"></th>
                                 </tr>
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
        <script src="js/vendor/modernizr-2.8.3.min.js"></script>
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
