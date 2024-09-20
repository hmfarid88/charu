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
public class RetailerDelServlet extends HttpServlet {

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
        
            String oldretailer = request.getParameter("oldretailer");
            String retailer = request.getParameter("retailer");
            String proprietor = request.getParameter("proprietor");
            String thana = request.getParameter("thana");
            String zilla = request.getParameter("zilla");
            String area = request.getParameter("area");
            String manager = request.getParameter("manager");
            String mobile = request.getParameter("mobile");
            String bday = request.getParameter("bday");
            String mday = request.getParameter("mday");
            String sp = request.getParameter("sp");
            String type = request.getParameter("type");
           
            Connection con = null;
            PreparedStatement ps = null;
            

            try {
                con = Database.getConnection();
                String query = "update retailer_info set R_NAME=?, PRO_NAME=?, THANA=?, ZILLA=?, AREA=?, MAN_NAME=?, M_NUMBER=?, D_O_B=?, D_O_M=?, TYPE=?, SR_NAME=?  where  R_NAME=? ";
                ps = con.prepareStatement(query);
                ps.setString(1, retailer);
                ps.setString(2, proprietor);
                ps.setString(3, thana);
                ps.setString(4, zilla);
                ps.setString(5, area);
                ps.setString(6, manager);
                ps.setString(7, mobile);
                ps.setString(8, bday);
                ps.setString(9, mday);
                ps.setString(10, type);
                ps.setString(11, sp);
                ps.setString(12, oldretailer);
                int a = ps.executeUpdate();
                if (a > 0) {
                    String query1="update customer_pay set RETAILER=? where RETAILER=? ";
                    ps = con.prepareStatement(query1);
                    ps.setString(1, retailer);
                    ps.setString(2, oldretailer);
                    ps.executeUpdate();
                    String query2="update order_delevery set ORDER_NAME=? where ORDER_NAME=? ";
                    ps = con.prepareStatement(query2);
                    ps.setString(1, retailer);
                    ps.setString(2, oldretailer);
                    ps.executeUpdate();
                    String query3="update order_list set RETAILER_NAME=? where RETAILER_NAME=? ";
                    ps = con.prepareStatement(query3);
                    ps.setString(1, retailer);
                    ps.setString(2, oldretailer);
                    ps.executeUpdate();
                    String query4="update transport_pay set RETAILER=? where RETAILER=? ";
                    ps = con.prepareStatement(query4);
                    ps.setString(1, retailer);
                    ps.setString(2, oldretailer);
                    ps.executeUpdate();
                    String query5="update rtler_commission set RETAILER_NAME=? where RETAILER_NAME=? ";
                    ps = con.prepareStatement(query5);
                    ps.setString(1, retailer);
                    ps.setString(2, oldretailer);
                    ps.executeUpdate();
                    out.println("<h3>Update Successful</h3>");
                } else {
                    out.println("Retailer info is not updated");
                }
                
            } catch (SQLException ex) {
ex.printStackTrace();
            }finally {

   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
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
