
<%@page import="java.sql.SQLException"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.DeleteModel"%>
<%@page import="Pojo.DeletePojo"%>
<%@page import="Model.Accountant"%>
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
                                <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul> 
                        </div>
                    </nav>
                </header>

                <div id="div_print" style="font-family: fontawesome">
                    <center><h2><b>CHARU ENTERPRISE</b></h2>
                        <h3>Date wise Transport Ledger</h3>
                        <h4>Date: ${param.date1} TO ${param.date2}</h4>
                    </center>

                    <table  border="2" width="100%" class="table-condensed table-responsive">
                        <thead>
                            <tr style="background-color: #CCC">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Transport</th>
                                <th style="text-align: center">Qty</th>
                                <th style="text-align: center">Rent</th>
                                <th style="text-align: center">Payment</th>
                                <th style="text-align: center">Percent</th>
                                <th style="text-align: center">Balance</th>
                                <th style="text-align: center">Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                               String date1 = request.getParameter("date1");
                               String date2 = request.getParameter("date2");
                               Connection con = null;
                               PreparedStatement ps = null;
                               ResultSet rs = null;
                               ResultSet rs1 = null;
                               Long num=1l;                               
                               try {
            con = Database.getConnection();
            String tname="select TRANSPORT_NAME from transport_name";
            ps = con.prepareStatement(tname);
            rs = ps.executeQuery();
            while (rs.next()) {
            String transport=rs.getString(1);
           
             String query1 = "select sum(QTY), sum(RENT), sum(PAYMENT) from transport_pay where  TRANSPORT_NAME=? and DATE between '"+date1+"' and  '"+date2+"'";
            ps = con.prepareStatement(query1);
            ps.setString(1, transport);
            rs1 = ps.executeQuery();
            while (rs1.next()) {
               request.setAttribute("totalqty", rs1.getInt(1));
               request.setAttribute("totalpay", rs1.getLong(3));
                Long totalrent=rs1.getLong(2);
                if(totalrent<1){
                request.setAttribute("totalrnt", num);
            }else{
             request.setAttribute("totalrnt", rs1.getLong(2));
            }
                            %>
                            <tr>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= rs.getString(1) %></td>
                                <th style="text-align: center"><%= rs1.getInt(1) %></th>
                                <th style="text-align: center"><%= rs1.getLong(2) %></th>
                                <th style="text-align: center"><%= rs1.getLong(3) %></th>
                                <td style="text-align: center">${totalpay*100/totalrnt} %</td>
                                <th style="text-align: center"><%= rs1.getLong(2)-rs1.getLong(3) %></th>
                                <td style="text-align: center">
                                    <form method="POST" action="datewise_transportLedger.jsp">
                                        <input type="hidden" name="date1" value="${param.date1}">
                                        <input type="hidden" name="date2" value="${param.date2}">
                                        <input type="hidden" name="transport" value="<%= rs.getString(1) %>">
                                        <input type="submit" value="Details">
                                    </form>
                                </td>
                            </tr>
                            <%
                             } }
            }catch (SQLException ex) {
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
                             <th style="text-align: center">TOTAL</th>
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
        }  });
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
