
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
            <%
                String sino =request.getParameter("sino");
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    con = Database.getConnection();
                    String query = "select * from end_user where SI_NO="+sino;
                    ps = con.prepareStatement(query);
                    rs = ps.executeQuery();
                    rs.next();
                    request.setAttribute("userno", rs.getInt(1));
                    request.setAttribute("name", rs.getString(2));
                    request.setAttribute("mobile", rs.getString(3));
                    request.setAttribute("address", rs.getString(4));
                    request.setAttribute("eng", rs.getString(5));
                    request.setAttribute("conct", rs.getString(6));
                    request.setAttribute("status", rs.getString(7));
                    request.setAttribute("cause", rs.getString(8));
                    request.setAttribute("remark", rs.getString(9));
                  }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}  
            %>
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <div id="div_print">
                        <center><h2><b>CHARU ENTERPRISE</b></h2>
                            <h3>End-User Info Update</h3>

                        </center> 

                        <form method="POST" action="EndUserUpdate_Servlet">
                            <div class="row">
                                <div class="col-sm-6">
                                    <label>Name :</label>
                                    <input type="hidden" name="userid" value="${userno}" >
                                    <input  type="text" class="form-control input-sm" value="${name}" name="name" required="" >
                                </div>
                                <div class="col-sm-6">
                                    <label>Mobile Number :</label>
                                    <input  type="text" class="form-control input-sm" value="${mobile}" name="mnumber" required="" >
                                </div>
                            </div><br>

                            <div class="row">
                                <div class="col-sm-12">
                                    <label>Address :</label>
                                    <input  type="text" class="form-control input-sm" value="${address}" name="address" required="" >
                                </div>
                            </div><br>
                            <div class="row">
                                <div class="col-sm-6">
                                    <label>Engineer Name :</label>
                                    <input  type="text" class="form-control input-sm" value="${eng}" name="engname"  required="" >
                                </div>
                                <div class="col-sm-6">
                                    <label>Contractor Name :</label>
                                    <input  type="text" class="form-control input-sm" value="${conct}" name="contname" required="" >
                                </div>

                            </div><br>

                            <div class="row">
                                <div class="col-sm-6">
                                    <label>Status (Using our cement or not):</label><br>
                                    <input type="text" class=" form-control input-sm" name="status" value="${status}" readonly="" ><br>
                                    <input  type="radio"  value="Yes" name="status" > <label>Yes</label>
                                    <input  type="radio"  value="No" name="status" id="no" > <label>No</label>
                                    <div id="cause">
                                        <label>Cause</label><br>
                                        <textarea rows="3" cols="17" name="cause">${cause}</textarea>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label>Remark :</label>
                                    <input  type="text" class="form-control input-sm" value="${remark}" name="remark" required="" >
                                </div>
                            </div><br>
                            <div class="row">
                                <div class="col-sm-6">
                                    <input type="submit"  class="btn btn-success btn-sm" value="Update"> 
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
                <div class="col-sm-2"></div>
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
