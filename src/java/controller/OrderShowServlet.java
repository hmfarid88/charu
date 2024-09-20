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
public class OrderShowServlet extends HttpServlet {

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
        
          response.setContentType("text/html;charset=UTF-8");
          PrintWriter out = response.getWriter();
        
                int odsi=Integer.parseInt(request.getParameter("odsi"));
                Connection con=null;
                PreparedStatement ps=null;
                ResultSet rs=null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, RETAILER_NAME, PRODUCT_NAME, PRODUCT_NO, QUANTITY, PURSE_RATE, SALE_RATE, SR_NAME, DATE from order_list where  SI_NO =? ";
            ps = con.prepareStatement(query);
            ps.setInt(1, odsi);
            rs = ps.executeQuery();
            while (rs.next()) {
                int sino=rs.getInt("SI_NO");
                String retler = rs.getString("RETAILER_NAME");
                String proname = rs.getString("PRODUCT_NAME");
                int prono=rs.getInt("PRODUCT_NO");
                int qnt=rs.getInt("QUANTITY");
                Float prsrate=rs.getFloat("PURSE_RATE");
                Float srate=rs.getFloat("SALE_RATE");
                String srname=rs.getString("SR_NAME");
                String date = rs.getString("DATE");

                request.getSession().setAttribute("SINO", sino);
                request.getSession().setAttribute("RTLER", retler);
                request.getSession().setAttribute("PRONAME", proname);
                request.getSession().setAttribute("PRONO", prono);
                request.getSession().setAttribute("QNT", qnt);
                request.getSession().setAttribute("PRSRATE", prsrate);
                request.getSession().setAttribute("SRATE", srate);
                request.getSession().setAttribute("SR", srname);
                request.getSession().setAttribute("DATE", date);
                
              }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
          try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
      try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
   response.sendRedirect("order_delevery.jsp");
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
