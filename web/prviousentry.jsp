
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
            int year=Integer.parseInt(request.getParameter("year"));
            int month=Integer.parseInt(request.getParameter("month"));
            request.setAttribute("yer", year);
            
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            ResultSet rs1 = null;
            ResultSet rs2 = null;
            try {
                con = Database.getConnection();
                String query = "select PRODUCT_NAME, PURSE_FROM, QUANTITY, PURSE_PRICE, PAYMENT, DATE from factory_stock where YEAR(DATE) = '"+ year +"' AND MONTH(DATE) = '"+ month +"'";
                ps = con.prepareStatement(query);
                rs = ps.executeQuery();
                String query1="select sum(QUANTITY), sum(QUANTITY*PURSE_PRICE) from factory_stock where YEAR(DATE) = '"+ year +"' AND MONTH(DATE) = '"+ month +"'";
                ps = con.prepareStatement(query1);
                rs1 = ps.executeQuery();
                rs1.next();
                request.setAttribute("totalqty", rs1.getInt(1));
                request.setAttribute("total", rs1.getLong(2));
                String query2 = "select MONTHNAME(DATE) from factory_stock where YEAR(DATE) = '"+ year +"' AND MONTH(DATE) = '"+ month +"'";
                    ps = con.prepareStatement(query2);
                    rs2=ps.executeQuery();
                    rs2.next();
                    request.setAttribute("mnth", rs2.getString(1));
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
            <div id="div_print"><center>
                <h3 style="font-family: fontawesome" class="text-center"><b>CHARU  ENTERPRISE</b></h3> 
                <h3 style="font-family: fontawesome" class="text-center">Stock Entry Info</h3>
                <center><h4> ${mnth} ${yer}  </h4></center>
                <table border="2" width="80%" class="table-striped table-responsive">
                    <thead>
                        <tr style="background-color: #CCC">
                            <th style="text-align: center">SN</th>
                            <th style="text-align: center">Date</th>
                            <th style="text-align: center">Product</th>
                            <th style="text-align: center">Purse From</th>
                            <th style="text-align: center">Qty</th>
                            <th style="text-align: center">Rate</th>
                            <th style="text-align: center">Total</th>
                            <th style="text-align: center">Payment</th>
                        </tr>
                    </thead> 
                    <tbody>
                        <% while(rs.next()){ %>
                        <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= rs.getString(6) %></td>
                            <td style="text-align: center"><%= rs.getString(1) %></td>
                            <td style="text-align: center"><%= rs.getString(2) %></td>
                            <td style="text-align: center"><%= rs.getInt(3)%></td>
                            <td style="text-align: center"><%= rs.getFloat(4) %></td>
                            <td style="text-align: center"><%= rs.getInt(3)*rs.getFloat(4) %></td>
                            <td style="text-align: center"><%= rs.getDouble(5) %></td>
                        </tr>
                        <% }
                        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                        %>
                        <tr style="background-color: #CCC">
                            <th style="text-align: center"></th>
                            <th style="text-align: center"></th>
                            <th style="text-align: center"></th>
                            <th style="text-align: center">TOTAL</th>
                            <th style="text-align: center">${totalqty}</th>
                            <th style="text-align: center"></th>
                            <th style="text-align: center">${total}</th>
                            <th style="text-align: center"></th>
                        </tr>
                       
                    </tbody>
                    
                </table></center>
            </div>
        </div>

        <br><br>
        <%@include file = "footerpage.jsp" %>
        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/vendor/modernizr-2.8.3.min.js"></script>

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
