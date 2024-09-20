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
public class Fac_commiServlet extends HttpServlet {

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
        
        String rtname=request.getParameter("retailer");
        String trname=request.getParameter("trname");
        String stdate=request.getParameter("stdate");
        String enddate=request.getParameter("enddate");
        Float amount=Float.parseFloat(request.getParameter("amount"));
        int month=Integer.parseInt(request.getParameter("month"));
        int year=Integer.parseInt(request.getParameter("year"));
                
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs=null;               
        try{
            con = Database.getConnection();
            String query="insert into fac_commission (FACTORY_NAME, COM_NAME, MONTH, YEAR, AMOUNT, START_DATE, END_DATE, DATE) values (?,?,?,?,?,?,?, CURDATE())";
            ps = con.prepareStatement(query);
            ps.setString(1, rtname);
            ps.setString(2, trname);
            ps.setInt(3, month);
            ps.setInt(4, year);
            ps.setFloat(5, amount);
            ps.setString(6, stdate);
            ps.setString(7, enddate);
            int a=ps.executeUpdate();
            if(a>0){
                String qury="select max(SI_NO) from fac_commission order by SI_NO desc limit 1";
                ps = con.prepareStatement(qury);
                rs=ps.executeQuery();
                rs.next();
                int sino=rs.getInt(1);
                String query1 = "insert into factory_stock (PURSE_FROM, COM_NAME, COM_AMOUNT, DATE, COMMI_NO) values (?,?,?,?,?)";
                ps = con.prepareStatement(query1);
                ps.setString(1, rtname);
                ps.setString(2, trname);
                ps.setFloat(3, amount);
                ps.setString(4, enddate);
                ps.setInt(5, sino);
                ps.executeUpdate();
                response.sendRedirect("accountant.jsp");
            }else{
                out.println("Commission is not Added!");
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
