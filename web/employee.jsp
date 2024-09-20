
<%@page import="java.sql.SQLException"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.Accountant"%>
<%@page import="java.util.List"%>
<%@page import="Model.StockModel"%>
<%@page import="Model.SaleModel"%>
<%@page import="Pojo.Profit"%>
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
        <link rel="stylesheet" href="css/normalize.css">
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="icon" type="image/png" href="img/favicon.ico">
    </head>
    <body style="background: linear-gradient(white, white); background-repeat: repeat-x;"  id="main">
         <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
        <header style="background: linear-gradient(black, black); background-repeat: repeat-x;">
            <center><img style="margin-top: 1%;" src="img/logo.png" title="Charu Enterprise"  class="img-responsive"><h1 style="font-family: serif;  font-size: 3vw; color: whitesmoke; text-shadow: 2px 2px 3px black; "><strong>M/S. CHARU  ENTERPRISE</strong></h1></center>
        </header>
    <center><h3 class="text-primary"><b>Employee-Area</b></h3></center>
    <div class="container-fluid">

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
                    <li><a href="retailer_pay_details_1.jsp">Payment-Info</a></li>
                    <li><a href="delivery_ledger_1.jsp">Delivery Ledger</a></li>
                    <li><a href="emp_sale.jsp">Employee Sale</a></li>  
                    <li><a data-toggle="modal" data-target="#empacinfo" href="#">Account-Info</a></li>
                    <li><a href="#" data-toggle="modal" data-target="#datetodate" >Date-To-Date</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><input style="margin-top: 10px" class="form-control input-sm" id="myInput" type="text" placeholder="Search..."></li>
                    <li><a id="lout" href="LogoutServlet"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                </ul> 
            </div>
        </nav>

        <div class="container-fluid">
            <div id="div_print" style="font-family: fontawesome">
                <center><h2><b>CHARU ENTERPRISE</b></h2>
                    <h3>Retailer Ledger</h3>
                    <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                </center>

               <table  border="2" width="100%" class="table-condensed table-responsive">
                <thead>
                    <tr style="background-color: #CCC">
                        <th style="text-align: center">SN</th>
                        <th style="text-align: center">Retailer</th>
                        <th style="text-align: center">Pending Order</th>
                        <th style="text-align: center">Last Delivery</th>
                        <th style="text-align: center">Total Delivery</th>
                        <th style="text-align: center">Total Value</th>
                        <th style="text-align: center">Total Payment</th>
                        <th style="text-align: center">Total Commission</th>
                        <th style="text-align: center">Percent</th>
                        <th style="text-align: center">Balance</th>
                        <th style="text-align: center">S.P Name</th>
                        <th style="text-align: center">Details</th>
                    </tr>
                </thead>
                <tbody id="myTable">
                    <%
                        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rss = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rs3 = null;
        ResultSet rs4 = null;       
        try {
            con = Database.getConnection();
            String queryretiler="select R_NAME from retailer_info where TYPE='Active' order by R_NAME";
            ps = con.prepareStatement(queryretiler);
            rs = ps.executeQuery();
            while (rs.next()) {
             String retailer=rs.getString(1);
             String lastrtlr="select MAX(SI_NO) from order_delevery group by ORDER_NAME";
             ps = con.prepareStatement(lastrtlr);
             rss = ps.executeQuery();
             while(rss.next()){
             Long maxsi=rss.getLong(1);
             
             String odquery="select sum(QUANTITY) from order_list where  RETAILER_NAME=?";
             ps=con.prepareStatement(odquery);
             ps.setString(1, retailer);
             rs1=ps.executeQuery();
             while(rs1.next()){
            String query = "select QTY, SP_NAME from order_delevery where  ORDER_NAME=?  and SI_NO=?";
            ps = con.prepareStatement(query);
            ps.setString(1, retailer);
            ps.setLong(2, maxsi);
            rs2 = ps.executeQuery();
            
            while(rs2.next()){
            
            String totaldel="select sum(QTY) as tqty, sum(QTY*RATE) as tvalue, sum(PAYMENT) as tpay, sum(COMMISSION) as tcomi from  order_delevery where  ORDER_NAME=?";
            ps = con.prepareStatement(totaldel);
            ps.setString(1, retailer); 
            rs3 = ps.executeQuery(); 
            while(rs3.next()){
              String qvpc="select sum(QTY) as tqty, sum(QTY*RATE) as tvalue, sum(PAYMENT) as tpay, sum(COMMISSION) as tcomi from  order_delevery where  ORDER_NAME=? and YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
              ps=con.prepareStatement(qvpc);
               ps.setString(1, retailer); 
            rs4 = ps.executeQuery(); 
            while(rs4.next()){
                Long tvalu=rs4.getLong("tvalue");
              Long num=1l;
            
            if(tvalu<1){
               tvalu=num;
            }
     
                    %>
                    <tr>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"><%= rs.getString(1) %></td>
                        <th style="text-align: center"><%= rs1.getInt(1) %></th>
                        <th style="text-align: center"><%= rs2.getInt(1) %></th>
                        <th style="text-align: center"><%= rs4.getInt("tqty") %></th>
                        <th style="text-align: center"><%= tvalu %></th>
                        <th style="text-align: center"><%= rs4.getLong("tpay") %></th>
                        <th style="text-align: center"><%= rs4.getLong("tcomi") %></th>
                        <td style="text-align: center"><%= rs4.getLong("tpay")*100/tvalu %> %</td>
                        <th style="text-align: center"><%= (rs3.getLong("tvalue")-rs3.getLong("tpay")-rs3.getLong("tcomi")) %></th>
                        <td style="text-align: center"><%= rs2.getString(2) %></td>
                        <td style="text-align: center">
                            <form method="POST" action="dtails_retLedger_1.jsp">
                                <input type="hidden" name="retailer" value="<%= rs.getString(1)%>">
                                <input type="submit" class="btn btn-success" value="Details">
                            </form>
                        </td>
                    </tr>
                    
                    <% }
}  } } }}
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
  try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
  try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rss != null) rss.close(); rss=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}%>
                    
                </tbody>
                <tfoot>
                   <tr style="background-color: black; color: white">
                        <th style="text-align: center"></th>
                        <th style="text-align: center">TOTAL</th>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <th style="text-align: center"></th>
                        <th style="text-align: center"></th>
                     </tr> 
                </tfoot>
            </table>
            </div>
        </div>       

        <div id="empacinfo" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Account-Info</h4>
                    </div>
                    <div class="modal-body">
                        <fieldset class="scheduler-border">
                            <legend class="scheduler-border">Update-Account</legend>
                            <form method="POST" action="EmpIdUpServlet">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Current-ID</label>
                                        <input type="text" class="form-control input-sm" name="cid" required="">
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Current-Password</label>
                                        <input type="password" class="form-control input-sm" name="cpass" required="">
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Phone Number</label>
                                        <input type="text" class="form-control input-sm" name="mnumber" required="">
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>New-ID</label>
                                        <input type="text" class="form-control input-sm" name="newid" required="">
                                    </div> 
                                    <div class="col-sm-6">
                                        <label>New-Password</label>
                                        <input type="password" class="form-control input-sm" name="newpass" required="">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="Update">
                            </form>
                        </fieldset>  

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                    </div>
                </div>  
            </div>
        </div>
       <div id="datetodate" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    
                </div>
                <div class="modal-body">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Date to Date</legend>
                     
                            <div class="row">
                                <div class="col-sm-12">
                                    <center>
                                   <form method="POST" action="datetodate_retailer_ledger_1.jsp" class="form-inline">
                                       <input type="date" name="date1" autocomplete="off" class="form-control input-sm" required="" ><br> to <br>
                                       <input type="date" name="date2" autocomplete="off" class="form-control input-sm" required="" ><br>
                                       <br> <input type="submit" class="btn btn-primary btn-sm" value="GO">
                                   </form> 
                                    </center>
                                </div>
                                
                            </div><br>
                         
                      
                    </fieldset>  

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
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
    
        <script>
                        $(document).ready(function () {
                            $("#lout").click(function () {

                                if (confirm("Are you sure to logout?"))
                                    document.forms[0].submit();
                                else
                                    return false;
                            });
                        });
        </script>
<% } %>
    </body>
</html>
