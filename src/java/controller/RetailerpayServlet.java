
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


public class RetailerpayServlet extends HttpServlet {

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
        
        String rtname=request.getParameter("rtname");
        Float amount=Float.parseFloat(request.getParameter("amount"));
        String paytype=request.getParameter("paytype");
        String bank=request.getParameter("bank");
        String branch=request.getParameter("branch");
        String payer=request.getParameter("payer");
        String note=request.getParameter("note");
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs0=null;
        ResultSet rs=null;
           
        try{
            con = Database.getConnection();
            String query0="select SR_NAME from retailer_info where R_NAME=?";
                ps = con.prepareStatement(query0);
                ps.setString(1, rtname);
                rs0=ps.executeQuery();
                rs0.next();
                String srname=rs0.getString("SR_NAME");
              String query11 = "insert into order_delevery (ORDER_NAME, PAYMENT, PAY_NOTE, SP_NAME, DATE) values (?,?,?,?,CURDATE())";
                    ps = con.prepareStatement(query11);
                    ps.setString(1, rtname);
                    ps.setDouble(2, amount);
                    ps.setString(3, note);
                    ps.setString(4, srname);
                    int a=ps.executeUpdate();
                    if(a>0){
            String sino="select MAX(SI_NO) from  order_delevery order by SI_NO DESC limit 1";
            ps=con.prepareStatement(sino);
            rs=ps.executeQuery();
            rs.next();
            int rtno=rs.getInt(1);  
            String query="insert into customer_pay (RETAILER, PAY_TYPE, AMOUNT, COLLECTED_BY, NOTE, BANK_NAME, BRANCH, PAYER, DEL_NO, DATE) values (?,?,?,?,?,?,?,?,?,CURDATE())";
            ps=con.prepareStatement(query);
            ps.setString(1, rtname);
            ps.setString(2, paytype);
            ps.setFloat(3, amount);
            ps.setString(4, srname);
            ps.setString(5, note);
            ps.setString(6, bank);
            ps.setString(7, branch);
            ps.setString(8, payer);
            ps.setInt(9, rtno);
            ps.executeUpdate();
            response.sendRedirect("accountant.jsp");
            }
            
        }catch (Exception ex) {
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
