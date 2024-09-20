
<%@page import="java.sql.SQLException"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.DeleteModel"%>
<%@page import="Pojo.DeletePojo"%>
<%@page import="Model.CashModel"%>
<%@page import="Pojo.CashBook"%>
<%@page import="Model.AdminModel"%>
<%@page import="Pojo.AdminPojo"%>
<%@page import="Model.SaleModel"%>
<%@page import="Pojo.Profit"%>
<%@page import="Model.StockModel"%>
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
        <link rel="stylesheet" href="css/style.css">
        <link rel="icon" type="image/png" href="img/favicon.ico">

    </head>
        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
        
    <body style="background-color: #030303;"  id="main">
        <div class="container-fluid">
        <header>
            <center><img style="margin-top: 1%;" src="img/logo.png" title="Charu Enterprise"  class="img-responsive"><h1 style="font-family: serif;  font-size: 3vw; color: whitesmoke; text-shadow: 2px 2px 3px black; "><strong>M/S. CHARU  ENTERPRISE</strong></h1></center>
        </header>
    <center><h3 class="text-primary"><b>Accountant-Area</b></h3></center>
   

        <nav style="margin: 0 auto; background-color: #030303; border-color: #ffffff" class="navbar navbar-inverse">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar"> 
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <div class="collapse navbar-collapse" id="myNavbar">
                <ul class="nav navbar-nav">
                    <li id="drop"><a href="#"><i class="fa fa-sticky-note"></i> Report -View </a>
                        <div id="dropdown">
                            <a href="totalstock.jsp">Stock Details</a> 
                            <a href="order_ledger.jsp">Order List</a>
                            <a href="sale_profit.jsp">Sale & Profit</a>
                            <a href="emp_sale.jsp">Employee Sale</a>
                            <a href="expenseinfo.jsp">Employee Expense</a>
                            <a href="monthly_sale_profit.jsp">Monthly Profit</a>
                            <a data-toggle="modal" data-target="#faccommission" href="#">Factory Commission</a>
                        </div>
                    </li>
                    <li id="drop"><a href="#"><i class="fa fa-book"></i> Ledger -Book </a>
                        <div id="dropdown">
                            <a href="retailer_ledger.jsp">Retailer-Ledger</a>
                            <a href="factory_ledger.jsp">Factory-Ledger</a>
                            <a href="transport_ledger.jsp">Transport-Ledger</a>
                            <a href="delivery_ledger.jsp">Delivery-Ledger</a>
                            <a href="expense_ledger.jsp">Office-Cost-Ledger</a>
                            <a href="debit_ledger.jsp">Debit-Ledger</a>
                            <a href="credit_ledger.jsp">Credit-Ledger</a>
                            <a href="bank_book.jsp">Bank-Ledger</a>
                            <a href="proprietor_ledger.jsp">Proprietor-Ledger</a>
                            <a href="cash_book.jsp">Cash-Book</a>
                        </div>
                    </li>
                    <li id="drop"><a href="#"><i class="fa fa-exchange"></i> Transaction -Info</a>
                        <div id="dropdown">
                            <a data-toggle="modal" data-target="#cdinfo" href="#">Cash-Debit</a>
                            <a data-toggle="modal" data-target="#crdinfo" href="#">Cash-Credit</a>
                            <a data-toggle="modal" data-target="#costinfo" href="#">Office-Cost Entry</a>
                            <a data-toggle="modal" data-target="#pminfo" href="#">Factory Payment</a>
                            <a data-toggle="modal" data-target="#empinfo" href="#">Employee Payment</a>
                            <a data-toggle="modal" data-target="#transportpay" href="#">Transport Payment</a>
                            <a data-toggle="modal" data-target="#ofinfo" href="#">Retailer Payment</a>
                            <a data-toggle="modal" data-target="#bnktrnsi" href="#">Bank Transaction</a>
                            <a data-toggle="modal" data-target="#targetcomision" href="#">Target-Commission</a>
                            <a data-toggle="modal" data-target="#propitercost" href="#">Proprietor Transaction</a>
                            
                        </div>
                    </li>
                    <li id="drop"><a href="#"><i class="fa fa-address-book-o"></i> Person -List </a>
                        <div id="dropdown">
                            <a href="retailerlist.jsp">Retailer-List</a>
                            <a href="employeelist.jsp">Employee-List</a>
                            <a href="end_user.jsp">End User</a>
                        </div>
                    </li>

                    <li id="drop"><a href="#"><i class="fa fa-cogs"></i> Add -Settings</a>
                        <div id="dropdown">
                            <a data-toggle="modal" data-target="#rtinfo" href="#">Add Retailer</a>
                            <a data-toggle="modal" data-target="#empadd" href="#">Add Employee</a>
                            <a data-toggle="modal" data-target="#factoryinfo" href="#">Add Factory</a>
                            <a data-toggle="modal" data-target="#bankinfo" href="#">Add Bank</a>
                            <a data-toggle="modal" data-target="#transportinfo" href="#">Add Transport</a>
                            <a data-toggle="modal" data-target="#exlimit" href="#">Expense Limit</a>
                            <a data-toggle="modal" data-target="#ainfo" href="#">Edit Account</a>
                            <a href="#" data-toggle="modal" data-target="#stokdel">Stock Delete</a>
                        </div>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">

                    <li><a id="lout" href="LogoutServlet"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                </ul> 
            </div>
        </nav>

        <div class="row">
            <div class="col-sm-12"><br>
                <center>
                    <div class="row">
                        <div class="col-sm-3"></div>
                        <div class="col-sm-6">
                    
                             <%
                                        AccountPojo ap = new AccountPojo();
                                        Profit pf = new Profit();
                                        CashBook cb = new CashBook();
                                        CashModel cm = cb.DailyCashShow();
                                        SaleModel sml = pf.DailyTotalSale();
                                        StockModel stm = ap.TotalStock();

                                    %>
                                    <table border="2"  style="color: #ffffff" width="90%" class="table-condensed table-responsive text-center" >
                                 <tr>
                                     <td><label>Stock Info</label></td>
                                     <td><label>Sale Info</label></td>
                                     <td><label>Pending Order</label></td>
                                     <td><label>Cash Value</label></td>
                            
                                 </tr>
                                
                                 <tr>
                                     <td>PCC [<%= stm.getPccqty()%> | <%= stm.getPccvalu()%>] <br> PC [<%= stm.getPcqty()%> | <%= stm.getPcvalu()%>]</td>
                                     <td><%= sml.getDtsqty()%> | <%= sml.getDtsp()%></td>
                                     <td><%= stm.getTotalorder()%> | <%= stm.getOdqty()%></td>
                                     <td><%= cm.getNetbalance()%> TK</td>
                                 </tr>
                               
                             </table>
                        </div>
                                 <div class="col-sm-3"></div>
                       </div>
                </center> 
               
                    <div class="panel-body">
                        
                            <div class="col-sm-3">
                            
                            </div>
                            <div class="col-sm-6">
                                <fieldset class="scheduler-border">
                        <legend style="font-family: fontawesome;color: #ffffff" class="scheduler-border">Input-Area</legend>
                            <input type="button" class="btn btn-success btn-block" data-toggle="collapse" data-target="#pen" value="Product Entry">
                            <div id="pen"  class="panel panel-primary collapse">
                                <div class="panel-body">
                                    <form method="POST" action="StockEntryServlet" class="form-inline">
                                        <div class="row">
                                            <div class="col-sm-6"> <label><b>Product Name :</b></label>  </div>
                                            <div class="col-sm-6"> 
                                                <select style=" width: 90%" name="pname" class="form-control input-sm" required="">
                                                    <option value="">Select-Item</option>
                                                    <option value="PCC">PCC 50kg</option>
                                                    <option value="PC">PC 50kg</option>
                                                </select> 
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">
                                            <div class="col-sm-6"><label><b>Purchase From :</b></label></div> 
                                            <div class="col-sm-6">
                                                <select style=" width: 90%" name="vendor" class="form-control input-sm" required="">
                                                    <option value="">Select Factory</option>
                                                    <%
                                                        List<Accountant> factory01 = ap.FactoryView();
                                                        for (Accountant act : factory01) {
                                                    %>
                                                    <option value="<%= act.getFactory()%>"> <%= act.getFactory()%></option>
                                                    <% } %>
                                                </select>

                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">
                                            <div class="col-sm-6"><label><b>Quantity :</b></label></div> 
                                            <div class="col-sm-6"><input style=" width: 90%"  type="number" name="qty" class="form-control input-sm" required=""></div>
                                        </div><br>
                                        <div class="row">
                                            <div class="col-sm-6"><label><b>Purchase Rate :</b></label></div> 
                                            <div class="col-sm-6"><input style=" width: 90%" type="text" name="prate" class="form-control input-sm" required=""></div>
                                        </div>
                                        <br>

                                        <input type="submit" value="Submit" class="btn btn-success btn-sm">
                                        <input type="reset" value="Reset" class="btn btn-warning btn-sm">
                                    </form>
                                </div>
                            </div><br>
                            <input type="button" class="btn btn-info btn-block" data-toggle="collapse" data-target="#cor" value="Create Order">
                            <div id="cor"  class="panel panel-primary collapse">
                                <div class="panel-body">
                                    <form method="POST" action="OrderEntryServlet" class="form-inline">
                                        <div class="row">
                                            <div class="col-sm-6"> <label><b>Select Retailer :</b></label>  </div>
                                            <div class="col-sm-6"> 
                                                <select style=" width: 90%" name="retname" class="form-control input-sm" required="">
                                                    <option value="">Select Retailer</option>
                                                    <%
                                                        List<Accountant> list = ap.retailerView();
                                                        for (Accountant ac : list) {
                                                    %>
                                                    <option value="<%= ac.getRetailer()%>"> <%= ac.getRetailer()%></option>
                                                    <%}%>
                                                </select> 
                                            </div></div><br>
                                        <div class="row">
                                            <div class="col-sm-6"> <label><b>Select Product :</b></label>  </div>
                                            <div class="col-sm-6"> 
                                                <select name="pid" style=" width: 90%" class="form-control input-sm" required="">
                                                    <option value="">Select-Product</option>
                                                    <%
                                                        List<StockModel> list2 = ap.StockSummary();
                                                        for (StockModel sm : list2) {
                                                    %>
                                                    <option value="<%= sm.getSino()%>"><%= sm.getProduct()%>(<%= sm.getQnt()%>), Rate(<%= sm.getPurserate()%>)</option>

                                                    <% } %>
                                                </select> 
                                            </div>
                                        </div><br>
                                        <div class="row">
                                            <div class="col-sm-6"><label><b>Quantity :</b></label></div> 
                                            <div class="col-sm-6"><input style=" width: 90%" type="number" name="qty" class="form-control input-sm" required=""></div>
                                        </div><br>
                                        <div class="row">
                                            <div class="col-sm-6"><label><b>Sale Rate :</b></label></div> 
                                            <div class="col-sm-6"><input type="text" style=" width: 90%" name="srate" class="form-control input-sm" required=""></div>
                                        </div>
                                        <br>
                                        <input type="submit" value="Submit" class="btn btn-primary btn-sm">
                                        <input type="reset" value="Reset" class="btn btn-warning btn-sm">
                                    </form>
                                </div>
                            </div><br>
                            <a href="order_delevery.jsp"><input type="button" class="btn btn-primary btn-block" value="Order Delivery"></a>
                        </fieldset>
                            </div>
                            <div class="col-sm-3">
                                
                            </div>
                       
                    </div>
              
            </div>

        </div><br>
        </div>
  
    <div id="rtinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Retailer-Info</h4>
                </div>
                <div class="modal-body">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Add-Retailer</legend>
                        <div class="container-fluid">
                            <form method="POST" action="RetailerStockServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Retailer/Client Name :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="rtname" required="" >
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Proprietor Name :</label>
                                        <input  type="text" class="form-control input-sm" value="No" name="proname" >
                                    </div>
                                </div><br>

                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Address :</label>
                                        <input  type="text" class="form-control input-sm" value="No" name="address" >
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Thana :</label>
                                        <input  type="text" class="form-control input-sm" value="No" name="thana" >
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Zilla :</label>
                                        <input  type="text" class="form-control input-sm" value="No" name="zilla" >
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Area/Side :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="area" required="" >
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Date of Birth :</label>
                                        <input  type="date" class="form-control input-sm" value="No" name="dob"  >
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Date of Marriage :</label>
                                        <input  type="date" class="form-control input-sm" value="No" name="dom"  >
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Manager Name :</label>
                                        <input  type="text" class="form-control input-sm" value="No" name="mname"  >
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Mobile Number :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="mnumber" required="" >
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <input type="submit"  class="btn btn-success btn-sm" value="Add"> 
                                        <input type="reset"  class="btn btn-info btn-sm" value="Reset"> 
                                    </div>
                                </div>

                            </form>
                        </div><hr style=" background-color: green">
                        <div class="container-fluid">
                            <form method="POST" action="retailer_info.jsp">
                                <label>Update Retailer Info :</label>
                                <select  class="form-control input-sm" name="retailer" required="" >
                                    <option value="">Select-Retailer</option>
                                    <%
                                        Connection con = null;
                                            PreparedStatement ps = null;
                                            ResultSet rs = null;
                                            try {
                                                con = Database.getConnection();
            String query = "select R_NAME from retailer_info  order by R_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                                    %>
                                    <option value="<%= rs.getString(1)%>"> <%= rs.getString(1)%></option>
                                    <%}
                                     }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                    %>

                                </select><br>
                                <input type="submit" class="btn btn-info btn-sm" value="GO">
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


    <div id="ainfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Account-Info</h4>
                </div>
                <div class="modal-body">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Update-Account</legend>
                        <form method="POST" action="AccIDPassUpServlet">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label>Current-ID</label>
                                    <input type="text" class="form-control input-sm" name="cid" required="">
                                </div>
                                <div class="col-sm-4">
                                    <label>Current-Password</label>
                                    <input type="password" class="form-control input-sm" name="cpass" required="">
                                </div>
                                <div class="col-sm-4">
                                    <label>Phone Number</label>
                                    <input type="text" class="form-control input-sm" name="mnumber" required="">
                                </div>
                            </div><br>
                            <div class="row">
                                <div class="col-sm-6">
                                    <label>New-ID</label>
                                    <input type="text" class="form-control input-sm" name="newid" required="">
                                </div> 
                                <div class="col-sm-6">
                                    <label>New-Password</label>
                                    <input type="password" class="form-control input-sm" name="newpass" required="">
                                </div>
                            </div><br>
                            <input type="submit" class="btn btn-success btn-sm" value="Update">
                        </form>
                    </fieldset>  

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>
   <div id="propitercost" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Proprietor-Transaction</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="PropitercostServlet">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Transaction Name</label>
                                        <select onchange="myFunction()" style=" width: 80%" class="form-control input-sm" name="name" required="">
                                            <option value="">Select Item</option>
                                            <option id="payment" value="Payment">Payment</option>
                                            <option value="Receive">Receive</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Transaction Note</label>
                                        <input type="text" name="note" class="form-control input-sm" required="">
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Amount</label>
                                        <input type="number" style=" width: 80%" class="form-control input-sm" name="amount" required="">
                                    </div>
                                </div><br>
                                <div id="paytype" class="row">
                                     <div class="col-sm-12">
                                        <label>Select Type : </label>
                                        <input type="radio" name="paytype" value="Cash"> Cash
                                        <input id="pcostbnk" type="radio" name="paytype" value="Bank"> Bank
                                    </div>
                                </div><br>
                                <div id="bankpcost" class="row">
                                    <div class="col-sm-6">
                                        <label>Bank Name</label>
                                        <select style=" width: 90%" class="form-control input-sm" id="costpbank" name="bank">
                                            <option value="">Bank Select</option>
                                            <%
                                                List<Accountant> pcost = ap.BankShow();
                                                for (Accountant ac : pcost) {
                                            %>
                                            <option value="<%= ac.getBank()%>"><%= ac.getBank()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Branch Name</label>
                                        <input style=" width: 90%" type="text" class="form-control input-sm" name="branch">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="Entry">
                            </form><hr style="background-color: green">
                            <form method="POST" action="ProTrDelServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Proprietor Transaction-Delete</label>
                                        <select  name="transi" class="form-control input-sm" required="">
                                            <option value="">Select-Item</option>
                                            <%
                                            DeletePojo dp=new DeletePojo();
                                            List<DeleteModel>dele1=dp.PropricostDel();
                                            for(DeleteModel dm:dele1){
                                            %>
                                            <option value="<%= dm.getProsi() %>"><%= dm.getPropayname() %>(<%= dm.getPropay() %>/<%= dm.getProrecv() %>)</option>
                                            <% } %>
                                        </select><br>
                                        <input type="submit" class="btn btn-info btn-sm" value="Delete">
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

    <div id="cdinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Cash-Debit(Amount Plus)</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="CashinServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Debit Name</label>
                                        <input type="text" style=" width: 80%" class="form-control input-sm" name="dname" required="">
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Debit Amount</label>
                                        <input type="number" style=" width: 80%" class="form-control input-sm" name="amount" required="">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="Entry">
                            </form><hr style="background-color: green">
                            <form method="POST" action="DebitDelServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Debit Item-Delete</label>
                                        <select  name="costsi" class="form-control input-sm" required="">
                                            <option value="">Select-Item</option>
                                            <%
                                            List<DeleteModel>ddel=dp.DebitDel();
                                            for(DeleteModel dm:ddel){
                                            %>
                                            <option value="<%= dm.getDebitsi() %>"><%= dm.getDebitname() %>(<%= dm.getDebitamount() %>)</option>
                                            <% } %>
                                        </select><br>
                                        <input type="submit" class="btn btn-info btn-sm" value="Delete">
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
    <div id="costinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Cost Entry</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="CostServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Cost Name</label>
                                        <input type="text" style=" width: 80%" class="form-control input-sm" name="costname" required="">
                                    </div>
                                   
                                    <div class="col-sm-6">
                                        <label>Cost Amount</label>
                                        <input type="number" style=" width: 80%" class="form-control input-sm" name="amount" required="">
                                    </div>
                                </div><br>
                                <div class="row">
                                     <div class="col-sm-12">
                                        <label>Select Type : </label>
                                        <input type="radio" name="paytype" value="Cash" required=""> Cash
                                        <input id="costbnk" type="radio" name="paytype" value="Bank" required=""> Bank
                                    </div>
                                </div><br>
                                <div id="bankitemforcost" class="row">
                                    <div class="col-sm-6">
                                        <label>Bank Name</label>
                                        <select style=" width: 90%" class="form-control input-sm" id="costbank" name="bank">
                                            <option value="">Bank Select</option>
                                            <%
                                                List<Accountant> cost = ap.BankShow();
                                                for (Accountant ac : cost) {
                                            %>
                                            <option value="<%= ac.getBank()%>"><%= ac.getBank()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Branch Name</label>
                                        <input style=" width: 90%" type="text" class="form-control input-sm" name="branch">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="Entry">
                            </form><hr style="background-color: green">
                            <form method="POST" action="CostDelServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Cost-Delete</label>
                                        <select  name="costsi" class="form-control input-sm" required="">
                                            <option value="">Select-Item</option>
                                            <%
                                            List<DeleteModel>dele=dp.OfficecostDel();
                                            for(DeleteModel dm:dele){
                                            %>
                                            <option value="<%= dm.getOffcostsi() %>"><%= dm.getOffcostname() %>(<%= dm.getOffcostamount() %>)</option>
                                            <% } %>
                                        </select><br>
                                        <input type="submit" class="btn btn-info btn-sm" value="Delete">
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
    <div id="crdinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Cash-Credit(Amount Minus)</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="CashoutServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Credit Name</label>
                                        <input type="text" style=" width: 80%" class="form-control input-sm" name="cname" required="">
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Credit Amount</label>
                                        <input type="number" style=" width: 80%" class="form-control input-sm" name="amount" required="">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="Entry">
                            </form><hr style="background-color: green">
                            <form method="POST" action="CreditDelServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Credit Item-Delete</label>
                                        <select  name="costsi" class="form-control input-sm" required="">
                                            <option value="">Select-Item</option>
                                            <%
                                            List<DeleteModel>credel=dp.CreditDel();
                                            for(DeleteModel dm:credel){
                                            %>
                                            <option value="<%= dm.getCreditsi() %>"><%= dm.getCreditname() %>(<%= dm.getCreditamount() %>)</option>
                                            <% } %>
                                        </select><br>
                                        <input type="submit" class="btn btn-info btn-sm" value="Delete">
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
    <div id="exlimit" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Expense-Limit</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="EmpLimitServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Employee Name</label>
                                        <select  class="form-control input-sm" style=" width: 80%" name="ename" required="" >
                                            <option value="">Select-Employee</option>
                                            <%
                                                AdminPojo app = new AdminPojo();
                                                List<AdminModel> listam = app.EmpShow();
                                                for (AdminModel am : listam) {
                                            %>
                                            <option value="<%= am.getEname()%>"> <%= am.getEname()%></option>
                                            <%}%>
                                        </select>
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Amount</label>
                                        <input type="number" style=" width: 80%" class="form-control input-sm" name="amount" required="">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="Entry">
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
    <div id="transportpay" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Transport Payment</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="TransportPayServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Transport Name</label>
                                        <select name="transport" class="form-control input-sm" style=" width: 80%" required="">
                                            <option value="">Select Transport</option>
                                            <%
                                                List<Accountant> list11 = ap.TransportShow();
                                                for (Accountant ac : list11) {
                                            %>
                                            <option value="<%= ac.getTransport()%>"><%= ac.getTransport()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="col-sm-3">
                                        <label>Payment Amount</label>
                                        <input type="number" style=" width: 90%" class="form-control input-sm" name="amount" required="">
                                    </div>
                                        <div class="col-sm-3">
                                        <label>Payment Note</label>
                                        <input type="text" style=" width: 90%" class="form-control input-sm" name="note" required="">
                                    </div>
                                </div><br>
                                <div class="row">
                                     <div class="col-sm-12">
                                        <label>Select Type : </label>
                                        <input type="radio" name="paytype" value="Cash" required=""> Cash
                                        <input id="tport" type="radio" name="paytype" value="Bank" required=""> Bank
                                    </div>
                                </div><br>
                                <div id="banktport" class="row">
                                    <div class="col-sm-6">
                                        <label>Bank Name</label>
                                        <select style=" width: 90%" class="form-control input-sm" id="tportbankpay" name="bank">
                                            <option value="">Bank Select</option>
                                            <%
                                                List<Accountant> tport = ap.BankShow();
                                                for (Accountant ac : tport) {
                                            %>
                                            <option value="<%= ac.getBank()%>"><%= ac.getBank()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Branch Name</label>
                                        <input style=" width: 90%" type="text" class="form-control input-sm" name="branch">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="Entry">
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
    <div id="empinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Employee Expense</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="EmpPayServlet">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Employee Name</label>
                                        <select name="empname" class="form-control input-sm" style=" width: 90%" required="">
                                            <option value="">Select-Employee</option>
                                            <%
                                                List<AdminModel> listam1 = app.EmpShow();
                                                for (AdminModel am : listam1) {
                                            %>
                                            <option value="<%= am.getEname()%>"> <%= am.getEname()%></option>
                                            <%}%>
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Expense Name</label>
                                        <select type="text" style=" width: 80%" class="form-control input-sm" name="costname" required=""> 
                                            <option value="">Select Item</option>
                                            <option value="Oil Cost">Oil Cost</option>
                                            <option value="Motor Cycle Cost">Motor Cycle Cost</option>
                                            <option value="Breakfast">Breakfast</option>
                                            <option value="Lunch">Lunch</option>
                                            <option value="Salary">Salary</option>
                                            <option value="Loan">Loan</option>
                                            <option value="Mobile Bill">Mobile Bill</option>
                                            <option value="Incentive">Incentive</option>
                                            <option value="Others">Others</option>
                                        </select> 
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Amount</label>
                                        <input type="number" style=" width: 70%" class="form-control input-sm" name="amount" required="">
                                    </div>
                                </div><br>
                                <div class="row">
                                     <div class="col-sm-12">
                                        <label>Select Type : </label>
                                        <input type="radio" name="paytype" value="Cash" required=""> Cash
                                        <input id="exp" type="radio" name="paytype" value="Bank" required=""> Bank
                                    </div>
                                </div><br>
                                <div id="bankexp" class="row">
                                    <div class="col-sm-6">
                                        <label>Bank Name</label>
                                        <select style=" width: 90%" class="form-control input-sm" id="expbank" name="bank">
                                            <option value="">Bank Select</option>
                                            <%
                                                List<Accountant> exp = ap.BankShow();
                                                for (Accountant ac : exp) {
                                            %>
                                            <option value="<%= ac.getBank()%>"><%= ac.getBank()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Branch Name</label>
                                        <input style=" width: 90%" type="text" class="form-control input-sm" name="branch">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="Entry">
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
    <div id="pminfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Factory-Payment</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="CompanypayServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Factory Select</label> 
                                        <select style=" width: 95%" name="factory" class="form-control input-sm" required="">
                                            <option value="">Select Factory</option> 
                                            <%
                                                List<Accountant> list5 = ap.FactoryView();
                                                for (Accountant vv : list5) {
                                            %>
                                            <option value="<%= vv.getFactory()%>"><%= vv.getFactory()%></option>
                                            <% }%>
                                        </select>
                                    </div>

                                </div><br>

                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Payment Type</label><br>
                                        <input type="radio" name="paytype" value="Cash" required=""> Cash
                                        <input id="facbnk" type="radio" name="paytype" value="Bank" required=""> Bank
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Note</label>
                                        <input style=" width: 80%" type="text" class="form-control input-sm" name="note" required="">
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Amount</label>
                                        <input style=" width: 80%" type="number" class="form-control input-sm" name="amount" required="">
                                    </div>

                                </div><br>
                                <div id="bankitem" class="row">
                                    <div class="col-sm-3">
                                        <label>Bank Name</label>
                                        <select style=" width: 90%" class="form-control input-sm" id="fpaybank" name="bank">
                                            <option value="">Bank Select</option>
                                            <%
                                                List<Accountant> list3 = ap.BankShow();
                                                for (Accountant ac : list3) {
                                            %>
                                            <option value="<%= ac.getBank()%>"><%= ac.getBank()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="col-sm-3">
                                        <label>Branch Name</label>
                                        <input style=" width: 90%" type="text" class="form-control input-sm" name="branch">
                                    </div>
                                    <div class="col-sm-3">
                                        <label>Cheque's Number</label>
                                        <input style=" width: 90%" type="text" class="form-control input-sm" name="cheque">
                                    </div>
                                    <div class="col-sm-3">
                                        <label>Payer Name</label>
                                        <input style=" width: 90%" type="text" class="form-control input-sm" name="payer">
                                    </div>
                                </div><br>

                                <div class="row">
                                    <div class="col-sm-12">
                                        <input type="submit" class="btn btn-success btn-sm" value="Entry">  
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

    <div id="ofinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Retailer Payment</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="RetailerpayServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Retailer Select</label> 
                                        <select name="rtname"  class="form-control input-sm" required="">
                                            <option value="">Retailer Name</option> 
                                            <%
                                                List<Accountant> list6 = ap.retailerView();
                                                for (Accountant ac : list6) {
                                            %>
                                            <option value="<%= ac.getRetailer()%>"><%= ac.getRetailer()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                        <div class="col-sm-6">
                                         
                                      </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Payment Type</label><br>
                                        <input type="radio" name="paytype" value="Cash" required=""> Cash
                                        <input id="bnk" type="radio" name="paytype" value="Bank" required=""> Bank

                                    </div>
                                    <div class="col-sm-4">
                                        <label>Note</label>
                                        <input type="text" class="form-control input-sm" name="note" required="">
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Amount</label>
                                        <input type="text" class="form-control input-sm" name="amount" required="">
                                    </div>

                                </div><br>
                                <div id="bankrow" class="row">
                                    <div class="col-sm-4">
                                        <label>Bank Name</label>
                                        <select class="form-control input-sm" id="rtpbank" style=" width: 80%" name="bank">
                                            <option value="">Bank Select</option>
                                            <%
                                                List<Accountant> list4 = ap.BankShow();
                                                for (Accountant ac : list4) {
                                            %>
                                            <option value="<%= ac.getBank()%>"><%= ac.getBank()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Branch Name</label>
                                        <input type="text" style=" width: 80%" class="form-control input-sm" name="branch">
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Payer Name</label>
                                        <input type="text" style=" width: 80%" class="form-control input-sm" name="payer">
                                    </div>
                                </div><br>

                                <div class="row">
                                    <div class="col-sm-12">
                                        <input type="submit" class="btn btn-success btn-sm" value="Entry">  
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
    <div id="bnktrnsi" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Bank-Transaction</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="BankTranServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Bank Name</label> 
                                        <select class="form-control input-sm" name="bank">
                                            <option value="">Bank Select</option>
                                            <%
                                                List<Accountant> list003 = ap.BankShow();
                                                for (Accountant ac : list003) {
                                            %>
                                            <option value="<%= ac.getBank()%>"><%= ac.getBank()%></option>
                                            <% } %>
                                        </select>
                                    </div>   
                                    <div class="col-sm-6">
                                        <label>Transaction Type</label>
                                        <select name="type" class="form-control input-sm" required="">
                                            <option value="">Select Type</option>
                                            <option value="Deposit">Deposit</option>
                                            <option value="Withdraw">Withdraw</option>
                                        </select>
                                    </div>

                                </div><br>
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Amount</label>
                                        <input type="number" class="form-control input-sm" name="amount" required="">
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Branch Name</label>
                                        <input type="text" class="form-control input-sm" name="branch" required="">
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Payer/Receiver</label>
                                        <input type="text" class="form-control input-sm" name="payer" required="">
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <input type="submit" class="btn btn-success btn-sm" value="OK">  
                                    </div> 
                                </div>
                            </form><hr style="background-color: green">
                            <form method="POST" action="BanktranDelServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Bank Transaction-Delete</label>
                                        <select  name="transi" class="form-control input-sm" required="">
                                            <option value="">Select-Item</option>
                                            <%
                                            List<DeleteModel>dell=dp.BanktransiDel();
                                            for(DeleteModel dm:dell){
                                            %>
                                            <option value="<%= dm.getBanksi() %>"><%= dm.getBank() %>(<%= dm.getBanktype() %>, <%= dm.getBankamount() %>)</option>
                                            <% } %>
                                        </select><br>
                                        <input type="submit" class="btn btn-info btn-sm" value="Delete">
                                    </div>
                                </div>
                            </form>

                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Exit</button>
                </div>
            </div>  
        </div>
    </div>
    <div id="factoryinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Factory</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="FactoryaddServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Factory Name</label>
                                        <input type="text" style=" width: 70%" class="form-control input-sm" name="fname" required=""><br>
                                        <input type="submit" class="btn btn-success btn-sm" value="Add">
                                    </div>
                                </div>
                            </form><hr style=" background-color: black">
                            <form method="POST" action="FactoryDelServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Delete Factory</label>
                                        <select style=" width: 70%" name="fname" class="form-control input-sm" required="">
                                            <option value=""></option>
                                            <%
                                                List<Accountant> factory = ap.FactoryView();
                                                for (Accountant act : factory) {
                                            %>
                                            <option value="<%= act.getFactory()%>"><%= act.getFactory()%></option>
                                            <% }%>
                                        </select><br>
                                        <input type="submit" class="btn btn-info btn-sm" value="Delete">
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
    <div id="bankinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Bank</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="BankaddServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Bank Name</label>
                                        <input type="text" style=" width: 70%" class="form-control input-sm" name="bankname" required=""><br>
                                        <input type="submit" class="btn btn-success btn-sm" value="Add">
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
    <div id="targetcomision" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Target-Commission</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="Fac_commiServlet" class="form-inline">
                                    <div class="row">
                                        <div class="col-sm-4">
                                    <select style="width: 97%" class="form-control input-sm" name="retailer" required="" >
                                        <option value="">Select-Factory</option>
                                        <%
                                            List<Accountant> listt = ap.FactoryView();
                                            for (Accountant ac : listt) {
                                        %>
                                        <option value="<%= ac.getFactory()%>"> <%= ac.getFactory()%></option>
                                        <%}%>
                                    </select>
                                        </div>
                                    <div class="col-sm-4">
                                    <select style="width: 90%" name="month" class="form-control input-sm" required="">
                                            <option class="active" value=""> Select Month</option>
                                            <option value="1">January</option>
                                            <option value="2">February</option>
                                            <option value="3">March</option>
                                            <option value="4">April</option>
                                            <option value="5">May</option>
                                            <option value="6">June</option>
                                            <option value="7">July</option>
                                            <option value="8">August</option>
                                            <option value="9">September</option>
                                            <option value="10">October</option>
                                            <option value="11">November</option>
                                            <option value="12">December</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                        <select style="width: 90%" name="year" class="form-control input-sm" required="">
                                            <option value=""> Select Year</option>
                                            <option value="2018">2018</option>
                                            <option value="2019">2019</option>
                                            <option value="2020">2020</option>
                                            <option value="2021">2021</option>
                                            <option value="2022">2022</option>
                                            <option value="2023">2023</option>
                                            <option value="2024">2024</option>
                                            <option value="2025">2025</option>
                                        </select>
                                    </div>
                                    </div><br>
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label>Target Name</label>
                                            <input type="text" style=" width: 90%" name="trname" class="form-control input-sm" value="" required="">
                                        </div>
                                        <div class="col-sm-3">
                                            <label>Start Date</label>
                                            <input type="date" name="stdate" class="form-control input-sm" value="" required="">
                                        </div>
                                        <div class="col-sm-3">
                                            <label>End Date</label>
                                            <input type="date" name="enddate" class="form-control input-sm" value="" required="">
                                        </div>
                                    <div class="col-sm-3">
                                        <label>Amount</label>
                                    <input style="width: 90%" type="text" name="amount" class="form-control input-sm" value="" required="" placeholder="Amount">
                                    </div>
                                    
                                    </div><br>
                                    <div class="row">
                                        <div class="col-sm-12">
                                          <input type="submit" class="btn btn-info btn-sm" value="GO">   
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
    <div id="faccommission" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Factory Commission</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="commission_1.jsp">
                                <div class="row">
                                    <div class="col-sm-4">
                                    <select name="month" class="form-control input-sm" required="">
                                            <option class="active" value=""> Select Month</option>
                                            <option value="1">January</option>
                                            <option value="2">February</option>
                                            <option value="3">March</option>
                                            <option value="4">April</option>
                                            <option value="5">May</option>
                                            <option value="6">June</option>
                                            <option value="7">July</option>
                                            <option value="8">August</option>
                                            <option value="9">September</option>
                                            <option value="10">October</option>
                                            <option value="11">November</option>
                                            <option value="12">December</option>
                                        </select>
                                    </div>
                                     <div class="col-sm-4">
                                        <select name="year" class="form-control input-sm" required="">
                                            <option value=""> Select Year</option>
                                            <option value="2018">2018</option>
                                            <option value="2019">2019</option>
                                            <option value="2020">2020</option>
                                            <option value="2021">2021</option>
                                            <option value="2022">2022</option>
                                            <option value="2023">2023</option>
                                            <option value="2024">2024</option>
                                            <option value="2025">2025</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-3">
                                       <input type="submit" class="btn btn-success btn-sm" value="View">
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
    <div id="transportinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Transport</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="TransportaddServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Transport Name</label>
                                        <input type="text" style=" width: 70%" class="form-control input-sm" name="transportname" required=""><br>
                                        <input type="submit" class="btn btn-success btn-sm" value="Add">
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
    <div id="empadd" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Employee-Info</h4>
                </div>
                <div class="modal-body">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Add-Employee</legend>
                        <div class="container-fluid">
                            <form method="POST" action="EmployeeEntryServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Employee Name :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="ename" id="model" required="" >
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Father's Name :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="fname" id="model" required="" >
                                    </div>
                                </div><br>

                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Address :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="address" id="model" required="" >
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Phone Number :</label>
                                        <input  type="number" class="form-control input-sm" value="" name="pnumber" id="model" required="" >
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Designation :</label>
                                        <select  class="form-control input-sm" value="" name="desiganation"  required="" >
                                            <option value="">Select Any</option>
                                            <option value="Accountant">Accountant</option>
                                            <option value="Employee">Employee</option>
                                        </select>
                                    </div>
                                </div><br>

                                <div class="row">
                                    <div class="col-sm-6">
                                        <input type="submit" id="modeladd" class="btn btn-success btn-sm" value="Add"> 
                                    </div>
                                </div>

                            </form>
                        </div><hr style=" background-color: green">
                        <div class="container-fluid">
                            <form method="POST" action="EmpDeleteServlet">
                                <label>Select Employee To Delete :</label>
                                <select  class="form-control input-sm" name="empsi" required="" >
                                    <option value="">Select-Employee</option>
                                    <%
                                        AdminPojo adp = new AdminPojo();
                                        List<AdminModel> listtt = adp.EmpShow();
                                        for (AdminModel am : listtt) {
                                    %>
                                    <option value="<%= am.getEsi()%>"> <%= am.getEname()%></option>
                                    <%}%>
                                </select><br>
                                <input  type="submit" class="btn btn-info btn-sm" value="Delete">
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
    <div id="stokdel" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Stock Delete</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                           <form method="POST" action="StockDelServlet">
                               <label>Stock List</label>         
                               <select name="sino" style="width: 60%"  class="form-control input-sm" required="">
                                            <option value="">Select Stock</option>  
                                            <%
                                                List<DeleteModel> list1 = dp.Stockentrytoday();
                                                for (DeleteModel dm : list1) {
                                            %>
                                            <option value="<%= dm.getSino() %>"><%= dm.getProduct() %>, <%= dm.getQty() %>(Bag), Rate(<%= dm.getRate() %>)</option>
                            
                                            <%}%>`
                               </select>  <br>
                                        <label>Quantity</label>
                                        <input type="number" name="qty" style="width: 60%" value="" class="form-control input-sm" required=""><br>
                                        <button type="submit" class="btn btn-warning btn-sm"><i class="fa fa-trash"></i></button>
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
    <script src="js/script.js"></script>
   
<% } %>
 </body>
</html>
