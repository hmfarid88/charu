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
public class FacStockDelServlet extends HttpServlet {

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
        ResultSet rs=null;
                
        try{
            con=Database.getConnection();
            String query1="select PRODUCT_NAME, QUANTITY, PURSE_PRICE from  factory_stock where SI_NO=?";
            ps = con.prepareStatement(query1);
            ps.setInt(1, sino);
            rs = ps.executeQuery();
            rs.next();
            String proname=rs.getString(1);
            int oldqty=rs.getInt(2);
            Float prsprice=rs.getFloat(3);
            String stockup="update product_stock set QUANTITY=QUANTITY-? where PRODUCT_NAME=? and QUANTITY>=? and PURSE_PRICE=?";
            ps = con.prepareStatement(stockup);
            ps.setInt(1, oldqty);
            ps.setString(2, proname);
            ps.setInt(3, oldqty);
            ps.setFloat(4, prsprice);
            int a=ps.executeUpdate();
            if(a>0){
                String del="delete from factory_stock where SI_NO=?";
                ps = con.prepareStatement(del);
                ps.setInt(1, sino);
                ps.executeUpdate();
                out.println("Delete Success");
            }else{
                out.println("Sorry , Insufficient Stock Qty, Try Again");
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
