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
public class EndUser_Servlet extends HttpServlet {

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
       
       String name=request.getParameter("name");
       String mnumber=request.getParameter("mnumber");
       String address=request.getParameter("address");
       String engname=request.getParameter("engname");
       String contname=request.getParameter("contname");
       String status=request.getParameter("status");
       String cause=request.getParameter("cause");
       String remark=request.getParameter("remark");
       
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            try {
                con = Database.getConnection();
                String query = "select count(*) from end_user where  USER_NAME=?";
                ps = con.prepareStatement(query);
                ps.setString(1, name);
                rs = ps.executeQuery();
                rs.next();
                int a = rs.getInt(1);
                if (a > 0) {
                   out.println("<h3>This user is already exist!</h3>");
                } else {
                String query1="insert into end_user (USER_NAME, MOBILE, ADDRESS, ENG_NAME, CONTRACTOR, STATUS, CAUSE, REMARK, DATE)"
                        + "values (?,?,?,?,?,?,?,?,CURDATE())";
                ps = con.prepareStatement(query1);
                ps.setString(1, name);
                ps.setString(2, mnumber);
                ps.setString(3, address);
                ps.setString(4, engname);
                ps.setString(5, contname);
                ps.setString(6, status);
                ps.setString(7, cause);
                ps.setString(8, remark);
                
                int b = ps.executeUpdate();
                    if (b > 0) {
                        response.sendRedirect("end_user.jsp");
                    }else{
                        out.println("Entry is not Success");
                    }
                }
            } catch (Exception ex) {
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
