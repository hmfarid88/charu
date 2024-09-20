
<%@page import="java.sql.SQLException"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Charu</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/jquery-ui.css">
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
            String date1 = request.getParameter("date1");
            request.getSession().setAttribute("date1", date1);
            
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
            ResultSet rs10 = null;
            ResultSet rs11 = null;

            try {
                con = Database.getConnection();
                String query = "select AMOUNT, DATE from netbalance where DATE<'" + date1 + "' order by SI_NO DESC LIMIT 1";
                ps = con.prepareStatement(query);
                rs = ps.executeQuery();
                rs.next();
                request.setAttribute("date", rs.getString("DATE"));
                request.setAttribute("amount", rs.getDouble("AMOUNT"));

                String query1 = "select DEBIT_NAME, AMOUNT, DATE from cash_debit where DATE= '" + date1 + "'"
                        + "UNION ALL select RETAILER, AMOUNT, DATE from customer_pay where DATE ='" + date1 + "'"
                        + "UNION ALL select PAY_NAME, RECEIVE, DATE from proprietor_cost where DATE= '" + date1 + "' and PAY_NAME='Receive'";
                ps = con.prepareStatement(query1);
                rs1 = ps.executeQuery();

                String query2 = "select CREDIT_NAME, AMOUNT, DATE from cash_credit where DATE= '" + date1 + "'"
                        + "UNION ALL select COMPANY_NAME, AMOUNT, DATE from company_payment where DATE = '" + date1 + "'"
                        + "UNION ALL select COST_NAME, AMOUNT, DATE from cost where DATE = '" + date1 + "'"
                        + "UNION ALL select TRANSPORT_NAME, PAYMENT, DATE from transport_pay where DATE='" + date1 + "'"
                        + "UNION ALL select EMP_NAME,  AMOUNT, DATE from emp_cost where DATE= '" + date1 + "'"
                        + "UNION ALL select PAY_NAME, PAYMENT, DATE from proprietor_cost where DATE ='" + date1 + "'  and PAY_NAME='Payment'";
                ps = con.prepareStatement(query2);
                rs2 = ps.executeQuery();

                String query3 = "select sum(AMOUNT) from customer_pay where DATE = '" + date1 + "'";
                ps = con.prepareStatement(query3);
                rs3 = ps.executeQuery();
                rs3.next();
                request.setAttribute("tcpay", rs3.getDouble(1));

                String query4 = "select sum(AMOUNT) from cash_debit where DATE ='" + date1 + "' ";
                ps = con.prepareStatement(query4);
                rs4 = ps.executeQuery();
                rs4.next();
                request.setAttribute("tdebit", rs4.getDouble(1));

                String query5 = "select sum(AMOUNT) from cash_credit where DATE= '" + date1 + "' ";
                ps = con.prepareStatement(query5);
                rs5 = ps.executeQuery();
                rs5.next();
                request.setAttribute("tcredit", rs5.getDouble(1));

                String query6 = "select sum(AMOUNT) from company_payment where DATE = '" + date1 + "' ";
                ps = con.prepareStatement(query6);
                rs6 = ps.executeQuery();
                rs6.next();
                request.setAttribute("tpay", rs6.getDouble(1));
                
                String query7 = "select sum(AMOUNT) from cost where DATE = '" + date1 + "' ";
                ps = con.prepareStatement(query7);
                rs7 = ps.executeQuery();
                rs7.next();
                request.setAttribute("tcost", rs7.getDouble(1));
                
                String query8 = "select sum(PAYMENT) from transport_pay where DATE= '" + date1 + "'";
                ps = con.prepareStatement(query8);
                rs8 = ps.executeQuery();
                rs8.next();
                request.setAttribute("ttpay", rs8.getDouble(1));
                
                String query9 = "select sum(AMOUNT) from emp_cost where DATE = '" + date1 + "'";
                ps = con.prepareStatement(query9);
                rs9 = ps.executeQuery();
                rs9.next();
                request.setAttribute("empcost", rs9.getDouble(1));
                
                String query10 = "select sum(RECEIVE) from proprietor_cost where DATE= '" + date1 + "' ";
                    ps = con.prepareStatement(query10);
                    rs10 = ps.executeQuery();
                    rs10.next();
                    request.setAttribute("prorecv", rs10.getDouble(1));
                    
            String query11 = "select sum(PAYMENT) from proprietor_cost where DATE = '" + date1 + "'";
            ps = con.prepareStatement(query11);
            rs11 = ps.executeQuery();
            rs11.next();
            request.setAttribute("propay", rs11.getDouble(1));
         Double totalreceive=rs.getDouble(1)+rs3.getDouble(1)+rs4.getDouble(1)+rs10.getDouble(1);
         Double totalpayment=rs5.getDouble(1)+rs6.getDouble(1)+rs7.getDouble(1)+rs8.getDouble(1)+rs9.getDouble(1)+rs11.getDouble(1);
         Double nbl=totalreceive-totalpayment;
         String balanceup="update netbalance set AMOUNT=? where DATE=?";
                ps=con.prepareStatement(balanceup);
                ps.setDouble(1, nbl);
                ps.setString(2, date1);
                ps.executeUpdate();
        %>
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
                        <h3 style="font-family: fontawaesome" class="text-primary text-center"><b>Cash-Book</b></h3>
                        <h5><b>Date : ${date1}</b></h5>
                        <table  border="2" width="90%" class="table-striped table-responsive" >
                            <thead>
                                <tr style=" background-color: #ccc">
                                    <th style="text-align: center">Date</th>
                                    <th style="text-align: center">Description</th>
                                    <th style="text-align: center">Debit Amount</th>
                                    <th style="text-align: center">Credit Amount</th>

                                </tr>
                            </thead>
                            <tbody>
                              
                                <tr>
                                    <th style="text-align: center">${date}</th>
                                    <th style="text-align: center">Balance B/D</th>
                                    <th style="text-align: center">${amount}</th>
                                    <td></td>
                                </tr>
                                <%
                                while(rs1.next()){
                                %>
                                <tr>
                                 <td style="text-align: center"><%= rs1.getString(3) %></td>
                                 <td style="text-align: center"><%= rs1.getString(1) %></td>
                                 <td style="text-align: center"><%= rs1.getFloat(2) %></td>
                                 <td style="text-align: center"></td>
                                </tr>
                                <%
                                  }
                                 while(rs2.next()){
                                %>
                                <tr>
                                 <td style="text-align: center"><%= rs2.getString(3) %></td>
                                 <td style="text-align: center"><%= rs2.getString(1) %></td>
                                 <td style="text-align: center"></td>
                                 <td style="text-align: center"><%= rs2.getFloat(2) %></td>
                                </tr>
                                                                
                                <% }
                        } catch (Exception ex) {
            } finally {
try { if (rs11 != null) rs11.close(); rs11=null; } catch (SQLException ex2) { }
try { if (rs10 != null) rs10.close(); rs10=null; } catch (SQLException ex2) { }
try { if (rs9 != null) rs9.close(); rs9=null; } catch (SQLException ex2) { }
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
                                <tr style="border-bottom-color: black">
                                    <th style="text-align: center;border-left-style: hidden"></th>
                                    <th style="text-align: center;border-left-style: hidden"></th>
                                    <th style="text-align: center;border-left-style: hidden"><u>${amount+tcpay+tdebit+prorecv}</u></th>
                                    <th style="text-align: center;border-left-style: hidden;border-right-style: hidden"><u>${tcredit+tpay+tcost+ttpay+empcost+propay}</u></th>
                                </tr>
                                <tr style="border-style: hidden">
                                    <th style="text-align: center;border-style: hidden"></th>
                                    <th style="text-align: center;border-style: hidden">Net Balance</th>
                                    <th style="text-align: center;border-style: hidden"><u>${(amount+tcpay+tdebit+prorecv)-(tcredit+tpay+tcost+ttpay+empcost+propay)}</u></th>
                                    <th style="text-align: center;border-style: hidden"></th>
                                </tr>
                            </tbody>
                        </table>

                    </center>
                </div>
            </div>

        </div>

        <br><br>
        <%@include file = "footerpage.jsp" %>

        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        
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
