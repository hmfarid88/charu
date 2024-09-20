
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
        <form method="POST" action="FacLedgUpSuccess" class="form-inline">
            <div class="row">
                <div class="col-sm-3">

                </div>
                <div style="background-color: #CCC" class="col-sm-6">
                    <table><center><h4>Factory Stock Update</h4></center>
                        <tr>
                            <td>
                                <br><label>Entry Date : </label>
                            </td>
                            <td>
                                <br><input type="text" name="olddate" style="width: 35%" class="form-control input-sm" value="${pdate}" readonly="" >
                                <input type="date" name="date" style="width: 40%" class="form-control input-sm" required="">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 40%"><input type="hidden" name="sino" value="${psi}"> 
                                <br><label>Factory : </label>
                            </td>
                            <td>
                                <br><input type="text" name="oldfactory"  style="width: 35%"  class="form-control input-sm" value="${pfrom}" readonly=""> 
                                
                                <select name="factory" style="width: 40%"  class="form-control input-sm" required="">
                                            <option value="">Select Factory</option> 
                                            <%
                                                AccountPojo ap = new AccountPojo();
                                                List<Accountant> list6 = ap.FactoryView();
                                                for (Accountant ac : list6) {
                                            %>
                                            <option value="<%= ac.getFactory()%>"><%= ac.getFactory()%></option>
                                            <% } %>
                                        </select>
                            </td>
                           
                        </tr>
                        
                       
                        <tr>
                            <td>
                                <br><label>Product Name : </label>
                            </td>
                            <td>
                                <br><input type="text" name="oldproduct"  style="width: 35%" class="form-control input-sm" value="${proname}" readonly="">
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
                                <input type="hidden" name="oldqty" value="${pqty}">
                                <br><input type="text" name="qty" class="form-control input-sm" value="${pqty}" required="">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br><label>Rate :</label>
                            </td>
                            <td>
                                <input type="hidden" name="oldrate" value="${prate}">
                                <br> <input type="text" name="rate"  class="form-control input-sm" value="${prate}" required="">  
                            </td>
                        </tr>
                      
                        <tr>
                            <td></td>
                            <td>
                                <br> <input type="submit" class="btn btn-success input-sm" value="Update"> 
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
         <h4>Do you want to delete this stock permanently? If Yes, Click Delete </h4>
        <form  method="POST" action="FacStockDelServlet" class="form-inline">
          <input type="hidden" name="sino" value="${psi}">   
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
