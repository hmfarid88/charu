
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
                            <li><a href="#" data-toggle="modal" data-target="#enduser">Add-User</a></li>
                            <li><a href="#" data-toggle="modal" data-target="#enddelete">Delete-User</a></li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                        </ul> 
                    </div>
                </nav>
            </header>

            <div id="div_print">
               <center><h2><b>CHARU ENTERPRISE</b></h2>
                    <h3>End-User List</h3>
                    <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                </center> 
                 <table  border="2" width="100%" class="table-condensed table-responsive">
                    <thead>
                        <tr style="background-color: #CCC">
                            <th style="text-align: center">SN</th>
                            <th style="text-align: center">User Name</th>
                            <th style="text-align: center">Mobile No</th>
                            <th style="text-align: center">Address</th>
                            <th style="text-align: center">Engineer</th>
                            <th style="text-align: center">Contractor</th>
                            <th style="text-align: center">Status</th>
                            <th style="text-align: center">Cause</th>
                            <th style="text-align: center">Remark</th>
                            <th style="text-align: center">Edit</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        AccountPojo ap=new AccountPojo();
                        List<EmpModel> list=ap.Enduser();
                        for(EmpModel em:list){
                        %>
                        <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= em.getEndname() %></td>
                            <td style="text-align: center"><%= em.getEndmob() %></td>
                            <td style="text-align: center"><%= em.getEndadd() %></td>
                            <td style="text-align: center"><%= em.getEngname() %></td>
                            <td style="text-align: center"><%= em.getContact() %></td>
                            <td style="text-align: center"><%= em.getStatus() %></td>
                            <td style="text-align: center"><%= em.getCause() %></td>
                            <td style="text-align: center"><%= em.getEnddate() %></td>
                            <td style="text-align: center">
                                <form method="POST" action="enduser_update.jsp">
                                    <input type="hidden" name="sino" value="<%= em.getEndsi() %>">
                                    <input type="submit" value="...">
                                </form>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                 </table>
            </div>
        </div>
        <div id="enduser" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">End User-Info</h4>
                </div>
                <div class="modal-body">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Add-End User</legend>
                        <div class="container-fluid">
                            <form method="POST" action="EndUser_Servlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Name :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="name" required="" >
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Mobile Number :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="mnumber" required="" >
                                    </div>
                                </div><br>

                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Address :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="address" required="" >
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Engineer Name :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="engname"  required="" >
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Contractor Name :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="contname" required="" >
                                    </div>
                                    
                                </div><br>
                                
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Status (Using our cement or not):</label><br>
                                        <input  type="radio"  value="Yes" name="status"  required="" > <label>Yes</label>
                                        <input  type="radio"  value="No" name="status" id="no"  required="" > <label>No</label>
                                        <div id="cause">
                                        <label>Cause</label>
                                        <textarea rows="3" cols="17" name="cause"></textarea>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Remark :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="remark" required="" >
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <input type="submit"  class="btn btn-success btn-sm" value="Add"> 
                                        <input type="reset"  class="btn btn-info btn-sm" value="Reset"> 
                                    </div>
                                </div>

                            </form>
                        </div>

                    </fieldset>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>
    <div id="enddelete" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">End-User Delete</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="EnddelServlet" class="form-inline">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <select  style=" width: 80%" class="form-control input-sm" name="endsi" required="">
                                           <option value="">Select End-User</option>  
                                            <%
                                                DeletePojo dp = new DeletePojo();
                                                List<DeleteModel> list1 = dp.EndDel();
                                                for (DeleteModel dm : list1) {
                                            %>
                                            <option value="<%= dm.getEndsi() %>"><%= dm.getEnduser() %>, <%= dm.getEndaddress() %></option>
                            
                                            <%}%>` 
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
        $(document).ready(function () {
            $('#cause').hide();
            $('input[type=radio]').change(function () {
                if ($('#no').is(':checked')) {
                    $('#cause').show();
                } else {
                    $('#cause').hide();
                }
            });
        });
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
