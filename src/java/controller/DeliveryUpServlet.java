/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DB.Database;
import java.io.IOException;
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
public class DeliveryUpServlet extends HttpServlet {

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
                
        int delsi=Integer.parseInt(request.getParameter("odsi"));
        Connection con=null;
        PreparedStatement ps=null;
        ResultSet rs = null;
        try{
            con=Database.getConnection();
            String query = "select SI_NO, ORDER_NAME, NOTE, ORDER_DATE, PRODUCT_NAME, QTY, PURSE_RATE, RATE, TRUCK_NO, RENT, TRANSPORT, SP_NAME from order_delevery where SI_NO=?";
            ps = con.prepareStatement(query);
            ps.setInt(1, delsi);
            rs = ps.executeQuery();
            rs.next();
            request.getSession().setAttribute("dsi", rs.getInt(1));
            request.getSession().setAttribute("dodname", rs.getString(2));
            request.getSession().setAttribute("dnote", rs.getString(3));
            request.getSession().setAttribute("ddate", rs.getString(4));
            request.getSession().setAttribute("dproduct", rs.getString(5));
            request.getSession().setAttribute("dqty", rs.getInt(6));
            request.getSession().setAttribute("dprate", rs.getFloat(7));
            request.getSession().setAttribute("drate", rs.getFloat(8));
            request.getSession().setAttribute("dtrucno", rs.getString(9));
            request.getSession().setAttribute("dtrent", rs.getFloat(10));
            request.getSession().setAttribute("dtport", rs.getString(11));
            request.getSession().setAttribute("dspname", rs.getString(12));
            response.sendRedirect("delivery_up.jsp");
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
