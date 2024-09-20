
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
        <form method="POST" action="TransUpServlet" class="form-inline">
            <div class="row">
                <div class="col-sm-2">

                </div>
                <div style="background-color: #CCC" class="col-sm-8">
                    <table><center><h4>Transport Info Update</h4></center>
                        <tr>
                            <td>
                                <br><label>Payment Date : </label>
                            </td>
                            <td>
                                <br><input type="text" style="width: 35%" class="form-control input-sm" value="${date}" readonly="" >
                                <input type="date" name="date" style="width: 40%" class="form-control input-sm" required="">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 40%"><input type="hidden" name="sino" value="${tsi}" > 
                                <br><label>Transport Name : </label>
                            </td>
                            <td>
                                <br><input type="text"  style="width: 35%"  class="form-control input-sm" value="${trname}" readonly=""> 
                                
                                <select name="trname" style="width: 40%"  class="form-control input-sm" required="">
                                            <option value="">Select Transport</option> 
                                            <%
                                                AccountPojo ap = new AccountPojo();
                                                List<Accountant> list6 = ap.TransportShow();
                                                for (Accountant ac : list6) {
                                            %>
                                            <option value="<%= ac.getTransport()%>"><%= ac.getTransport()%></option>
                                            <% } %>
                                        </select>
                            </td>
                           
                        </tr>
                        <tr>
                            <td>
                                <br><label>Payment : </label>
                            </td>
                            <td>
                                <br><input type="text" name="amount"   class="form-control input-sm" value="${payment}" required="" >
                        
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br><label>Note : </label>
                            </td>
                            <td>
                                <br><input type="text" name="note" class="form-control input-sm" value="${note}" required="">
                            </td>
                        </tr>
                       
                        <tr>
                            <td></td>
                            <td>
                                <br> <input type="submit" class="btn btn-success input-sm" value="Update"> <a href="transport_ledger.jsp" class="btn btn-primary btn-sm">Cancel</a> 
                            </td>
                        </tr>
                    </table><br>

                </div>

                <div class="col-sm-2">

                </div>

            </div>
         </form>
                               
    </div> 

    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
   
    <% } %>
</body>
</html>
