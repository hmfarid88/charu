
<%@page import="Model.DeleteModel"%>
<%@page import="Pojo.DeletePojo"%>
<%@page import="Model.EmpModel"%>
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
                                <li><a data-toggle="modal" data-target="#exdelete" href="#">Delete Item</a></li>
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
                        <h3><b>Employee's Expense Info</b></h3>
                        <center><h4><div id="date"> </div> </h4></center>
                    </center>
                    <table border="2" width="100%" class="table-condensed table-responsive">
                        <thead>
                            <tr style="background-color: #CCCCCC">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Employee Name</th>
                                <th style="text-align: center">Limit</th>
                                <th style="text-align: center">Expense</th>
                                <th style="text-align: center">Balance</th>
                                <th style="text-align: center">Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            AccountPojo ap=new AccountPojo();
                            List<EmpModel> list=ap.EmpExpense();
                            for(EmpModel em: list){
                            %>
                            <tr>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= em.getEmpname() %> (<%= em.getDegination() %>)</td>
                                <td style="text-align: center"><%= em.getLimit() %></td>
                                <td style="text-align: center"><%= em.getExpense() %></td>
                                <td style="text-align: center"><%= em.getBalance() %></td>
                                <td style="text-align: center">
                                    <form method="POST" action="monthly_emp_expense.jsp">
                                        <input type="hidden" name="empname" value="<%= em.getEmpname() %>" > 
                                        <input type="hidden" name="desiganation" value="<%= em.getDegination() %>" > 
                                        <input type="hidden" name="expense" value="<%= em.getExpense() %>" > 
                                        <input type="submit"  value="Details">
                                    </form>
                                </td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                    </div>
                </div>
            </div>
        </div>
       <div id="exdelete" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Expense Delete</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="EmpcostdelServlet" class="form-inline">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <select  style=" width: 80%" class="form-control input-sm" name="empsi" required="">
                                           <option value="">Select Expense</option>  
                                            <%
                                                DeletePojo dp = new DeletePojo();
                                                List<DeleteModel> list1 = dp.EmpcostDel();
                                                for (DeleteModel dm : list1) {
                                            %>
                                            <option value="<%= dm.getEmpsi() %>"><%= dm.getEmpname() %>, <%= dm.getEmpcost() %>, <%= dm.getEmpamount() %></option>
                            
                                            <% } %>` 
                                        </select>
                                    <input type="submit" class="btn btn-success btn-sm" value="Delete">
                                    </div>
                                   
                                </div>
                                
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
        <br><br>
        <%@include file = "footerpage.jsp" %>
        
        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/vendor/modernizr-2.8.3.min.js"></script>
        <script>
        window.onload = function () {
        var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
                                            ;
        var date = new Date();

        document.getElementById('date').innerHTML = months[date.getMonth()] + ' ' + date.getFullYear();
                                        };
        </script>
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
