
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
        int month=Integer.parseInt(request.getParameter("month"));
        int year=Integer.parseInt(request.getParameter("year"));
        request.setAttribute("year", year);
        Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                ResultSet rs1 = null;
                ResultSet rs2 = null;
                ResultSet rs3 = null;
                ResultSet rs4 = null;
                try {
                    con = Database.getConnection();
                    String query = "select SI_NO, FACTORY_NAME, AMOUNT from fac_commission where YEAR=? AND MONTH=? order by FACTORY_NAME";
                    ps = con.prepareStatement(query);
                    ps.setInt(1, year);
                    ps.setInt(2, month);
                    rs=ps.executeQuery();

                    String query1 = "select sum(AMOUNT) from fac_commission where YEAR=? AND MONTH=?";
                    ps = con.prepareStatement(query1);
                    ps.setInt(1, year);
                    ps.setInt(2, month);
                    rs1=ps.executeQuery();
                    rs1.next();
                    request.setAttribute("totalcomi", rs1.getDouble(1));
                    
                    String query2 = "select FACTORY_NAME, COM_NAME, AMOUNT, START_DATE, END_DATE, DATE from fac_commission where YEAR=? AND MONTH=? order by FACTORY_NAME";
                    ps = con.prepareStatement(query2);
                    ps.setInt(1, year);
                    ps.setInt(2, month);
                    rs2=ps.executeQuery();
                    
                    String query3 = "select MONTHNAME(END_DATE) from fac_commission where YEAR(END_DATE) = '"+ year +"' AND MONTH(END_DATE) = '"+ month +"'";
                    ps = con.prepareStatement(query3);
                    rs3=ps.executeQuery();
                    rs3.next();
                    request.setAttribute("mnth", rs3.getString(1));
                    
                    String query4 = "select SI_NO, FACTORY_NAME, AMOUNT from fac_commission where YEAR=? AND MONTH=? order by FACTORY_NAME";
                    ps = con.prepareStatement(query4);
                    ps.setInt(1, year);
                    ps.setInt(2, month);
                    rs4=ps.executeQuery();
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
                            <li><a href="#" data-toggle="modal" data-target="#faccomup">Update</a></li>
                           
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                        </ul> 
                    </div>
                </nav>
            </header>
       <div id="faccomup" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
               
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="FacComUpServlet">
                                <select class="form-control input-sm" name="facsi" required="" style="width: 60%">
                                        <option value="">Select Factory</option>
                                        <% 
                                        while(rs.next()){
                                        %>
                                        <option value="<%= rs.getInt(1) %>"><%= rs.getString(2) %> (<%= rs.getFloat(3) %>)</option>
                                        <% } %>
                                    </select> <br>
                                   <label>Set Amount</label><br>
                                    <input type="text" name="amount" class="form-control input-sm" required="" style="width: 60%"><br>
                                    <input type="submit" class="btn btn-info btn-sm" value="Update">
                            </form><hr>
                                    <form method="POST" action="FacComDelServlet">
                                        <select class="form-control input-sm" name="facsi" required="" style="width: 60%">
                                        <option value="">Select Factory</option>
                                        <% 
                                        while(rs4.next()){
                                        %>
                                        <option value="<%= rs4.getInt(1) %>"><%= rs4.getString(2) %> (<%= rs4.getFloat(3) %>)</option>
                                        <% } %>
                                    </select> <br>
                                    <input type="submit" class="btn btn-danger btn-sm" value="Delete">
                                    </form>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>
            <div id="div_print">
                <center><h2><b>CHARU ENTERPRISE</b></h2>
                    <h3>Factory Commission Report</h3>
                    <center><h4>${mnth} ${year}</h4></center>
                </center>
                <table border="2" width="100%" class="table-striped table-responsive">
                    <thead>
                        <tr style="background-color: #CCC">
                            <th style="text-align: center">SN</th>
                            <th style="text-align: center">Factory Name</th>
                            <th style="text-align: center">Target Name</th>
                            <th style="text-align: center">Duration</th>
                            <th style="text-align: center">Amount</th>
                            <th style="text-align: center">Entry Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        while(rs2.next()){
                        %>
                        <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= rs2.getString(1) %></td>
                            <td style="text-align: center"><%= rs2.getString(2) %></td>
                            <td style="text-align: center"><%= rs2.getString(4) %> To <%= rs2.getString(5) %></td>
                            <td style="text-align: center"><%= rs2.getFloat(3) %></td>
                            <td style="text-align: center"><%= rs2.getString(6) %></td>
                           
                        <% } 
                        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }  
try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                        %>
                        <tr style="background-color: #CCC">
                            <th style="text-align: center"></th>
                            <th style="text-align: center"></th>
                            <th style="text-align: center"></th>
                            <th style="text-align: center">TOTAL</th>
                            <th style="text-align: center">${totalcomi}</th>
                            <th style="text-align: center"></th>
                        </tr>
                    </tbody>
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
