
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
        <form method="POST" action="FcpayUpdateServlet" class="form-inline">
            <div class="row">
                <div class="col-sm-3">

                </div>
                <div style="background-color: #CCC" class="col-sm-6">
                    <table><center><h4>Factory Payment Update</h4></center>
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
                            <td style="width: 40%"><input type="hidden" name="sino" value="${rpsi}" ><input type="hidden" name="delno" value="${delno}" >  
                                <br><label>Factory Name : </label>
                            </td>
                            <td>
                                <br><input type="text"  style="width: 35%"  class="form-control input-sm" value="${retailer}" readonly=""> 
                                
                                <select name="retailer" style="width: 40%"  class="form-control input-sm" required="">
                                            <option value="">Select Factory</option> 
                                            <%
                                                AccountPojo ap = new AccountPojo();
                                                List<Accountant> list5 = ap.FactoryView();
                                                for (Accountant vv : list5) {
                                            %>
                                            <option value="<%= vv.getFactory()%>"><%= vv.getFactory()%></option>
                                            <% } %>
                                        </select>
                            </td>
                           
                        </tr>
                        <tr>
                            <td>
                                <br><label>Payment Type : </label>
                            </td>
                            <td>
                                <br><input type="text" name="type"   class="form-control input-sm" value="${type}" required="" >
                        
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br><label>Payment : </label>
                            </td>
                            <td>
                                <br><input type="text" name="amount"   class="form-control input-sm" value="${amount}" required="" >
                        
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
                            <td>
                                <br><label>Bank Name : </label>
                            </td>
                            <td>
                                <br><input type="text" name="note" class="form-control input-sm" value="${bank}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br><label>Branch : </label>
                            </td>
                            <td>
                                <br><input type="text" name="note" class="form-control input-sm" value="${branch}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br><label>Cheque No : </label>
                            </td>
                            <td>
                                <br><input type="text" name="cheque" class="form-control input-sm" value="${checq}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br><label>Payer : </label>
                            </td>
                            <td>
                                <br><input type="text" name="note" class="form-control input-sm" value="${payer}">
                            </td>
                        </tr>
                       
                        <tr>
                            <td></td>
                            <td>
                                <br> <input type="submit" class="btn btn-success input-sm" value="Update"> <a href="factory_pay_details.jsp" class="btn btn-primary btn-sm">Cancel</a> 
                            </td>
                        </tr>
                    </table><br>

                </div>

                <div class="col-sm-3">

                </div>

            </div>
        </form>
                             <div class="row">
        <div class="col-sm-3"></div>
     <div class="col-sm-6" style="background-color: #CCC">
         <h4>Do you want to delete this payment permanently? If Yes, Click Delete </h4>
        <form  method="POST" action="FacPayDelServlet" class="form-inline">
          <input type="hidden" name="sino" value="${rpsi}"> <input type="hidden" name="delno" value="${delno}" >    
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
