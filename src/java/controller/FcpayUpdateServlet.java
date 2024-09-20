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
public class FcpayUpdateServlet extends HttpServlet {

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
        int delno=Integer.parseInt(request.getParameter("delno"));
        String rtname=request.getParameter("retailer");
        Float amount=Float.parseFloat(request.getParameter("amount"));
        String paytype=request.getParameter("type");
        String cby=request.getParameter("cby");
        String bank=request.getParameter("bank");
        String branch=request.getParameter("branch");
        String cheque=request.getParameter("cheque");
        String payer=request.getParameter("payer");
        String note=request.getParameter("note");
        String date=request.getParameter("date");
        Connection con = null;
        PreparedStatement ps = null;
               
         try{
            con = Database.getConnection();
                String payup="update company_payment set COMPANY_NAME=?, PAY_TYPE=?, NOTE=?, AMOUNT=?,  BANK_NAME=?, BRANCE_NAME=?, CHEQUE_NO=?, PAYER=?, DATE=? where SI_NO=?";
                ps=con.prepareStatement(payup);
                ps.setString(1, rtname);
                ps.setString(2, paytype);
                ps.setString(3, note);
                ps.setFloat(4, amount);
                ps.setString(5, bank);
                ps.setString(6, branch);
                ps.setString(7, cheque);
                ps.setString(8, payer);
                ps.setString(9, date);
                ps.setInt(10, sino);
                int a=ps.executeUpdate();
                if(a>0){
                    String up="update factory_stock set PURSE_FROM=?,  PAYMENT=?, DATE=? where  SI_NO=?";
                ps=con.prepareStatement(up);
                ps.setString(1, rtname);
                ps.setFloat(2, amount);
                ps.setString(3, date);
                ps.setInt(4, delno);
                ps.executeUpdate();
                response.sendRedirect("fac_pay_up.jsp");
                }else{
                  out.println("Sorry, Update is not completed !");
                }
               
        }catch (Exception ex) {
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
