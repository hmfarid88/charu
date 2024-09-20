
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
        <link  href="css/jquery.dataTables.min.css" rel="stylesheet">
       <link  href="css/dataTables.bootstrap.min.css" rel="stylesheet">
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
            String retailer = request.getParameter("retailer");
            request.setAttribute("retailer", retailer);
            String date1 = request.getParameter("date1");
            String date2 = request.getParameter("date2");
            request.setAttribute("date1", date1);
            request.setAttribute("date2", date2);
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            ResultSet rs1 = null;
            ResultSet rs2 = null;
            try {
                con = Database.getConnection();
                String query = "select PRODUCT_NAME, QTY, RATE, PAYMENT, COMMISSION, COMI_NOTE, SP_NAME, DATE, NOTE, PAY_NOTE, SI_NO from order_delevery where DATE between '" + date1 + "' and '" + date2 + "' and ORDER_NAME=?";
                ps = con.prepareStatement(query);
                ps.setString(1, retailer);
                rs = ps.executeQuery();
                String query1 = "select sum(QTY), sum(QTY*RATE), sum(PAYMENT), sum(COMMISSION) from order_delevery where DATE between '" + date1 + "' and '" + date2 + "' and ORDER_NAME=?";
                ps = con.prepareStatement(query1);
                ps.setString(1, retailer);
                rs1 = ps.executeQuery();
                rs1.next();
                request.setAttribute("tqty", rs1.getInt(1));
                request.setAttribute("total", rs1.getDouble(2));
                request.setAttribute("totalpay", rs1.getDouble(3));
                request.setAttribute("totalcomi", rs1.getLong(4));
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
                            <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                        </ul> 
                    </div>
                </nav>
            </header>
            
            <div class="row">
                <div class="col-sm-12">
                    <div id="div_print">
                        <center>
                            <h3><b>Retailer Ledger</b></h3>
                            <h4> Retailer Name : ${retailer}</h4>
                            <center><h4> Date : ${date1} TO ${date2}</h4></center>
                            </center>
                            <table id="datatable" border="2" width="100%" class="table-striped table-responsive">
                            <thead>
                                <tr style="background-color: #CCCCCC">
                                    <th style="text-align: center">Date</th>
                                    <th style="text-align: center">Qty</th>
                                    <th style="text-align: center">Rate</th>
                                    <th style="text-align: center">Product</th>
                                    <th style="text-align: center">Note</th>
                                    <th style="text-align: center">Total</th>
                                    <th style="text-align: center">Payment</th>
                                    <th style="text-align: center">Commission</th>
                                    <th style="text-align: center">Percent</th>
                                    <th style="text-align: center">Balance</th>
                                    <th style="text-align: center">S.P Name</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    while (rs.next()) {
                                        int sino=rs.getInt("SI_NO");
               String pay="select sum(QTY*RATE),  sum(PAYMENT), sum(COMMISSION) from order_delevery where ORDER_NAME=? and SI_NO<?";
               ps = con.prepareStatement(pay);
                ps.setString(1, retailer);
                ps.setInt(2, sino);
                rs2 = ps.executeQuery();
                while(rs2.next()){
                                %>
                                <tr>
                                    <td style="text-align: center"><%= rs.getString("DATE")%> </td>
                                    <td style="text-align: center"><%= rs.getInt("QTY") %></td>
                                    <td style="text-align: center"><%= rs.getFloat("RATE") %></td>
                                    <td style="text-align: center"><%= rs.getString("PRODUCT_NAME")%></td>
                                    <td style="text-align: center"><%= rs.getString("NOTE")%></td>
                                    <td style="text-align: center"><%= rs.getInt("QTY")*rs.getFloat("RATE") %></td>
                                    <td style="text-align: center"><%= rs.getDouble("PAYMENT") %> (<%= rs.getString("PAY_NOTE")%>)</td>
                                    <td style="text-align: center"><%= rs.getDouble("COMMISSION") %> (<%= rs.getString("COMI_NOTE") %>)</td>
                                    <td style="text-align: center"><%= rs.getDouble("PAYMENT")*100/(rs.getInt("QTY")*rs.getFloat("RATE")) %> %</td>
                                    <td style="text-align: center"><%= (rs2.getLong(1)-(rs2.getLong(2)+rs.getLong(4)+rs.getLong(5)+rs2.getLong(3)))+(rs.getInt(2)*rs.getFloat(3)) %></td>
                                    <td style="text-align: center"><%= rs.getString("SP_NAME") %></td>
                                </tr>
                                <% }} %>
                                <tr style="background-color: #CCC">
                                    <th style="text-align: center">TOTAL</th>
                                    <th style="text-align: center">${tqty} Ps</th>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center">${total} TK</th>
                                    <th style="text-align: center">${totalpay} TK</th>
                                    <th style="text-align: center">${totalcomi} TK</th>
                                    <th style="text-align: center">${(totalpay*100)/total} %</th>
                                    <th style="text-align: center">${total-(totalpay+totalcomi)} TK</th>
                                    <th style="text-align: center"></th>
                                </tr>
                            </tbody>
                        </table><br>
                                                                                
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
        <script src="js/jquery.dataTables.min.js"></script>
        <script src="js/dataTables.bootstrap.min.js"></script>   
     <script>
		$(document).ready(function() {
			$('#datatable').DataTable({
				"lengthMenu":[[20,50,100,150,200,-1],[20,50,100,150,200,"All"]],
				"ordering":false,
				stateSave:true
			});
			
			$("#datatable").on('page.dt', function() {
				$('html, body').animate({
					scrollTop: $('#datatable').offset().top
				}, 200);
			});
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
