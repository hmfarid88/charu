
<%@page import="Model.StockModel"%>
<%@page import="Model.DeleteModel"%>
<%@page import="Pojo.DeletePojo"%>
<%@page import="Model.AdminModel"%>
<%@page import="Pojo.AdminPojo"%>
<%@page import="java.util.List"%>
<%@page import="Model.Accountant"%>
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
    <body style="background: linear-gradient(white, #ccc); background-repeat: repeat-x;"  id="main">
        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
    <header style="background: linear-gradient(white, lightblue); background-repeat: repeat-x;">
        <center><img style="margin-top: 1%;" src="img/logo.png" title="Charu Enterprise"  class="img-responsive"><h1 style="font-family: serif;  font-size: 3vw; color: green; text-shadow: 2px 2px 3px gold; "><strong>M/S. CHARU  ENTERPRISE</strong></h1></center>
    </header>
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
                        <li><a href="#" data-toggle="modal" data-target="#direcdeli"> Direct Delivery</a></li>
                        <li><a data-toggle="modal" data-target="#orderdel" href="#">Order Delete</a></li>
                       
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                    </ul> 
                </div>
            </nav>
        </header>
        <div class="row">

            <div class="col-sm-12">
                <div class="panel panel-primary">
                    <div class="panel-body">

                        <div class="row">
                            <div class="col-sm-2"></div> <div class="col-sm-4"> <label><b>Order List :</b></label>  </div>
                            <div class="col-sm-4"> 
                                <form method="POST" action="OrderShowServlet">
                                    <select style="width: 62%"  name="odsi" onchange="this.form.submit()" class="form-control input-sm" required="">
                                        <option value="">Select-Order</option>
                                        <%
                                            AccountPojo ap = new AccountPojo();
                                            List<Accountant> list = ap.OrderShow();
                                            for (Accountant ac : list) {
                                        %>
                                        <option value="<%= ac.getSi()%>"><%= ac.getRtname()%> (<%= ac.getProname()%>)</option>
                                        <%}%>
                                    </select> 
                                </form>
                            </div>
                            <div class="col-sm-2"></div>
                        </div><br>  
                        <form method="POST" action="OrderDeleveryServlet" class="form-inline">
                            <div class="row">
                                <div class="col-sm-2"></div>
                                <div class="col-sm-4">
                                    <label>Retailer Name :</label><br>
                                    <input type="hidden" name="sino" value="${SINO}">
                                    <input type="text" name="odname" class="form-control input-sm" value="${RTLER}" readonly="">
                                </div>
                                <div class="col-sm-4">
                                    <label>Note :</label><br>
                                    <input type="text" name="note"  class="form-control input-sm" value="" required="">
                                </div>
                                <div class="col-sm-2"></div>
                            </div><br>
                            <div class="row">
                                <div class="col-sm-2"></div>
                                <div class="col-sm-4">
                                    <label>Order Date</label><br>
                                    <input type="text" name="oddate" value="${DATE}" class="form-control input-sm" required="" readonly="">
                                </div> 
                                <div class="col-sm-4">
                                    <label>Product Name</label><br>
                                    <input type="text" name="proname" value="${PRONAME}" class="form-control input-sm" required="" readonly="">
                                    <input type="hidden" name="prono" value="${PRONO}" >
                                </div>
                                <div class="col-sm-2"></div>
                            </div><br>
                            <div class="row">
                                <div class="col-sm-2"></div>
                                <div class="col-sm-4">
                                    <label>Quantity</label><br>
                                    <input type="text" name="qty" value="${QNT}" class="form-control input-sm" required="" >
                                    <input type="hidden" name="prsrate" value="${PRSRATE}" >
                                </div>
                                <div class="col-sm-4">
                                    <label>Rate</label><br>
                                    <input type="text" name="rate" value="${SRATE}" class="form-control input-sm" required="" >
                                </div>
                                <div class="col-sm-2"></div>
                            </div><br>
                            <div class="row">
                                <div class="col-sm-2"></div>

                                <div class="col-sm-4">
                                    <label>Sale Person</label><br>
                                    <input type="text" name="spname" value="${SR}" class="form-control input-sm" required="" >
                                   
                                </div>
                                <div class="col-sm-4"> 
                                    <label>Transport Name:</label><br>  
                                    <select name="transport" class="form-control input-sm" style=" width: 62%"  required="">
                                        <option value="">Select Transport</option>
                                        <%
                                            AdminPojo app = new AdminPojo();
                                            List<Accountant> list11 = ap.TransportShow();
                                            for (Accountant ac : list11) {
                                        %>
                                        <option value="<%= ac.getTransport()%>"><%= ac.getTransport()%></option>
                                        <% } %>
                                    </select>

                                </div>
                                <div class="col-sm-2"></div>
                            </div><br>

                            <div class="row">
                                <div class="col-sm-2"></div>
                                <div class="col-sm-4"> 
                                    <label>Truck No:</label><br>  
                                    <input type="text" style=" width: 62%" name="truckno" value="" class="form-control input-sm" required="">
                                </div>
                                <div class="col-sm-4"> 
                                    <label>Amount:</label><br>  
                                    <input type="text" style=" width: 62%" name="rent" value="" class="form-control input-sm" required="">
                                </div>
                                <div class="col-sm-2"></div>
                            </div>
                            <br>
                            <div class="row"><br>
                                <div class="col-sm-2"></div>
                                <div class="col-sm-4"><input type="submit" name="" value="Confirm Order" class="btn btn-success btn-sm"></div>
                                <div class="col-sm-4"></div>
                                <div class="col-sm-2"></div>
                            </div>
                        </form><br><hr>
                        
                    </div>
                </div>   
            </div>

        </div>  
    </div>
    <div id="direcdeli" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Direct Delivery</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="DirectDeleveryServlet" class="form-inline">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Select Retailer :</label><br>
                                        <select name="rtname" style=" width: 90%" class="form-control input-sm" required="">
                                            <option value="">Retailer Name</option> 
                                            <%
                                                List<Accountant> list6 = ap.retailerView();
                                                for (Accountant ac : list6) {
                                            %>
                                            <option value="<%= ac.getRetailer()%>"><%= ac.getRetailer()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Note :</label><br>
                                        <input type="text" name="note" style=" width: 80%"  class="form-control input-sm" value="" required="">
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Product Name</label><br>
                                        <select name="pid" style=" width: 90%" class="form-control input-sm" required="">
                                            <option value="">Select-Product</option>
                                            <%
                                                List<StockModel> list22 = ap.StockSummary();
                                                for (StockModel sm : list22) {
                                            %>
                                            <option value="<%= sm.getSino()%>"><%= sm.getProduct()%>(<%= sm.getQnt()%>), Rate(<%= sm.getPurserate()%>)</option>

                                            <% } %>
                                        </select>   
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Quantity</label><br>
                                        <input type="text" name="qty" value="" class="form-control input-sm" style=" width: 90%" required="" > 
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Rate</label><br>
                                        <input type="text" name="rate" value="" class="form-control input-sm" style=" width: 90%" required="" >
                                    </div>

                                </div><br>

                                <div class="row">

                                    <div class="col-sm-6">
                                        
                                    </div>
                                    <div class="col-sm-6"> 
                                        <label>Transport Name:</label><br>  
                                        <select name="transport" class="form-control input-sm" style=" width: 90%"  required="">
                                            <option value="">Select Transport</option>
                                            <%
                                                List<Accountant> list111 = ap.TransportShow();
                                                for (Accountant ac : list111) {
                                            %>
                                            <option value="<%= ac.getTransport()%>"><%= ac.getTransport()%></option>
                                            <% } %>
                                        </select>

                                    </div>

                                </div><br>

                                <div class="row">
                                    <div class="col-sm-6"> 
                                        <label>Truck No:</label><br>  
                                        <input type="text" style=" width: 90%" name="truckno" value="" class="form-control input-sm" required="">
                                    </div>
                                    <div class="col-sm-6"> 
                                        <label>Amount:</label><br>  
                                        <input type="text" style=" width: 90%" name="rent" value="" class="form-control input-sm" required="">
                                    </div>

                                </div>
                                <br>
                                <div class="row"><br>
                                    <div class="col-sm-12"><input type="submit" name="" value="Confirm Order" class="btn btn-success btn-sm"></div>
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
     <div id="orderdel" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Order Delete</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form  method="POST" action="OrderDeleteServlet" class="form-inline">
                                    <center><label><b>Delete Order :</b></label> <br>
                                        <select name="odsi" class="form-control input-sm" required="">
                                            <option value="">Select-Order</option>
                                            <%
                                                List<Accountant> list1 = ap.OrderShow();
                                                for (Accountant ac : list1) {
                                            %>
                                            <option value="<%= ac.getSi()%>"><%= ac.getSi()%>. <%= ac.getRtname()%> (<%= ac.getProname()%>)</option>
                                            <%}%>
                                        </select> 
                                        <input type="submit" name="" value="Delete" class="btn btn-primary btn-sm"> 
                                    </center>
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
     <% }%>
</body>

</html>
