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
public class OrderDeleveryServlet extends HttpServlet {

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
        String odname=request.getParameter("odname");
        String oddate=request.getParameter("oddate");
        String proname=request.getParameter("proname");
        String spname=request.getParameter("spname");
        String note=request.getParameter("note");
        int qty=Integer.parseInt(request.getParameter("qty"));
        Float prsrate=Float.parseFloat(request.getParameter("prsrate"));
        Float rate=Float.parseFloat(request.getParameter("rate"));
        String truckno=request.getParameter("truckno");
        String transport=request.getParameter("transport");
        Float rent=Float.parseFloat(request.getParameter("rent"));
        int sino=Integer.parseInt(request.getParameter("sino"));
             
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            ResultSet rs1=null; 
            ResultSet rs2=null;
            ResultSet rs3=null;
            
            try {
                con = Database.getConnection();
                String proqty="select QUANTITY from product_stock where  PRODUCT_NAME=? and PURSE_PRICE=?";
                ps = con.prepareStatement(proqty);
                ps.setString(1, proname);
                ps.setFloat(2, prsrate);
                rs=ps.executeQuery();
                rs.next();
                int pqty=rs.getInt(1);
                if(pqty<qty){
                 out.println("Sorry ! you don't have enough product");
                }else{
                        String query = "insert into order_delevery (ORDER_NAME, NOTE, ORDER_DATE, PRODUCT_NAME, QTY, PURSE_RATE, RATE,"
                                + "TRUCK_NO, RENT, TRANSPORT, SP_NAME, DATE) values (?,?,?,?,?,?,?,?,?,?,?,CURDATE())";
                        ps = con.prepareStatement(query);
                        ps.setString(1, odname);
                        ps.setString(2, note);
                        ps.setString(3, oddate);
                        ps.setString(4, proname);
                        ps.setInt(5, qty);
                        ps.setFloat(6, prsrate);
                        ps.setFloat(7, rate);
                        ps.setString(8, truckno);
                        ps.setFloat(9, rent);
                        ps.setString(10, transport);
                        ps.setString(11, spname);
                        int b = ps.executeUpdate();
                        if (b > 0) {
                            String query1 = "update product_stock set QUANTITY=QUANTITY-? where  PRODUCT_NAME=? and PURSE_PRICE=?";
                            ps = con.prepareStatement(query1);
                            ps.setInt(1, qty);
                            ps.setString(2, proname);
                            ps.setFloat(3, prsrate);
                            ps.executeUpdate();
                            String query11 = "update order_list set QUANTITY=QUANTITY-? where SI_NO=?";
                            ps = con.prepareStatement(query11);
                            ps.setInt(1, qty);
                            ps.setInt(2, sino);
                            ps.executeUpdate();
                            String query2 = "delete from order_list where  QUANTITY='0' ";
                            ps = con.prepareStatement(query2);
                            ps.executeUpdate();
                            String query3 = "delete from product_stock where  QUANTITY='0' ";
                            ps = con.prepareStatement(query3);
                            ps.executeUpdate();
                            
                            
                 String tnssi="select MAX(SI_NO) from order_delevery order by SI_NO DESC limit 1";
                 ps = con.prepareStatement(tnssi);
                 rs3=ps.executeQuery();
                 rs3.next();
                 int delsi=rs3.getInt(1);
                 String trinsert="insert into transport_pay (TRANSPORT_NAME, RETAILER, PRODUCT_NAME, TRUCK_NO, QTY, RENT, DEL_NO, DATE) values (?,?,?,?,?,?,?,CURDATE())";
                     ps = con.prepareStatement(trinsert);
                     ps.setString(1, transport);
                     ps.setString(2, odname);
                     ps.setString(3, proname);
                     ps.setString(4, truckno);
                     ps.setInt(5, qty);
                     ps.setFloat(6, rent);
                     ps.setInt(7, delsi);
                     ps.executeUpdate();
                     response.sendRedirect("order_delevery.jsp");

                        } else {
                            out.println("Delevery is not Completed");
                        }

                    }
              
            } catch (Exception ex) { 
              ex.printStackTrace();
            }finally {
   
   try { if (rs3 != null) rs3.close(); } catch (SQLException ex2) { }
   try { if (rs2 != null) rs2.close(); } catch (SQLException ex2) { }
   try { if (rs1 != null) rs1.close(); } catch (SQLException ex2) { }
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
            Connection con = null;
            PreparedStatement ps = null;
            
               try {
                con = Database.getConnection();
                    String query="update reserve_stock set PRODUCT_NAME='PCC', QUANTITY=(select sum(QUANTITY) from  product_stock where PRODUCT_NAME='PCC'), PURSE_PRICE=(select sum(PURSE_PRICE) from product_stock where PRODUCT_NAME='PCC') where PRODUCT_NAME='PCC' and DATE=CURDATE()";
                    ps = con.prepareStatement(query);
                    int x=ps.executeUpdate();
                   
                    if(x>0){
                    
                    }else{
                        String query2="insert into reserve_stock (PRODUCT_NAME, QUANTITY, PURSE_PRICE, DATE) values"
                        + "('PCC',(select sum(QUANTITY) from  product_stock where PRODUCT_NAME='PCC'),(select sum(PURSE_PRICE) from product_stock where PRODUCT_NAME='PCC'),CURDATE())";
                        ps = con.prepareStatement(query2);
                        ps.executeUpdate();
                    
                    }
                                
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }
      try {
                con = Database.getConnection();
                    String query1="update reserve_stock set PRODUCT_NAME='PC', QUANTITY=(select sum(QUANTITY) from  product_stock where PRODUCT_NAME='PC'), PURSE_PRICE=(select sum(PURSE_PRICE) from product_stock where PRODUCT_NAME='PC') where PRODUCT_NAME='PC' and DATE=CURDATE()";
                    ps = con.prepareStatement(query1);
                    int y=ps.executeUpdate(); 
                    if(y>0){
                    
                    }else{
                                              
                         String query3="insert into reserve_stock (PRODUCT_NAME, QUANTITY, PURSE_PRICE, DATE) values"
                        + "('PC',(select sum(QUANTITY) from  product_stock where PRODUCT_NAME='PC'),(select sum(PURSE_PRICE) from product_stock where PRODUCT_NAME='PC'),CURDATE())";
                        ps = con.prepareStatement(query3);
                        ps.executeUpdate();
                    }
                                
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
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

