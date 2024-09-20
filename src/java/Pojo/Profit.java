/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Pojo;

import DB.Database;
import Model.SaleModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class Profit {
//    public List<SaleModel> SaleShow() {
//        List<SaleModel> list = new ArrayList<>();
//        Connection con = null;
//        PreparedStatement ps = null;
//        ResultSet rs = null;
//        try {
//            con = Database.getConnection();
//            String query = "select ORDER_NAME, ORDER_DATE, PRODUCT_NAME, QTY, PURSE_RATE, RATE, DATE from order_delevery where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) order by DATE, ORDER_NAME";
//            ps = con.prepareStatement(query);
//            rs = ps.executeQuery();
//            while (rs.next()) {
//                SaleModel sm = new SaleModel();
//
//                sm.setOdname(rs.getString(1));
//                sm.setOddate(rs.getString(2));
//                sm.setProname(rs.getString(3));
//                sm.setQty(rs.getInt(4));
//                sm.setPurserate(rs.getFloat(5));
//                sm.setRate(rs.getFloat(6));
//                sm.setSldate(rs.getString(7));
//
//                list.add(sm);
//            }
//            }catch (SQLException ex) {
//            ex.printStackTrace();
//        }finally {
//  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
//  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
//  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
//}
//        return list;
//    }   
    
//    public SaleModel TotalSale(){
//        Connection con = null;
//        PreparedStatement ps = null;
//        ResultSet rs = null;
//        SaleModel sml=null;
//        try {
//            con = Database.getConnection();
//            String query = "select sum(QTY), sum(QTY*RATE), sum(QTY*PURSE_RATE) from order_delevery where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
//            ps = con.prepareStatement(query);
//            rs = ps.executeQuery();
//            while (rs.next()) {
//             Float trate=rs.getFloat(2);
//             Float tpurse=rs.getFloat(3);
//             Float profit=trate-tpurse;
//             sml=new SaleModel(); 
//             
//             sml.setTotalqty(rs.getInt(1));
//             sml.setTotalrate(profit);
//             sml.setTotalsale(trate);
//    }
//        }catch (SQLException ex) {
//            ex.printStackTrace();
//        }finally {
//  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
//  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
//  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
//}
//        return sml;
//    }
    
    public List<SaleModel> MonthlySaleShow() {
        List<SaleModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select ORDER_NAME, ORDER_DATE, PRODUCT_NAME, QTY, PURSE_RATE, RATE, DATE from order_delevery where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) and QTY>0";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                SaleModel sm = new SaleModel();

                sm.setDodname(rs.getString(1));
                sm.setDoddate(rs.getString(2));
                sm.setDproname(rs.getString(3));
                sm.setDqty(rs.getInt(4));
                sm.setDpurserate(rs.getFloat(5));
                sm.setDrate(rs.getFloat(6));
                sm.setDsldate(rs.getString(7));

                list.add(sm);
            }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    }   
   
    public SaleModel MonthlyTotalSale(){
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        SaleModel sml=null;
        try {
            con = Database.getConnection();
            String query = "select sum(QTY), sum(QTY*RATE), sum(QTY*PURSE_RATE) from order_delevery where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             Long trate=rs.getLong(2);
             Long tpurse=rs.getLong(3);
             Long profit=trate-tpurse;
             int qty=rs.getInt(1);
             sml=new SaleModel(); 
             if(qty<1){
                 int avprate=rs.getInt(3)/1;
                 int avsrate=rs.getInt(2)/1;
                 sml.setAvprate(avprate);
                 sml.setAvsrate(avsrate);
                 sml.setDtotalqty(rs.getInt(1));
                 sml.setDtotalrate(profit);
                 sml.setDtotalsale(trate);
             }else{
                int avprate = rs.getInt(3) / rs.getInt(1);
                int avsrate = rs.getInt(2) / rs.getInt(1);
                sml.setDtotalqty(rs.getInt(1));
                sml.setDtotalrate(profit);
                sml.setDtotalsale(trate);
                sml.setAvprate(avprate);
                sml.setAvsrate(avsrate);
             }
    }
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return sml;
    }
    public SaleModel DailyTotalSale(){
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        SaleModel sml=null;
        try {
            con = Database.getConnection();
            String query = "select sum(QTY), sum(QTY*RATE) from order_delevery where DATE=CURDATE()";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             sml=new SaleModel(); 
             sml.setDtsqty(rs.getInt(1));
             sml.setDtsp(rs.getLong(2));
             
            }
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return sml;
    }
    
  public List<SaleModel> TargetShow() {
        List<SaleModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select FACTORY_NAME, COM_NAME, AMOUNT, START_DATE, END_DATE from fac_commission where YEAR(END_DATE) = YEAR(CURRENT_DATE()) AND MONTH(END_DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                SaleModel sm = new SaleModel();
                sm.setTrfname(rs.getString(1));
                sm.setTrname(rs.getString(2));
                sm.setTramount(rs.getDouble(3));
                sm.setStdate(rs.getString(4));
                sm.setEnddate(rs.getString(5));
                list.add(sm);
            }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    }     
     public SaleModel TotalCommission(){
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        SaleModel sml=null;
        try {
            con = Database.getConnection();
            String query = "select sum(AMOUNT) from fac_commission where  YEAR(END_DATE) = YEAR(CURRENT_DATE()) AND MONTH(END_DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             sml=new SaleModel(); 
             sml.setCommission(rs.getLong(1));
    }
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return sml;
    }
     public List<SaleModel> MonthlyCostShow() {
        List<SaleModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select COST_NAME, AMOUNT, DATE from cost where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                SaleModel sm = new SaleModel();
               sm.setCostname(rs.getString(1));
               sm.setCostamount(rs.getFloat(2));
               sm.setCostdate(rs.getString(3));
                list.add(sm);
            }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    }     
    public SaleModel TotalCost(){
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        SaleModel sml=null;
        try {
            con = Database.getConnection();
            String query = "select sum(AMOUNT) from cost where  YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             sml=new SaleModel(); 
             sml.setTotalcost(rs.getLong(1));
    }
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return sml;
    }
    
    public SaleModel RetailerCommission(){
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        SaleModel sml=null;
        try {
            con = Database.getConnection();
            String query = "select sum(AMOUNT) from rtler_commission where  YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             sml=new SaleModel(); 
             sml.setTotalcommi(rs.getLong(1));
    }
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return sml;
    }
    public List<SaleModel> MonthlyEmpCostShow() {
        List<SaleModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select EMP_NAME, COST_NAME, AMOUNT, DATE from emp_cost where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                SaleModel sm = new SaleModel();
               sm.setEmpname(rs.getString(1));
               sm.setEmpcost(rs.getString(2));
               sm.setEmpcostamount(rs.getFloat(3));
               sm.setEmpcostdate(rs.getString(4));
                list.add(sm);
            }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    }     
     public SaleModel TotalEmpCost(){
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        SaleModel sml=null;
        try {
            con = Database.getConnection();
            String query = "select sum(AMOUNT) from emp_cost where  YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             sml=new SaleModel(); 
             sml.setTotalempcost(rs.getLong(1));
    }
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return sml;
    }
}
