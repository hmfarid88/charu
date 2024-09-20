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
public class DeliveryDelServlet extends HttpServlet {

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
        
        Connection con=null;
        PreparedStatement ps=null; 
        ResultSet rs1=null;
                
        try{
            con=Database.getConnection();
            String query1="select PRODUCT_NAME, QTY, PURSE_RATE from  order_delevery where SI_NO=?";
            ps = con.prepareStatement(query1);
            ps.setInt(1, sino);
            rs1 = ps.executeQuery();
            rs1.next();
            String proname=rs1.getString(1);
            int oldqty=rs1.getInt(2);
            Float prsrate=rs1.getFloat(3);
                       
             String stockup = "update product_stock set QUANTITY=QUANTITY+? where  PRODUCT_NAME=? and PURSE_PRICE=?";
                        ps = con.prepareStatement(stockup);
                        ps.setInt(1, oldqty);
                        ps.setString(2, proname);
                        ps.setFloat(3, prsrate);
                       int a= ps.executeUpdate(); 
                       if(a>0){
                 String trnsdl="delete from transport_pay where DEL_NO=? and DEL_NO>0 ";
                 ps = con.prepareStatement(trnsdl);
                 ps.setInt(1, sino);
                 int b=ps.executeUpdate();
                 if(b>0){
                    String delidl="delete from order_delevery where SI_NO=?";
                 ps = con.prepareStatement(delidl);
                 ps.setInt(1, sino);
                 ps.executeUpdate(); 
                 response.sendRedirect("delivery_ledger.jsp");
                 }else{
                      out.println("Delivery Delete is not Completed!");
                 }
                       }else{
                          String query="insert into product_stock (PRODUCT_NAME, PURSE_FROM, QUANTITY, PURSE_PRICE, DATE) values"
                        + "(?,?,?,?,CURDATE())";
                ps = con.prepareStatement(query);
                ps.setString(1, proname);
                ps.setString(2, "Returned to stock");
                ps.setInt(3, oldqty);
                ps.setFloat(4, prsrate);
                int x = ps.executeUpdate();
                if(x>0){
                     String trnsdl="delete from transport_pay where DEL_NO=? and DEL_NO>0";
                 ps = con.prepareStatement(trnsdl);
                 ps.setInt(1, sino);
                 int y=ps.executeUpdate();
                 if(y>0){
                     String delidl="delete from order_delevery where SI_NO=?";
                 ps = con.prepareStatement(delidl);
                 ps.setInt(1, sino);
                 ps.executeUpdate(); 
                 response.sendRedirect("delivery_ledger.jsp");
                 }
                }else{
                   out.println("Delete is not Success!"); 
                }
                       }
            
         
          }catch (Exception ex) {
              ex.printStackTrace();
            }finally {
    try { if (rs1 != null) rs1.close(); } catch (SQLException ex2) { }
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
