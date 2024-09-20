
package Pojo;

import DB.Database;
import Model.Accountant;
import Model.EmpModel;
import Model.StockModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class AccountPojo {

    public List<Accountant> retailerView() {
        List<Accountant> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select R_NAME from retailer_info where TYPE='Active' order by R_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             Accountant ac=new Accountant();
             ac.setRetailer(rs.getString(1));
             list.add(ac);
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
       
    public List<Accountant> FactoryView() {
        List<Accountant> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select FACTORY_NAME from factory_name order by FACTORY_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             Accountant ac=new Accountant();
             ac.setFactory(rs.getString(1));
             list.add(ac);
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
  
       
 public List<Accountant> OrderShow() {
        List<Accountant> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, RETAILER_NAME, PRODUCT_NAME from order_list order by RETAILER_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             Accountant act=new Accountant();
             act.setSi(rs.getInt(1));
             act.setRtname(rs.getString(2));
             act.setProname(rs.getString(3));
            
             list.add(act);
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
 public List<Accountant> BankShow() {
        List<Accountant> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select BANK_NAME from bank_name order by BANK_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             Accountant act=new Accountant();
             act.setBank(rs.getString(1));
                        
             list.add(act);
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
 public List<Accountant> TransportShow() {
        List<Accountant> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select TRANSPORT_NAME from transport_name order by TRANSPORT_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             Accountant act=new Accountant();
             act.setTransport(rs.getString(1));
                        
             list.add(act);
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
 
 public List<StockModel> StockShow() {
        List<StockModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select * from product_stock order by PRODUCT_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             StockModel stm=new StockModel();
             stm.setSi(rs.getInt(1));
             stm.setProname(rs.getString(2));
             stm.setPfrom(rs.getString(3));
             stm.setQty(rs.getInt(4));
             stm.setRate(rs.getFloat(5));
             stm.setDate(rs.getString(6));
             stm.setTotal(rs.getInt(4)*rs.getFloat(5));
            
             list.add(stm);
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
 public List<StockModel> StockSummary() {
        List<StockModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, PRODUCT_NAME, PURSE_PRICE, QUANTITY from product_stock order by PRODUCT_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             StockModel stm=new StockModel();
             stm.setSino(rs.getInt(1));
             stm.setProduct(rs.getString(2));
             stm.setPurserate(rs.getFloat(3));
             stm.setQnt(rs.getInt(4));
             
             list.add(stm);
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
 
 public StockModel TotalStock(){
        StockModel stm=null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rs3 = null;
        try {
            con = Database.getConnection();
            String query="select sum(QUANTITY), sum(QUANTITY*PURSE_PRICE) from product_stock";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            rs.next();
            stm=new StockModel();
            stm.setTotalqty(rs.getInt(1));
            stm.setTotalvalu(rs.getFloat(2));
            String query1="select count(SI_NO), sum(QUANTITY) from  order_list";
            ps = con.prepareStatement(query1);
            rs1 = ps.executeQuery();
            rs1.next();
            String query2="select sum(QUANTITY), sum(QUANTITY*PURSE_PRICE) from product_stock where PRODUCT_NAME='PCC'";
            ps = con.prepareStatement(query2);
            rs2 = ps.executeQuery();
            rs2.next();
            String query3="select sum(QUANTITY), sum(QUANTITY*PURSE_PRICE) from product_stock where PRODUCT_NAME='PC'";
            ps = con.prepareStatement(query3);
            rs3 = ps.executeQuery();
            rs3.next();
            stm.setTotalorder(rs1.getInt(1));
            stm.setOdqty(rs1.getInt(2));
            stm.setPcqty(rs3.getInt(1));
            stm.setPcvalu(rs3.getLong(2));
            stm.setPccqty(rs2.getInt(1));
            stm.setPccvalu(rs2.getLong(2));
         
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs3 != null) rs3.close(); } catch (SQLException ex2) { }
  try { if (rs2 != null) rs2.close(); } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
  try { if (con != null) con.close(); } catch (SQLException ex2) { }
}
        return stm;    
        
 }
  
 public List<Accountant> TransportLedger() {
        List<Accountant> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rss = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;       
        try {
            con = Database.getConnection();
            String tname="select TRANSPORT_NAME from transport_name";
            ps = con.prepareStatement(tname);
            rs = ps.executeQuery();
            while (rs.next()) {
            String transport=rs.getString(1);
          
            String query = "select sum(RENT), sum(PAYMENT) from transport_pay where  TRANSPORT_NAME=?";
            ps = con.prepareStatement(query);
            ps.setString(1, transport);
            rs1 = ps.executeQuery();
            while (rs1.next()) {
            String query2 = "select sum(QTY), sum(RENT), sum(PAYMENT) from transport_pay where  TRANSPORT_NAME=? and YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query2);
            ps.setString(1, transport);
            rs2 = ps.executeQuery();
            while (rs2.next()) {              
             Accountant ac=new Accountant();
             ac.setTport(rs.getString(1));
             ac.setQty(rs2.getInt(1));
             ac.setAmount(rs2.getDouble(2));
             ac.setPay(rs2.getDouble(3));
             ac.setBalance(rs1.getLong(1)-rs1.getLong(2));
             list.add(ac);
            } } }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rss != null) rss.close(); rss=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    } 
 
 public List<StockModel> RetailerLedger() {
        List<StockModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rss = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rs3 = null;
        ResultSet rs4 = null;       
        try {
            con = Database.getConnection();
            String queryretiler="select R_NAME from retailer_info where TYPE='Active' order by R_NAME";
            ps = con.prepareStatement(queryretiler);
            rs = ps.executeQuery();
            while (rs.next()) {
             String retailer=rs.getString(1);
             String lastrtlr="select MAX(SI_NO) from order_delevery group by ORDER_NAME";
             ps = con.prepareStatement(lastrtlr);
             rss = ps.executeQuery();
             while(rss.next()){
             Long maxsi=rss.getLong(1);
             
             String odquery="select sum(QUANTITY) from order_list where  RETAILER_NAME=?";
             ps=con.prepareStatement(odquery);
             ps.setString(1, retailer);
             rs1=ps.executeQuery();
             while(rs1.next()){
            String query = "select QTY, SP_NAME from order_delevery where  ORDER_NAME=?  and SI_NO=?";
            ps = con.prepareStatement(query);
            ps.setString(1, retailer);
            ps.setLong(2, maxsi);
            rs2 = ps.executeQuery();
            
            while(rs2.next()){
            StockModel stm=new StockModel();
            stm.setDelivery(rs2.getInt(1));
            stm.setSpname(rs2.getString(2));
            String totaldel="select sum(QTY) as tqty, sum(QTY*RATE) as tvalue, sum(PAYMENT) as tpay, sum(COMMISSION) as tcomi from  order_delevery where  ORDER_NAME=?";
            ps = con.prepareStatement(totaldel);
            ps.setString(1, retailer); 
            rs3 = ps.executeQuery(); 
            while(rs3.next()){
              String qvpc="select sum(QTY) as tqty, sum(QTY*RATE) as tvalue, sum(PAYMENT) as tpay, sum(COMMISSION) as tcomi from  order_delevery where  ORDER_NAME=? and DATE > '2023-01-31'";
              ps=con.prepareStatement(qvpc);
               ps.setString(1, retailer); 
            rs4 = ps.executeQuery(); 
            while(rs4.next()){
                Long tvalu=rs4.getLong("tvalue");
              Long num=1l;
            
             stm.setRetiler(rs.getString(1));
             stm.setPod(rs1.getInt(1));
             stm.setTcommi(rs4.getLong("tcomi"));
            
             stm.setTqty(rs4.getLong("tqty"));
             stm.setValutotal(rs4.getLong("tvalue"));
             stm.setTpay(rs4.getLong("tpay"));
             stm.setRetailledger(rs3.getLong("tvalue")-rs3.getLong("tpay")-rs3.getLong("tcomi"));
             stm.setTvalue(rs4.getLong("tvalue"));
            if(tvalu<1){
                stm.setTvalue(num);
            }else{
              stm.setTvalue(rs4.getLong("tvalue"));  
            }
             list.add(stm);
            }  } } }}}
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
  try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
  try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rss != null) rss.close(); rss=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    } 
   public List<StockModel> FactoryLedger() {
        List<StockModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rss = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rs3 = null;
        ResultSet rs4 = null;
        ResultSet rs5 = null;
        try {
            con = Database.getConnection();
            String queryretiler="select FACTORY_NAME from factory_name";
            ps = con.prepareStatement(queryretiler);
            rs = ps.executeQuery();
            while (rs.next()) {
             String retailer=rs.getString(1);
             String lastrtlr="select MAX(SI_NO) from factory_stock group by PURSE_FROM";
             ps = con.prepareStatement(lastrtlr);
             rss = ps.executeQuery();
             while(rss.next()){
             int maxsi=rss.getInt(1);
             String odquery="select sum(QUANTITY), sum(PURSE_PRICE), sum(PAYMENT) from factory_stock where PURSE_FROM=? and YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) ";
             ps=con.prepareStatement(odquery);
             ps.setString(1, retailer);
             rs1=ps.executeQuery();
             while(rs1.next()){
             String total="select sum(QUANTITY*PURSE_PRICE), sum(PAYMENT) from factory_stock where PURSE_FROM=?";
             ps=con.prepareStatement(total);
             ps.setString(1, retailer);
             rs2=ps.executeQuery();
             while(rs2.next()){
                 String pro="select PRODUCT_NAME from factory_stock where PURSE_FROM=? and SI_NO=?";
             ps=con.prepareStatement(pro);
             ps.setString(1, retailer);
             ps.setInt(2, maxsi);
             rs3=ps.executeQuery();
            while(rs3.next()){
                String commission="select sum(AMOUNT) from fac_commission where FACTORY_NAME=? ";
             ps=con.prepareStatement(commission);
             ps.setString(1, retailer);
             rs4=ps.executeQuery();
             while(rs4.next()){
                 String todquery="select sum(QUANTITY), sum(PURSE_PRICE) from factory_stock where PURSE_FROM=? and YEAR(DATE) = YEAR(CURRENT_DATE())";
             ps=con.prepareStatement(todquery);
             ps.setString(1, retailer);
             rs5=ps.executeQuery();
             while(rs5.next()){
             StockModel stm=new StockModel();
             stm.setFactory(rs.getString(1));
             stm.setStockpro(rs3.getString(1));
             stm.setStockqty(rs1.getInt(1));  
             stm.setStockrate(rs1.getLong(2));
             stm.setStockpay(rs1.getLong(3) );
             stm.setTotalproqty(rs5.getInt(1));
             stm.setTotalprovalue(rs5.getLong(2));
             stm.setTotalcommission(rs4.getLong(1));
             stm.setStockbalance(rs2.getLong(1)-(rs2.getLong(2)+ rs4.getLong(1)));
             
             list.add(stm);
             } }}}}}}
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs5 != null) rs5.close(); rs5=null; } catch (SQLException ex2) { }
  try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
  try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
  try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rss != null) rss.close(); rss=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    }  
   public List<EmpModel> EmpExpense() {
        List<EmpModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
                
        try {
            con = Database.getConnection();
            String queryretiler="select E_NAME, DESIGANATION from employee_info";
            ps = con.prepareStatement(queryretiler);
            rs = ps.executeQuery();
            while (rs.next()) {
             String emp=rs.getString(1);
             String empcost="select sum(AMOUNT) from emp_cost where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) and EMP_NAME=?";
             ps=con.prepareStatement(empcost);
             ps.setString(1, emp);
             rs1=ps.executeQuery();
             while(rs1.next()){
             Float expense=rs1.getFloat(1);
             String emplimit="select AMOUNT from emp_limit where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) and EMP_NAME=?";
             ps=con.prepareStatement(emplimit);
             ps.setString(1, emp);
             rs2=ps.executeQuery();
             while(rs2.next()){
             Float limit=rs2.getFloat(1);
             Float balance=limit-expense;
             EmpModel em=new EmpModel();
             em.setEmpname(rs.getString(1));
             em.setDegination(rs.getString(2));
             em.setExpense(expense);
             em.setLimit(limit);
             em.setBalance(balance);
             list.add(em);
             } } }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  
  try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    }  
   public List<EmpModel> EmpSale() {
        List<EmpModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
                        
        try {
            con = Database.getConnection();
            String query="select SP_NAME, sum(QTY), sum(QTY*RATE), sum(PAYMENT) from order_delevery where  YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) group by SP_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             
             EmpModel em=new EmpModel();
             em.setSpname(rs.getString(1));
             em.setRate(rs.getLong(3));
             em.setQty(rs.getInt(2));
             em.setEmppay(rs.getLong(4));
             
             list.add(em);
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
    public List<StockModel> DeliveryLedger() {
        List<StockModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        try {
            con = Database.getConnection();
            String query = "select ORDER_NAME, NOTE, PRODUCT_NAME, QTY, RATE, TRUCK_NO, RENT, TRANSPORT, SP_NAME, DATE, SI_NO from order_delevery where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) and QTY>0";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             String retailer=rs.getString(1);
             String area="select THANA, AREA from retailer_info where R_NAME=?";
             ps = con.prepareStatement(area);
             ps.setString(1, retailer);
             rs1 = ps.executeQuery();
             while (rs1.next()) {
             StockModel stm=new StockModel();
             stm.setDname(rs.getString(1));
             stm.setNote(rs.getString(2));
             stm.setDpname(rs.getString(3));
             stm.setDqty(rs.getInt(4));
             stm.setSlrate(rs.getFloat(5));
             stm.setTrucno(rs.getString(6));
             stm.setTrent(rs.getFloat(7));
             stm.setTransport(rs.getString(8));
             stm.setDspname(rs.getString(9));
             stm.setDdate(rs.getString(10));
             stm.setThana(rs1.getString(1));
             stm.setArea(rs1.getString(2));
             stm.setDelno(rs.getInt("SI_NO"));
                          
             list.add(stm);
            }}
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    }
     public Accountant TotalDelivery(){
        Accountant stm=null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
                
         try {
            con = Database.getConnection();
            String costtotal="select sum(QTY), sum(QTY*RATE), sum(RENT) from order_delevery where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
             ps = con.prepareStatement(costtotal);
             rs = ps.executeQuery();
             rs.next();
             stm=new Accountant();
             stm.setTotaldqty(rs.getInt(1));
             stm.setTotald(rs.getLong(2));
             stm.setTotaltrent(rs.getLong(3));
            
           
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return stm;    
    }
    
    
    public List<Accountant> ExpenseLedger() {
        List<Accountant> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        try {
            con = Database.getConnection();
            String query = "select COST_NAME, AMOUNT, DATE from cost where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) order by DATE, COST_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             
             Accountant stm=new Accountant();
             stm.setCostname(rs.getString(1));
             stm.setCostamount(rs.getFloat(2));
             stm.setCostdate(rs.getString(3));
            
             list.add(stm);
            }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    } 
   public Accountant TotalExpense(){
        Accountant stm=null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
                
         try {
            con = Database.getConnection();
            String costtotal="select sum(AMOUNT) from cost where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
             ps = con.prepareStatement(costtotal);
             rs = ps.executeQuery();
             rs.next();
             stm=new Accountant();
             stm.setCosttotal(rs.getDouble(1));
            
           
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return stm;    
    }
   public List<Accountant> MonthlyDebitLedger() {
        List<Accountant> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        try {
            con = Database.getConnection();
            String query = "select DEBIT_NAME, AMOUNT, DATE from cash_debit where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) order by DATE, DEBIT_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             
             Accountant stm=new Accountant();
             stm.setDebitname(rs.getString(1));
             stm.setDebitamount(rs.getLong(2));
             stm.setDebitdate(rs.getString(3));
            
             list.add(stm);
            }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    } 
   public Accountant TotalDebit(){
        Accountant stm=null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
                
         try {
            con = Database.getConnection();
            String costtotal="select sum(AMOUNT) from cash_debit where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
             ps = con.prepareStatement(costtotal);
             rs = ps.executeQuery();
             rs.next();
             stm=new Accountant();
             stm.setTotaldebt(rs.getLong(1));
            
           
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return stm;    
    }
   
   public List<Accountant> MonthlyCreditLedger() {
        List<Accountant> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        try {
            con = Database.getConnection();
            String query = "select CREDIT_NAME, AMOUNT, DATE from cash_credit where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) order by DATE, CREDIT_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             
             Accountant stm=new Accountant();
             stm.setCreditname(rs.getString(1));
             stm.setCreditamount(rs.getLong(2));
             stm.setCreditdate(rs.getString(3));
            
             list.add(stm);
            }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    } 
   public Accountant TotalCredit(){
        Accountant stm=null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
                
         try {
            con = Database.getConnection();
            String costtotal="select sum(AMOUNT) from cash_credit where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
             ps = con.prepareStatement(costtotal);
             rs = ps.executeQuery();
             rs.next();
             stm=new Accountant();
             stm.setTotalcredit(rs.getLong(1));
            
           
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return stm;    
    }
   public List<EmpModel> OrderLedger() {
        List<EmpModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = Database.getConnection();
            String query = "select RETAILER_NAME, PRODUCT_NAME, QUANTITY, SALE_RATE, DATE from order_list order by RETAILER_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             
             EmpModel em=new EmpModel();
             em.setOdname(rs.getString(1));
             em.setOdpro(rs.getString(2));
             em.setOdqty(rs.getInt(3));
             em.setOdrate(rs.getFloat(4));
             em.setOddate(rs.getString(5));
            
             list.add(em);
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
   public EmpModel Totalorder(){
        EmpModel stm=null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
                
         try {
            con = Database.getConnection();
            String costtotal="select sum(QUANTITY), sum(QUANTITY*SALE_RATE) from order_list";
             ps = con.prepareStatement(costtotal);
             rs = ps.executeQuery();
             rs.next();
             stm=new EmpModel();
             stm.setTotalqty(rs.getInt(1));
             stm.setOdtotal(rs.getDouble(2));
            
           
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return stm;    
    }
    public List<EmpModel> Enduser() {
        List<EmpModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = Database.getConnection();
            String query = "select * from end_user";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             
             EmpModel em=new EmpModel();
             em.setEndsi(rs.getInt(1));
             em.setEndname(rs.getString(2));
             em.setEndmob(rs.getString(3));
             em.setEndadd(rs.getString(4));
             em.setEngname(rs.getString(5));
             em.setContact(rs.getString(6));
             em.setStatus(rs.getString(7));
             em.setCause(rs.getString(8));
             em.setRemark(rs.getString(9));
             em.setEnddate(rs.getString(10));
             list.add(em);
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
    
    public List<EmpModel> ProprietorLedger() {
        List<EmpModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, PAY_NAME, NOTE, PAYMENT, RECEIVE, DATE from proprietor_cost where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
            int sino=rs.getInt(1);
            String prebl="select sum(PAYMENT-RECEIVE) from proprietor_cost where SI_NO<?";
            ps = con.prepareStatement(prebl);
            ps.setInt(1, sino);
            rs1=ps.executeQuery();
            while (rs1.next()) {
             EmpModel em=new EmpModel();
             em.setProcost(rs.getString(2));
             em.setPronote(rs.getString(3));
             em.setPropayamount(rs.getLong(4));
             em.setProrecvamount(rs.getLong(5));
             em.setProdate(rs.getString(6));
             em.setProbl(rs1.getLong(1));
             list.add(em);
            }}
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    } 
    public EmpModel ProprietorTotal(){
        EmpModel stm=null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
            
         try {
            con = Database.getConnection();
            String paytotal="select sum(PAYMENT), sum(RECEIVE) from proprietor_cost";
             ps = con.prepareStatement(paytotal);
             rs = ps.executeQuery();
             rs.next();
             stm=new EmpModel();
             stm.setPaytotal(rs.getLong(1));
             stm.setRecvtotal(rs.getLong(2));
           
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return stm;    
    }
     public List<EmpModel> RtpayLedger() {
        List<EmpModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = Database.getConnection();
            String query = "select RETAILER, PAY_TYPE, AMOUNT, COLLECTED_BY, NOTE, BANK_NAME, BRANCH, PAYER, DATE from customer_pay where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
            
             EmpModel em=new EmpModel();
             em.setRtler(rs.getString(1));
             em.setPaytype(rs.getString(2));
             em.setRtpamount(rs.getFloat(3));
             em.setCollectby(rs.getString(4));
             em.setNote(rs.getString(5));
             em.setRtpbank(rs.getString(6));
             em.setRtpbranch(rs.getString(7));
             em.setRtppayer(rs.getString(8));
             em.setRtpdate(rs.getString(9));
             list.add(em);
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
     
     public List<EmpModel> FacpayLedger() {
        List<EmpModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = Database.getConnection();
            String query = "select COMPANY_NAME, PAY_TYPE, NOTE, AMOUNT, BANK_NAME, BRANCE_NAME, CHEQUE_NO, PAYER, DATE from company_payment where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
            
             EmpModel em=new EmpModel();
             em.setFacpayname(rs.getString(1));
             em.setFacpaytype(rs.getString(2));
             em.setFpaynote(rs.getString(3));
             em.setFacpamount(rs.getFloat(4));
             em.setFacpbank(rs.getString(5));
             em.setFacbranch(rs.getString(6));
             em.setFacchq(rs.getString(7));
             em.setFacpayer(rs.getString(8));
             em.setFacpdate(rs.getString(9));
             list.add(em);
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
