
<%@page import="java.sql.SQLException"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
                <h4>Date: ${param.date1} to ${param.date2}</h4>
            </center>

            <table  border="2" width="100%" class="table-condensed table-responsive">
                <thead>
                   
                    <tr style="background-color: #CCC">
                        <th style="text-align: center">SN</th>
                        <th style="text-align: center">Retailer</th>
                        <th style="text-align: center">Number</th>
                        <th style="text-align: center">Total Delivery</th>
                        <th style="text-align: center">Total Value</th>
                        <th style="text-align: center">Total Payment</th>
                        <th style="text-align: center">Total Commission</th>
                        <th style="text-align: center">Balance</th>
                        <th style="text-align: center">S.P Name</th>
                        <th style="text-align: center">Percent</th>
                        <th style="text-align: center">Details</th>                   
                    </tr>
                </thead>
                <tbody id="myTable">
                    <%
        String date1=request.getParameter("date1");
        String date2=request.getParameter("date2");
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs2 = null;
        ResultSet rs3 = null;
        Long num=1l;       
        try {
            con = Database.getConnection();
            String queryretiler="select R_NAME from retailer_info where TYPE='Active' order by R_NAME";
            ps = con.prepareStatement(queryretiler);
            rs = ps.executeQuery();
          while(rs.next()){             
           String retailer=rs.getString("R_NAME");
            String emp="select distinct SP_NAME from order_delevery where ORDER_NAME=? and DATE between '"+ date1 +"' and '"+ date2 +"'";
            ps = con.prepareStatement(emp);
            ps.setString(1, retailer); 
            rs2 = ps.executeQuery(); 
            while(rs2.next()){
            String totaldel="select sum(QTY) as tqty, sum(QTY*RATE) as tvalue, sum(PAYMENT) as tpay, sum(COMMISSION) as tcomi from  order_delevery  where ORDER_NAME=? and DATE between '"+ date1 +"' and '"+ date2 +"'";
            ps = con.prepareStatement(totaldel);
            ps.setString(1, retailer); 
            rs3 = ps.executeQuery(); 
            while(rs3.next()){
                
                request.setAttribute("totalqty", rs3.getLong("tqty"));
                request.setAttribute("totalpay", rs3.getLong("tpay"));
                request.setAttribute("tcommi", rs3.getLong("tcomi"));
                Long tvalue=rs3.getLong("tvalue");
                if(tvalue<1){
                request.setAttribute("totalvalue", num);
            }else{
             request.setAttribute("totalvalue", rs3.getLong("tvalue"));
            }
                    %>
                    <tr>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"><%= rs.getString("R_NAME")%></td>
                        <th style="text-align: center">1</th>
                        <th style="text-align: center"><%= rs3.getLong("tqty")%></th>
                        <th style="text-align: center"><%= rs3.getLong("tvalue") %></th>
                        <th style="text-align: center"><%= rs3.getLong("tpay") %></th>
                        <th style="text-align: center"><%= rs3.getLong("tcomi") %></th>
                        <th style="text-align: center"><%= rs3.getLong("tvalue")-(rs3.getLong("tpay")+rs3.getLong("tcomi")) %></th>
                        <td style="text-align: center"><%= rs2.getString("SP_NAME")%></td>
                        <th style="text-align: center">${(totalpay*100)/totalvalue} %</th>
                        <td style="text-align: center">
                             <form method="POST" action="datewise_retLedger.jsp">
                                 <input type="hidden" name="date1" value="${param.date1}">
                                 <input type="hidden" name="date2" value="${param.date2}">
                                 <input type="hidden" name="retailer" value="<%= rs.getString("R_NAME")%>">
                                 <input type="submit" class="btn btn-success" value="Details">
                            </form>
                        </td>                
                    </tr>
                    
                    <% } } }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }   
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
                        <th style="text-align: center"></th>  
                        <td style="text-align: center"></td>
                        <th style="text-align: center"></th>                 
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
