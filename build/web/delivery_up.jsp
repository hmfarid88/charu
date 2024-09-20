
<%@page import="Model.AdminModel"%>
<%@page import="Pojo.AdminPojo"%>
<%@page import="Pojo.AccountPojo"%>
<%@page import="java.util.List"%>
<%@page import="Model.Accountant"%>
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
    <div class="container"><br>
        <form method="POST" action="DelUpServlet" class="form-inline">
            <div class="row">
                <div class="col-sm-3">

                </div>
                <div style="background-color: #CCC" class="col-sm-6">
                    <table><center><h4>Delivery Info Update</h4></center>
                        <tr>
                            <td>
                                <br><label>Delivery Date : </label>
                            </td>
                            <td>
                                <br><input type="text" style="width: 35%" class="form-control input-sm" value="${ddate}" readonly="" >
                                <input type="date" name="ddate" style="width: 40%" class="form-control input-sm" required="">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 40%"><input type="hidden" name="sino" value="${dsi}"> 
                                <br><label>Retailer : </label>
                            </td>
                            <td>
                                <br><input type="text"  style="width: 35%"  class="form-control input-sm" value="${dodname}" readonly=""> 
                                
                                <select name="retler" style="width: 40%"  class="form-control input-sm" required="">
                                            <option value="">Select Retailer</option> 
                                            <%
                                                AccountPojo ap = new AccountPojo();
                                                List<Accountant> list6 = ap.retailerView();
                                                for (Accountant ac : list6) {
                                            %>
                                            <option value="<%= ac.getRetailer()%>"><%= ac.getRetailer()%></option>
                                            <% } %>
                                        </select>
                            </td>
                           
                        </tr>
                        <tr>
                            <td>
                                <br><label>Sold By : </label>
                            </td>
                            <td>
                                <br><input type="text"  style="width: 35%" class="form-control input-sm" value="${dspname}" readonly="">
                            <select  class="form-control input-sm" style="width: 40%" name="spname" required="">
                                        <option value="">Select-Employee</option>
                                        <%
                                            AdminPojo app = new AdminPojo();
                                            List<AdminModel> listam = app.EmpShow();
                                            for (AdminModel am : listam) {
                                        %>
                                        <option value="<%= am.getEname()%>"> <%= am.getEname()%></option>
                                        <%}%>
                                    </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br><label>Note : </label>
                            </td>
                            <td>
                                <br><input type="text" name="dnote" class="form-control input-sm" value="${dnote}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br><label>Product Name : </label>
                            </td>
                            <td>
                                <br><input type="text" name="oldproduct"  style="width: 35%" class="form-control input-sm" value="${dproduct}" readonly="">
                            <select  class="form-control input-sm" style="width: 40%" name="product" required="">
                                        <option value="">Select-Product</option>
                                        <option value="PCC">PCC</option>
                                        <option value="PC">PC</option>
                            </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br><label>Quantity : </label>
                            </td>
                            <td>
                                <input type="hidden" name="oldqty" value="${dqty}">
                                <br><input type="text" name="qty" class="form-control input-sm" value="${dqty}" required="">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br><label>Rate :</label>
                            </td>
                            <td>
                                <input type="hidden" name="dprate" value="${dprate}">
                                <br> <input type="text" name="rate"  class="form-control input-sm" value="${drate}" required="">  
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br><label>Transport Name : </label>
                            </td>
                            <td>
                                <br><input type="text" style="width: 35%" class="form-control input-sm" value="${dtport}" readonly="">
                             <select name="tport" class="form-control input-sm" style="width: 40%"  required="">
                                        <option value="">Select Transport</option>
                                        <option value="Factory Transport">Factory Transport</option>
                                        <%
                                            List<Accountant> list11 = ap.TransportShow();
                                            for (Accountant ac : list11) {
                                        %>
                                        <option value="<%= ac.getTransport()%>"><%= ac.getTransport()%></option>
                                        <% } %>
                                    </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br><label>Truck No : </label>
                            </td>
                            <td>
                                <br><input type="text" name="tno" class="form-control input-sm" value="${dtrucno}" required="">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br><label>Truck Rent : </label>
                            </td>
                            <td>
                                <br><input type="text" name="trent" class="form-control input-sm" value="${dtrent}" required="">
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <br> <input type="submit" class="btn btn-success input-sm" value="Update"> <a href="delivery_ledger.jsp" class="btn btn-primary btn-sm">Cancel</a> 
                            </td>
                        </tr>
                    </table><br>

                </div>

                <div class="col-sm-3">

                </div>
            </div>
        </form><br>
        <div class="row">
        <div class="col-sm-3"></div>
     <div class="col-sm-6" style="background-color: #CCC">
         <h4>Do you want to delete this delivery permanently? If Yes, Click Delete </h4>
        <form  method="POST" action="DeliveryDelServlet" class="form-inline">
          <input type="hidden" name="sino" value="${dsi}">   
          <input type="submit" style="background-color: red" class="btn btn-danger input-sm" value="Delete">
        </form><br>
     </div>
          <div class="col-sm-3"></div>
        </div>
    </div>

    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
   
    <% } %>
</body>
</html>
