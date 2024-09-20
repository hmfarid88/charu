
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
            <div id="div_print">
            <div class="row">
                <div class="col-sm-12">
                    <center>
                        <h3 style="font-family: fontawesome"><b>Retailer's Info</b></h3>
                        
                        <form method="post" action="RetailerDelServlet">
                    <table  border="2" width="80%" class="table-striped table-responsive">
<%
        String retailer=request.getParameter("retailer");
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select R_NAME, PRO_NAME, THANA, ZILLA, AREA, MAN_NAME, M_NUMBER ,D_O_B, D_O_M, SR_NAME from retailer_info where R_NAME=?";
            ps = con.prepareStatement(query);
            ps.setString(1, retailer);
            rs = ps.executeQuery();
            rs.next();
            request.setAttribute("rtname", rs.getString(1));
%>
                      <tr><th style="text-align: center">Retailer Name</th><td><input type="hidden" name="oldretailer" value="<%= rs.getString("R_NAME") %>"><input type="text" name="retailer" value="<%= rs.getString("R_NAME") %>" class="form-control"></td></tr>
                        <tr><th style="text-align: center">Proprietor</th><td><input type="text" name="proprietor" value="<%= rs.getString("PRO_NAME") %>" class="form-control"></td></tr>
                        <tr><th style="text-align: center">Thana</th><td><input type="text" name="thana" value="<%= rs.getString("THANA") %>" class="form-control"></td></tr>
                        <tr><th style="text-align: center">Zilla</th><td><input type="text" name="zilla" value="<%= rs.getString("ZILLA") %>" class="form-control"></td></tr>
                        <tr><th style="text-align: center">Area</th><td><input type="text" name="area" value="<%= rs.getString("AREA") %>" class="form-control"></td></tr>
                        <tr><th style="text-align: center">Manager Name</th><td><input type="text" name="manager" value="<%= rs.getString("MAN_NAME") %>" class="form-control"></td></tr>
                        <tr><th style="text-align: center">Mobile Number</th><td><input type="text" name="mobile" value="<%= rs.getString("M_NUMBER") %>" class="form-control"></td></tr>
                        <tr><th style="text-align: center">Birth Day</th><td><input type="text" name="bday" value="<%= rs.getString("D_O_B") %>" class="form-control"></td></tr>
                        <tr><th style="text-align: center">Marriage Day</th><td><input type="text" name="mday" value="<%= rs.getString("D_O_M") %>" class="form-control"></td></tr>
                        <tr><th style="text-align: center">Sale Person</th><td><input type="text" name="sp" value="<%= rs.getString("SR_NAME") %>" class="form-control"></td></tr>
                        <tr><th style="text-align: center">Type</th><td> <input type="radio" name="type" value="Active" required=""> Make as Active 
                            <input type="radio" name="type" value="Deactive" required=""> Make as De-active</td></tr>
                        <%
                        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                        %>
                    </table><br>
                    <input type="submit" value="Update" class=" btn btn-primary">
                        </form>
                    <br><h4>Previous SR Name Change</h4>
                    <form method="post" action="datewise_sr_change">
                        <input type="hidden" name="rtname" value="${rtname}">
                        <label>SR Name</label>
                        <input type="text" name="srname" class="form-control" style="width: 200px" required=""><br>
                        <input type="date" name="date1" class="form-control" style="width: 200px" required=""> TO 
                        <input type="date" name="date2" class="form-control" style="width: 200px" required=""><br>
                        <input type="submit" class="btn btn-success" value="Update">
                        
                    </form>
</center>
                </div>
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
