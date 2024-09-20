
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
            String date1 = request.getParameter("date1");
            String date2 = request.getParameter("date2");
            request.setAttribute("date1", date1);
            request.setAttribute("date2", date2);
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                con = Database.getConnection();
                String query = "select RETAILER, PAY_TYPE, AMOUNT, COLLECTED_BY, NOTE, BANK_NAME, BRANCH, PAYER, DATE, SI_NO from customer_pay where DATE between '" + date1 + "' and '" + date2 + "'";
                ps = con.prepareStatement(query);
                rs = ps.executeQuery();
                
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
            <h3 class="text-center"><b>CHARU  ENTERPRISE</b></h3> 
            <h3 class="text-center">Retailer Payment Ledger</h3> 
            <center><h5><b>Date : ${date1} TO ${date2} </b></h5></center>
            <table border="2" id="datatable" width="100%" class="table-striped table-responsive">
                <thead>
                    <tr style="background-color: #CCC">
                        <th style="text-align: center">SN</th>
                        <th style="text-align: center">Date</th>
                        <th style="text-align: center">Retailer</th>
                        <th style="text-align: center">Pay Type</th>
                        <th style="text-align: center">Amount</th>
                        <th style="text-align: center">Collected By</th>
                        <th style="text-align: center">Bank Name</th>
                        <th style="text-align: center">Branch</th>
                        <th style="text-align: center">Payer</th>
                        <th style="text-align: center">Edit</th>
                    </tr>
                </thead> 
                <tbody>
                    <%
                       while(rs.next()){
                    %>
                    <tr>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"><%= rs.getString(9)%></td>
                        <td style="text-align: center"><%= rs.getString(1) %> (<%= rs.getString(5) %>)</td>
                        <td style="text-align: center"><%= rs.getString(2)%></td>
                        <td style="text-align: center"><%= rs.getFloat(3)%></td>
                        <td style="text-align: center"><%= rs.getString(4)%></td>
                        <td style="text-align: center"><%= rs.getString(6)%></td>
                        <td style="text-align: center"><%= rs.getString(7)%></td>
                        <td style="text-align: center"><%= rs.getString(8)%></td>
                        <td style="text-align: center">
                            <form  method="POST" action="RtpSelectServlet" class="form-inline">
                                <input type="hidden" value="<%= rs.getInt("SI_NO")%>" name="rpsi">
                                <button  type="submit"><i class="fa fa-edit"></i></button>
                            </form>
                        </td>
                    </tr>
                    <% }
                      } catch (SQLException ex) {
                                    ex.printStackTrace();
                                } finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                }
                    %>

                </tbody>

            </table>
        </div>
    </div>

    <br><br>
    <%@include file = "footerpage.jsp" %>
    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
     <script src="js/jquery.dataTables.min.js"></script>
     <script src="js/dataTables.bootstrap.min.js"></script>        
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
    <% }%>
</body>
</html>
