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
public class FacLedgUpSuccess extends HttpServlet {

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
        String date=request.getParameter("date");
        String factory=request.getParameter("factory");
        String product=request.getParameter("product");
        String olddate=request.getParameter("olddate");
        String oldfactory=request.getParameter("oldfactory");
        String oldproduct=request.getParameter("oldproduct");
        int oldqty=Integer.parseInt(request.getParameter("oldqty"));
        int qty=Integer.parseInt(request.getParameter("qty"));
        int qtybl=qty-oldqty;
        int qtybll=oldqty-qty;
        Float oldrate=Float.parseFloat(request.getParameter("oldrate"));
        Float rate=Float.parseFloat(request.getParameter("rate"));
               
        Connection con=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        try{
            con=Database.getConnection();
            if(qty<oldqty){
//                String query="select QUANTITY from product_stock where PRODUCT_NAME=? and PURSE_FORM=? and PURSE_PRICE=?";
//            ps = con.prepareStatement(query);
//            ps.setString(1, product);
//            ps.setString(2, factory);
//            ps.setFloat(3, rate);
//            rs=ps.executeQuery();
//            rs.next();
//            int stockqty=rs.getInt(1);
//            if(stockqty<qtybll){
//                out.println("<h3>Sorry! Insufficient Stock.</h3>");
//            }else{
                String companyup="update factory_stock set PRODUCT_NAME=?, PURSE_FROM=?, QUANTITY=?, PURSE_PRICE=?, DATE=? where SI_NO=?";
                ps = con.prepareStatement(companyup);
                ps.setString(1, product);
                ps.setString(2, factory);
                ps.setInt(3, qty);
                ps.setFloat(4, rate);
                ps.setString(5, date);
                ps.setInt(6, sino);
                ps.executeUpdate();
                String stockup="update product_stock set QUANTITY=QUANTITY-? where PRODUCT_NAME=? and PURSE_FROM=? and PURSE_PRICE=?";
                ps = con.prepareStatement(stockup);
                ps.setInt(1, qtybll);
                ps.setString(2, product);
                ps.setString(3, factory);
                ps.setFloat(4, rate);
                ps.executeUpdate();
                response.sendRedirect("fac_ledgup.jsp");
           
            }else if(qty>oldqty){
                
                String companyup="update factory_stock set PRODUCT_NAME=?, PURSE_FROM=?, QUANTITY=?, PURSE_PRICE=?, DATE=? where SI_NO=?";
                ps = con.prepareStatement(companyup);
                ps.setString(1, product);
                ps.setString(2, factory);
                ps.setInt(3, qty);
                ps.setFloat(4, rate);
                ps.setString(5, date);
                ps.setInt(6, sino);
                ps.executeUpdate();
                String stockup="update product_stock set QUANTITY=QUANTITY+? where PRODUCT_NAME=? and PURSE_FROM=? and PURSE_PRICE=?";
                ps = con.prepareStatement(stockup);
                ps.setInt(1, qtybl);
                ps.setString(2, product);
                ps.setString(3, factory);
                ps.setFloat(4, rate);
                int a=ps.executeUpdate();
               if(a>0){
                response.sendRedirect("fac_ledgup.jsp");
               }else{
                   String stockentry="insert into product_stock (PRODUCT_NAME, PURSE_FROM, QUANTITY, PURSE_PRICE, DATE) values"
                        + "(?,?,?,?,?)";
                ps = con.prepareStatement(stockentry);
                ps.setString(1, product);
                ps.setString(2, factory);
                ps.setInt(3, qtybl);
                ps.setFloat(4, rate);
                ps.setString(5, olddate);
                ps.executeUpdate();
                response.sendRedirect("fac_ledgup.jsp");
               }
            
            }else{
               String companyup="update factory_stock set PRODUCT_NAME=?, PURSE_FROM=?, QUANTITY=?, PURSE_PRICE=?, DATE=? where SI_NO=?";
                ps = con.prepareStatement(companyup);
                ps.setString(1, product);
                ps.setString(2, factory);
                ps.setInt(3, qty);
                ps.setFloat(4, rate);
                ps.setString(5, date);
                ps.setInt(6, sino);
                ps.executeUpdate();
                String stockup="update product_stock set  PRODUCT_NAME=?, PURSE_FROM=?, PURSE_PRICE=?, DATE=?  where PRODUCT_NAME=? and PURSE_FROM=? and PURSE_PRICE=?";
                ps = con.prepareStatement(stockup);
                ps.setString(1, product);
                ps.setString(2, factory);
                ps.setFloat(3, rate);
                ps.setString(4, date);
                ps.setString(5, oldproduct);
                ps.setString(6, oldfactory);
                ps.setFloat(7, oldrate);
                ps.executeUpdate();
                response.sendRedirect("fac_ledgup.jsp");
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
