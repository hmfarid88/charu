
package Pojo;

import DB.Database;
import Model.DeleteModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class DeletePojo {
 public List<DeleteModel> Stockentrytoday() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, PRODUCT_NAME, QUANTITY, PURSE_PRICE  from factory_stock order by SI_NO DESC limit 1";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             DeleteModel dm=new DeleteModel();
             dm.setSino(rs.getInt(1));
             dm.setProduct(rs.getString(2));
             dm.setQty(rs.getInt(3));
             dm.setRate(rs.getFloat(4));
             list.add(dm);
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
  public List<DeleteModel> EmpcostDel() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, EMP_NAME, COST_NAME, AMOUNT  from emp_cost where DATE=CURDATE()";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             DeleteModel dm=new DeleteModel();
             dm.setEmpsi(rs.getInt(1));
             dm.setEmpname(rs.getString(2));
             dm.setEmpcost(rs.getString(3));
             dm.setEmpamount(rs.getFloat(4));
             list.add(dm);
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
  public List<DeleteModel> TransportPayDel() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = Database.getConnection();
            String query1="select SI_NO, TRANSPORT_NAME, PAYMENT from transport_pay where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) and PAYMENT>0";
             ps = con.prepareStatement(query1);
             rs = ps.executeQuery();
            while (rs.next()) {
             DeleteModel dm=new DeleteModel();
             dm.setTrsi(rs.getInt(1));
             dm.setTransport(rs.getString(2));
             dm.setTpay(rs.getFloat(3));
             list.add(dm);
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
  public List<DeleteModel> DeliveryDel() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = Database.getConnection();
            String query = "select SI_NO, ORDER_NAME, PRODUCT_NAME, QTY, RATE  from order_delevery where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) and QTY>0";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
            DeleteModel dm=new DeleteModel();
            dm.setOdsi(rs.getInt(1));
            dm.setOdname(rs.getString(2));
             dm.setOdproduct(rs.getString(3));
             dm.setOdqty(rs.getInt(4));
             dm.setOdrate(rs.getFloat(5));
             list.add(dm);
            } 
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close();} catch (SQLException ex2) { }
  try { if (ps != null) ps.close();} catch (SQLException ex2) { }
  try { if (con != null) con.close();} catch (SQLException ex2) { }
}
            return list;
    }
  public List<DeleteModel> RetlerPayUp() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        try {
            con = Database.getConnection();
           
            String query = "select SI_NO, RETAILER, AMOUNT from customer_pay where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
            DeleteModel dm=new DeleteModel();
            dm.setRtpaysi(rs.getInt(1));
            dm.setRtpayname(rs.getString(2));
            dm.setRtpayamount(rs.getFloat(3));
             list.add(dm);
            } 
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs1 != null) rs1.close();} catch (SQLException ex2) { }
  try { if (rs != null) rs.close();} catch (SQLException ex2) { }
  try { if (ps != null) ps.close();} catch (SQLException ex2) { }
  try { if (con != null) con.close();} catch (SQLException ex2) { }
}
            return list;
    }
  public List<DeleteModel> FactoryPayUp() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        try {
            con = Database.getConnection();
            String query = "select MAX(SI_NO) from factory_stock group by PURSE_FROM";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            
            while (rs.next()) {
            int maxsi=rs.getInt(1);
            String query1 = "select SI_NO, PURSE_FROM, PAYMENT from factory_stock where PAYMENT>0 and SI_NO=?";
            ps = con.prepareStatement(query1);
            ps.setInt(1, maxsi);
            rs1 = ps.executeQuery();
            while (rs1.next()) {
            DeleteModel dm=new DeleteModel();
            dm.setFacpaysi(rs1.getInt(1));
            dm.setFacpayname(rs1.getString(2));
            dm.setFacpayamount(rs1.getFloat(3));
             list.add(dm);
            } }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs1 != null) rs1.close();} catch (SQLException ex2) { }
  try { if (rs != null) rs.close();} catch (SQLException ex2) { }
  try { if (ps != null) ps.close();} catch (SQLException ex2) { }
  try { if (con != null) con.close();} catch (SQLException ex2) { }
}
            return list;
    }
  
  public List<DeleteModel> OfficecostDel() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, COST_NAME, AMOUNT  from cost order by SI_NO DESC limit 10";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             DeleteModel dm=new DeleteModel();
             dm.setOffcostsi(rs.getInt(1));
             dm.setOffcostname(rs.getString(2));
             dm.setOffcostamount(rs.getFloat(3));
             list.add(dm);
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
  public List<DeleteModel> PropricostDel() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, PAY_NAME, PAYMENT, RECEIVE  from proprietor_cost where DATE=CURDATE()";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             DeleteModel dm=new DeleteModel();
             dm.setProsi(rs.getInt(1));
             dm.setPropayname(rs.getString(2));
             dm.setPropay(rs.getFloat(3));
             dm.setProrecv(rs.getFloat(4));
             list.add(dm);
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
  
  public List<DeleteModel> BanktransiDel() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, TYPE, AMOUNT, BANK  from bank_transition where DATE=CURDATE()";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             DeleteModel dm=new DeleteModel();
             dm.setBanksi(rs.getInt(1));
             dm.setBank(rs.getString(4));
             dm.setBanktype(rs.getString(2));
             dm.setBankamount(rs.getFloat(3));
             list.add(dm);
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
  public List<DeleteModel> DebitDel() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, DEBIT_NAME, AMOUNT  from cash_debit where DATE=CURDATE()";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             DeleteModel dm=new DeleteModel();
             dm.setDebitsi(rs.getInt(1));
             dm.setDebitname(rs.getString(2));
             dm.setDebitamount(rs.getFloat(3));
             list.add(dm);
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
  
  public List<DeleteModel> CreditDel() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, CREDIT_NAME, AMOUNT  from cash_credit where DATE=CURDATE()";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             DeleteModel dm=new DeleteModel();
             dm.setCreditsi(rs.getInt(1));
             dm.setCreditname(rs.getString(2));
             dm.setCreditamount(rs.getFloat(3));
             list.add(dm);
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
  
  public List<DeleteModel> EndDel() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, USER_NAME, ADDRESS  from end_user order by USER_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             DeleteModel dm=new DeleteModel();
             dm.setEndsi(rs.getInt(1));
             dm.setEnduser(rs.getString(2));
             dm.setEndaddress(rs.getString(3));
             list.add(dm);
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
}
