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
public class OrderEntryServlet extends HttpServlet {

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
        
        String retname=request.getParameter("retname");
        int pid=Integer.parseInt(request.getParameter("pid"));
        int qty=Integer.parseInt(request.getParameter("qty"));
        Float srate=Float.parseFloat(request.getParameter("srate"));
                
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs0=null;
            ResultSet rs=null;
            try {
                con = Database.getConnection();
                String query0="select SR_NAME from retailer_info where R_NAME=?";
                ps = con.prepareStatement(query0);
                ps.setString(1, retname);
                rs0=ps.executeQuery();
                rs0.next();
                String srname=rs0.getString("SR_NAME");
                String query="select PRODUCT_NAME, PURSE_PRICE from product_stock where SI_NO=?";
                ps = con.prepareStatement(query);
                ps.setInt(1, pid);
                rs = ps.executeQuery();
                while (rs.next()) {
                    String pname=rs.getString("PRODUCT_NAME");
                    Float prsprice=rs.getFloat("PURSE_PRICE");
               
                String query1="insert into order_list (RETAILER_NAME, PRODUCT_NAME, PRODUCT_NO, QUANTITY, PURSE_RATE, SALE_RATE, SR_NAME, DATE) values"
                        + "(?,?,?,?,?,?,?,CURDATE())";
                ps = con.prepareStatement(query1);
                ps.setString(1, retname);
                ps.setString(2, pname);
                ps.setInt(3, pid);
                ps.setInt(4, qty);
                ps.setFloat(5, prsprice);
                ps.setFloat(6, srate);
                ps.setString(7, srname);
                int b = ps.executeUpdate();
                    if (b > 0) {
                        response.sendRedirect("accountant.jsp");
                    }else{
                        out.println("Order is not Entryed");
                    }
                     }
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (rs0 != null) rs0.close(); } catch (SQLException ex2) { }
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
