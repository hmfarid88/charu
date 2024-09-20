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
public class FcpSelectServlet extends HttpServlet {

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
       int fpno=Integer.parseInt(request.getParameter("fpsi"));
        Connection con=null;
        PreparedStatement ps=null;
        ResultSet rs = null;
        try{
            con=Database.getConnection();
            String query = "select SI_NO, COMPANY_NAME, PAY_TYPE, NOTE, AMOUNT, BANK_NAME, BRANCE_NAME, CHEQUE_NO, PAYER, STOCK_NO, DATE from company_payment where SI_NO=?";
            ps = con.prepareStatement(query);
            ps.setInt(1, fpno);
            rs = ps.executeQuery();
            rs.next();
            request.getSession().setAttribute("rpsi", rs.getInt(1));
            request.getSession().setAttribute("retailer", rs.getString(2));
            request.getSession().setAttribute("type", rs.getString(3));
            request.getSession().setAttribute("note", rs.getString(4));
            request.getSession().setAttribute("amount", rs.getFloat(5));
            request.getSession().setAttribute("bank", rs.getString(6));
            request.getSession().setAttribute("branch", rs.getString(7));
            request.getSession().setAttribute("checq", rs.getString(8));
            request.getSession().setAttribute("payer", rs.getString(9));
            request.getSession().setAttribute("delno", rs.getInt(10));
            request.getSession().setAttribute("date", rs.getString(11));
           
            response.sendRedirect("fac_pay_up.jsp");
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
