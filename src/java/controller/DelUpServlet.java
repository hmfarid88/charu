/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DB.Database;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Acer
 */
public class DelUpServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        int sino=Integer.parseInt(request.getParameter("sino"));
        String ddate=request.getParameter("ddate");
        String retler=request.getParameter("retler");
        String spname=request.getParameter("spname");
        String product=request.getParameter("product");
        String oldproduct=request.getParameter("oldproduct");
        String dnote=request.getParameter("dnote");
        String tno=request.getParameter("tno");
        String tport=request.getParameter("tport");
        int qty=Integer.parseInt(request.getParameter("qty"));
        int oldqty=Integer.parseInt(request.getParameter("oldqty"));
        Float rate=Float.parseFloat(request.getParameter("rate"));
        Float trent=Float.parseFloat(request.getParameter("trent"));
        Float oldrate=Float.parseFloat(request.getParameter("dprate"));
        
        Connection con=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        
        try{
            con=Database.getConnection();
            if(oldproduct.equals(product)){
              String update="update order_delevery set ORDER_NAME=?, NOTE=?, PRODUCT_NAME=?, QTY=?, RATE=?, TRUCK_NO=?, RENT=?, TRANSPORT=?, SP_NAME=?, DATE=? where SI_NO=?";
            ps = con.prepareStatement(update);
            ps.setString(1, retler);
            ps.setString(2, dnote);
            ps.setString(3, product);
            ps.setInt(4, qty);
            ps.setFloat(5, rate);
            ps.setString(6, tno);
            ps.setFloat(7, trent);
            ps.setString(8, tport);
            ps.setString(9, spname);
            ps.setString(10, ddate);
            ps.setInt(11, sino);
            ps.executeUpdate();
                if(qty>oldqty){
                   int newqty=qty-oldqty;
                   String stockup = "update product_stock set QUANTITY=QUANTITY-? where  PRODUCT_NAME=? and PURSE_PRICE=?";
                        ps = con.prepareStatement(stockup);
                        ps.setInt(1, newqty);
                        ps.setString(2, oldproduct);
                        ps.setFloat(3, oldrate);
                        ps.executeUpdate();
                 String tportup="update transport_pay set TRANSPORT_NAME=?, RETAILER=?, PRODUCT_NAME=?, TRUCK_NO=?, QTY=?, RENT=? where DEL_NO=? and DEL_NO>0";
                 ps = con.prepareStatement(tportup);
                 ps.setString(1, tport);
                 ps.setString(2, retler);
                 ps.setString(3, product);
                 ps.setString(4, tno);
                 ps.setInt(5, qty);
                 ps.setFloat(6, trent);
                 ps.setInt(7, sino);
                 ps.executeUpdate();
                        response.sendRedirect("delivery_up.jsp");
               } else{
                  int newqty=oldqty-qty;
                   String stockup = "update product_stock set QUANTITY=QUANTITY+? where  PRODUCT_NAME=? and PURSE_PRICE=?";
                        ps = con.prepareStatement(stockup);
                        ps.setInt(1, newqty);
                        ps.setString(2, oldproduct);
                        ps.setFloat(3, oldrate);
                        ps.executeUpdate();
                 String tportup="update transport_pay set TRANSPORT_NAME=?, RETAILER=?, PRODUCT_NAME=?, TRUCK_NO=?, QTY=?, RENT=? where DEL_NO=? and DEL_NO>0";
                 ps = con.prepareStatement(tportup);
                 ps.setString(1, tport);
                 ps.setString(2, retler);
                 ps.setString(3, product);
                 ps.setString(4, tno);
                 ps.setInt(5, qty);
                 ps.setFloat(6, trent);
                 ps.setInt(7, sino);
                 ps.executeUpdate();
                        response.sendRedirect("delivery_up.jsp");
              }
            }else{
              String quwer="select QUANTITY, PURSE_PRICE from product_stock where PRODUCT_NAME=?";
              ps = con.prepareStatement(quwer);
              ps.setString(1, product);
              rs=ps.executeQuery();
              rs.next();
              int stockqty=rs.getInt(1);
              Float newpprice=rs.getFloat(2);
              if(stockqty<qty){
                out.println("Sorry, Insufficient Product !");
              }else{
               String update="update order_delevery set ORDER_NAME=?, NOTE=?, PRODUCT_NAME=?, QTY=?, PURSE_RATE=?, RATE=?, TRUCK_NO=?, RENT=?, TRANSPORT=?, SP_NAME=?, DATE=? where SI_NO=?";
            ps = con.prepareStatement(update);
            ps.setString(1, retler);
            ps.setString(2, dnote);
            ps.setString(3, product);
            ps.setInt(4, qty);
            ps.setFloat(5, newpprice);
            ps.setFloat(6, rate);
            ps.setString(7, tno);
            ps.setFloat(8, trent);
            ps.setString(9, tport);
            ps.setString(10, spname);
            ps.setString(11, ddate);
            ps.setInt(12, sino);
            int x=ps.executeUpdate();
            if(x>0){
               String stockup = "update product_stock set QUANTITY=QUANTITY-? where  PRODUCT_NAME=? and PURSE_PRICE=?";
                        ps = con.prepareStatement(stockup);
                        ps.setInt(1, qty);
                        ps.setString(2, product);
                        ps.setFloat(3, newpprice);
                        ps.executeUpdate();
              String oldstockup = "update product_stock set QUANTITY=QUANTITY+? where  PRODUCT_NAME=? and PURSE_PRICE=?";
                        ps = con.prepareStatement(oldstockup);
                        ps.setInt(1, oldqty);
                        ps.setString(2, oldproduct);
                        ps.setFloat(3, oldrate);
                        ps.executeUpdate();
                 String tportup="update transport_pay set TRANSPORT_NAME=?, RETAILER=?, PRODUCT_NAME=?, TRUCK_NO=?, QTY=?, RENT=? where DEL_NO=? and DEL_NO>0";
                 ps = con.prepareStatement(tportup);
                 ps.setString(1, tport);
                 ps.setString(2, retler);
                 ps.setString(3, product);
                 ps.setString(4, tno);
                 ps.setInt(5, qty);
                 ps.setFloat(6, trent);
                 ps.setInt(7, sino);
                 int y=ps.executeUpdate();
                 if(y>0){
                     out.println("<h4>Update Success !</h4>");
                 }else{
                   out.println("Update  is not Success !");  
                 }
            }
              }
            }
            
                }catch (Exception ex) {
              ex.printStackTrace();
            }finally {
    try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
    try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
    try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }  
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
            Connection con = null;
            PreparedStatement ps = null;
                    try {
                con = Database.getConnection();
                    String query="update reserve_stock set PRODUCT_NAME='PCC', QUANTITY=(select sum(QUANTITY) from  product_stock where PRODUCT_NAME='PCC'), PURSE_PRICE=(select sum(PURSE_PRICE) from product_stock where PRODUCT_NAME='PCC') where PRODUCT_NAME='PCC' and DATE=CURDATE()";
                    ps = con.prepareStatement(query);
                    int x=ps.executeUpdate();
                   
                    if(x>0){
                    
                    }else{
                        String query2="insert into reserve_stock (PRODUCT_NAME, QUANTITY, PURSE_PRICE, DATE) values"
                        + "('PCC',(select sum(QUANTITY) from  product_stock where PRODUCT_NAME='PCC'),(select sum(PURSE_PRICE) from product_stock where PRODUCT_NAME='PCC'),CURDATE())";
                        ps = con.prepareStatement(query2);
                        ps.executeUpdate();
                    
                    }
                                
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }
      try {
                con = Database.getConnection();
                    String query1="update reserve_stock set PRODUCT_NAME='PC', QUANTITY=(select sum(QUANTITY) from  product_stock where PRODUCT_NAME='PC'), PURSE_PRICE=(select sum(PURSE_PRICE) from product_stock where PRODUCT_NAME='PC') where PRODUCT_NAME='PC' and DATE=CURDATE()";
                    ps = con.prepareStatement(query1);
                    int y=ps.executeUpdate(); 
                    if(y>0){
                    
                    }else{
                                              
                         String query3="insert into reserve_stock (PRODUCT_NAME, QUANTITY, PURSE_PRICE, DATE) values"
                        + "('PC',(select sum(QUANTITY) from  product_stock where PRODUCT_NAME='PC'),(select sum(PURSE_PRICE) from product_stock where PRODUCT_NAME='PC'),CURDATE())";
                        ps = con.prepareStatement(query3);
                        ps.executeUpdate();
                    }
                                
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }   
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
