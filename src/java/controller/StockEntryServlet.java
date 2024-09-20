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
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Acer
 */
public class StockEntryServlet extends HttpServlet {

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
        
        String pname=request.getParameter("pname");
        String vendor=request.getParameter("vendor");
        int qty=Integer.parseInt(request.getParameter("qty"));
        Float prate=Float.parseFloat(request.getParameter("prate"));
                
            Connection con = null;
            PreparedStatement ps = null;
                        
            try {
                con = Database.getConnection();
                String upquery="update product_stock set QUANTITY=QUANTITY+?, DATE=CURDATE() where PRODUCT_NAME=? and PURSE_FROM=? and PURSE_PRICE=?";
                ps = con.prepareStatement(upquery);
                ps.setInt(1, qty);
                ps.setString(2, pname);
                ps.setString(3, vendor);
                ps.setFloat(4, prate);
                int a = ps.executeUpdate();
                if(a>0){
                     String query="insert into factory_stock (PRODUCT_NAME, PURSE_FROM, QUANTITY, PURSE_PRICE, DATE) values"
                        + "(?,?,?,?,CURDATE())";
                ps = con.prepareStatement(query);
                ps.setString(1, pname);
                ps.setString(2, vendor);
                ps.setInt(3, qty);
                ps.setFloat(4, prate);
                ps.executeUpdate();
                    response.sendRedirect("accountant.jsp");
                }else{
                String query="insert into product_stock (PRODUCT_NAME, PURSE_FROM, QUANTITY, PURSE_PRICE, DATE) values"
                        + "(?,?,?,?,CURDATE())";
                ps = con.prepareStatement(query);
                ps.setString(1, pname);
                ps.setString(2, vendor);
                ps.setInt(3, qty);
                ps.setFloat(4, prate);
                int b = ps.executeUpdate();
                    if (b > 0) {
                         String query1="insert into factory_stock (PRODUCT_NAME, PURSE_FROM, QUANTITY, PURSE_PRICE, DATE) values"
                        + "(?,?,?,?,CURDATE())";
                ps = con.prepareStatement(query1);
                ps.setString(1, pname);
                ps.setString(2, vendor);
                ps.setInt(3, qty);
                ps.setFloat(4, prate);
                ps.executeUpdate();
                        response.sendRedirect("accountant.jsp");
                    }else{
                        out.println("Product is not Entryed");
                    }
                    
                }
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }

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
