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
            String date1=request.getParameter("date1");
            String date2=request.getParameter("date2");
            request.setAttribute("date1", date1);
            request.setAttribute("date2", date2);
            Connection con=null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            ResultSet rs1 = null;
            try{
            con=Database.getConnection();
            String query="select ORDER_NAME, NOTE, PRODUCT_NAME, QTY, RATE, TRUCK_NO, RENT, TRANSPORT, SP_NAME, DATE, SI_NO from order_delevery where DATE between '"+ date1 +"' and '"+ date2 +"' and QTY>0";
            ps=con.prepareStatement(query);
            rs=ps.executeQuery();
            String query1="select sum(QTY), sum(QTY*RATE), sum(RENT) from order_delevery where DATE between '"+ date1 +"' and '"+ date2 +"' ";
            ps=con.prepareStatement(query1);
            rs1=ps.executeQuery();
            rs1.next();
            request.setAttribute("tqty", rs1.getInt(1));
            request.setAttribute("total", rs1.getLong(2));
            request.setAttribute("totalrent", rs1.getLong(3));
           
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
                            
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                             <li><input style="margin-top: 10px; width: 70%" class="form-control input-sm" id="myInput" type="text" placeholder="Search..."></li>
                            <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                        </ul> 
                    </div>
                </nav>
            </header>
            <div id="div_print">
                <h3 style="font-family: fontawesome" class="text-center"><b>CHARU  ENTERPRISE</b></h3> 
                <h3 style="font-family: fontawesome" class="text-center">Delivery Ledger</h3> 
                <center><h4>Date : ${date1} To ${date2}</h4></center>
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
                         while(rs.next()){ 
             String retailer=rs.getString(1);
             String area="select THANA, AREA from retailer_info where R_NAME=?";
             ps = con.prepareStatement(area);
             ps.setString(1, retailer);
             rs1 = ps.executeQuery();
             while (rs1.next()) {
                        %>
                        <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= rs.getString(10)%></td>
                            <td style="text-align: center"><%= rs.getString(1) %> (<%= rs.getString(2) %>)</td>
                            <td style="text-align: center"><%= rs1.getString(1) %></td>
                            <td style="text-align: center"><%= rs1.getString(2) %></td>
                            <td style="text-align: center"><%= rs.getString(3)%></td>
                            <th style="text-align: center"><%= rs.getInt(4)%></th>
                            <td style="text-align: center"><%= rs.getFloat(5)%></td>
                            <th style="text-align: center"><%= rs.getInt(4) * rs.getFloat(5)%></th>
                            <td style="text-align: center"><%= rs.getString(9)%></td>
                            <td style="text-align: center"><%= rs.getString(8)%></td>
                            <td style="text-align: center"><%= rs.getString(6)%></td>
                            <th style="text-align: center"><%= rs.getFloat(7)%></th>
                                            
                        </tr>
                        
                         <%   } }
                                } catch (SQLException ex) {
                                    ex.printStackTrace();
                                 }finally {
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
        <% } %>
    </body>
</html>
