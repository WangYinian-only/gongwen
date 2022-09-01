package util;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import entity.Doc;
import entity.Permission;
import entity.Users;
/**
 * 
 * @author twj
 *
 */
public class DBUtil {
	
    private static String db_url = "jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC";
	public static String db_user = "root";
	public static String db_pass = "123";
	
	public static Connection getConn () {
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(db_url, db_user, db_pass);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	
	/**
	 * �ر�����
	 * @param state
	 * @param conn
	 */
	 
			
	public static void close (Statement state, Connection conn) {
		if (state != null) {
			try {
				state.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void close (ResultSet rs, Statement state, Connection conn) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		if (state != null) {
			try {
				state.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	//某表的增删改�?
		public static ArrayList<Doc> getDoces(String type)
		{
			Connection connection=null;
			PreparedStatement preparedStatement=null;
			ResultSet rSet=null;
			try {
				connection=getConn();
				String sql;
				System.out.println(type);
				if(type.equals("receive"))
				{
					sql="select * from doc_list where status=0 or status=2 or status=3 or status=6 or status=7 or status=-1 and deletestatus=0";
				}
				else if(type.equals("send"))
				{
					sql="select * from doc_list where status=1 or status=4 or status=5 or status=8 or status=9 or status=10 and deletestatus=0";
				}
				else if(type.equals("delete"))
				{
					sql="select * from doc_list where delete status=1";
				}
				else {
					sql="select * from doc_list";
				}
				preparedStatement=connection.prepareStatement(sql);
				rSet=preparedStatement.executeQuery();
				ArrayList<Doc> list=new ArrayList<>();
				while(rSet.next())
				{
					Doc doc=new Doc();
					doc.setId(rSet.getInt("id"));
					doc.setTitle(rSet.getString("title"));
					doc.setOwner(rSet.getString("owner"));
					doc.setTime(rSet.getString("time"));
					doc.setReceiver(rSet.getString("receiver"));
					doc.setStatus(rSet.getInt("status"));
					doc.setResult(rSet.getInt("result"));
					doc.setPlace(rSet.getString("place"));
					doc.setDeletestatus(rSet.getInt("deletestatus"));
					list.add(doc);
				}
				return list;
			} catch (SQLException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			finally {
				close(rSet, preparedStatement, connection);
			}
			return null;
		}
		
		//登录时验证数据库中账户是否存�?
		public static boolean log_isExist(Users user)
		{
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try {
				con=getConn();
				String sql_query="select * from users where username = '"+user.getUsername()+"' and password = '"+user.getPassword()+"' and status != 0";
				System.out.println(sql_query);
				pstmt=con.prepareStatement(sql_query);
				rs=pstmt.executeQuery();
				if(rs.next()==false)
				{
					System.out.println("用户名或密码错误");
					return false;
				}
				else
				{
					System.out.println("用户名及密码正确");
					return true;
				}
			}
			catch (SQLException e) {
				System.out.println("未连�?");
				e.printStackTrace();
			}
			finally {
				close(rs, pstmt, con);
			}
			return false;
		}
		
		//增加公文
		public static boolean add_doc(Doc doc)
		{
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try {
				con=getConn();
				String sql="insert into doc_list(title,owner,receiver,time,status,result,place,deletestatus,callback) values(?,?,?,?,?,?,?,?,?)";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, doc.getTitle());
				pstmt.setString(2, doc.getOwner());
				pstmt.setString(3, doc.getReceiver());
				pstmt.setString(4, doc.getTime());
				pstmt.setInt(5, doc.getStatus());
				pstmt.setInt(6, doc.getResult());
				pstmt.setString(7, doc.getPlace());
				pstmt.setInt(8, 0);
				pstmt.setInt(9, 0);
				pstmt.executeUpdate();
				return true;
			}
			catch (SQLException e) {
				System.out.println("注册失败");
				e.printStackTrace();
			}
			finally {
				close(rs, pstmt, con);
			}
			return false;
		}
		
		
		//删除数据
		public static boolean delete_user(Users user)
		{
			Connection con=null;
			PreparedStatement pstmt=null;
			try {
				con=getConn();
				String sql="delete from users where id="+user.getId();
				System.out.println(sql);
				pstmt=con.prepareStatement(sql);
				pstmt.executeUpdate();
				return true;
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
			finally {
				close(pstmt, con);
			}
			return false;
		}
		
		public static boolean update_userstatus(Users user)
		{
			Connection con=null;
			PreparedStatement pstmt=null;
			try {
				con=getConn();
				String sql="update users set status = ? where id = ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, user.getStatus());
				pstmt.setInt(2, user.getId());
				pstmt.executeUpdate();
				return true;
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
			finally {
				close(pstmt, con);
			}
			return false;
		}
		
		public static boolean update_user(Users user)
		{
			Connection con=null;
			PreparedStatement pstmt=null;
			try {
				con=getConn();
				String sql="update users set username=?,password=?,job=? where id = "+user.getId();
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, user.getUsername());
				pstmt.setString(2, user.getPassword());
				pstmt.setString(3, user.getJob());
				pstmt.executeUpdate();
				return true;
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
			finally {
				close(pstmt, con);
			}
			return false;
		}
		
		@SuppressWarnings("resource")
		public static boolean sendDoc(int id)
		{
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rSet=null;
			int status=-1;
			int newstatus=-1;
			String receiver="";
			try {
				con=DBUtil.getConn();
				String sql_query="select * from doc_list where id="+id;
				pstmt=con.prepareStatement(sql_query);
				rSet=pstmt.executeQuery();
				if(rSet.next())
				{
					status=rSet.getInt("status");
				}
				switch (status) {
				case 0:
					newstatus=1;
					receiver="副厂�?";
					break;
				case 2:
					newstatus=5;
					receiver="厂长";
					break;
				case 3:
					newstatus=4;
					receiver="部门";
					break;
				case 6:
					newstatus=8;
					receiver="部门和副厂长";
					break;
				case 7:
					newstatus=9;
					receiver="部门和副厂长";
					break;
				case 8:
					newstatus=10;
					receiver="部门";
					break;
				default:
					System.out.println("公文状�?�有误！");
					break;
				}
				String sql_update="update doc_list set status = ? where id = ?";
				pstmt=con.prepareStatement(sql_update);
				pstmt.setInt(1, newstatus);
				pstmt.setInt(2, id);
				pstmt.executeUpdate();
				return true;
			}
			catch (SQLException e) {
				System.out.println("数据库信息更新失�?");
				e.printStackTrace();
			}
			finally {
				close(pstmt, con);
			}
			return false;
		}
		
		public static ArrayList<Doc> getDocesByCase(String type,String value)
		{
			Connection connection=null;
			PreparedStatement preparedStatement=null;
			ResultSet rSet=null;
			try {
				connection=getConn();
				String sql="";
				System.out.println(type);
				if(type.equals("title"))
				{
					sql="select * from doc_list where title='"+value+"'";
				}
				else if(type.equals("owner"))
				{
					sql="select * from doc_list where owner='"+value+"'";
				}
				else if(type.equals("receiver"))
				{
					sql="select * from doc_list where receiver='"+value+"'";
				}
				else if(type.equals("result"))
				{
					sql="select * from doc_list where result='"+value+"'";
				}
				preparedStatement=connection.prepareStatement(sql);
				rSet=preparedStatement.executeQuery();
				ArrayList<Doc> list=new ArrayList<>();
				while(rSet.next())
				{
					Doc doc=new Doc();
					doc.setId(rSet.getInt("id"));
					doc.setTitle(rSet.getString("title"));
					doc.setOwner(rSet.getString("owner"));
					doc.setTime(rSet.getString("time"));
					doc.setReceiver(rSet.getString("receiver"));
					doc.setStatus(rSet.getInt("status"));
					doc.setResult(rSet.getInt("result"));
					doc.setPlace(rSet.getString("place"));
					list.add(doc);
				}
				return list;
			} catch (SQLException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			finally {
				close(rSet, preparedStatement, connection);
			}
			return null;
		}
		
		public static ArrayList<Doc> getCheckedorNot(String type)
		{
			Connection connection=null;
			PreparedStatement preparedStatement=null;
			ResultSet rSet=null;
			try {
				connection=getConn();
				String sql="";
				System.out.println(type);
				if(type.equals("notchecked"))
				{
					sql="select * from doc_list where status=1";
				}
				else
				{
					sql="select * from doc_list where status!=1 and status!=0 and status!=-1";
				}
				preparedStatement=connection.prepareStatement(sql);
				rSet=preparedStatement.executeQuery();
				ArrayList<Doc> list=new ArrayList<>();
				while(rSet.next())
				{
					Doc doc=new Doc();
					doc.setId(rSet.getInt("id"));
					doc.setTitle(rSet.getString("title"));
					doc.setOwner(rSet.getString("owner"));
					doc.setTime(rSet.getString("time"));
					doc.setReceiver(rSet.getString("receiver"));
					doc.setStatus(rSet.getInt("status"));
					doc.setResult(rSet.getInt("result"));
					doc.setPlace(rSet.getString("place"));
					list.add(doc);
				}
				return list;
			} catch (SQLException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			finally {
				close(rSet, preparedStatement, connection);
			}
			return null;
		}
		
		public static ArrayList<Doc> getFcheckedorNot(String type)
		{
			Connection connection=null;
			PreparedStatement preparedStatement=null;
			ResultSet rSet=null;
			try {
				connection=getConn();
				String sql="";
				if(type.equals("checked"))
				{
					sql="select * from doc_list where status=6 or status=7";
				}
				else
				{
					sql="select * from doc_list where status=5";
				}
				preparedStatement=connection.prepareStatement(sql);
				rSet=preparedStatement.executeQuery();
				ArrayList<Doc> list=new ArrayList<>();
				while(rSet.next())
				{
					Doc doc=new Doc();
					doc.setId(rSet.getInt("id"));
					doc.setTitle(rSet.getString("title"));
					doc.setOwner(rSet.getString("owner"));
					doc.setTime(rSet.getString("time"));
					doc.setReceiver(rSet.getString("receiver"));
					doc.setStatus(rSet.getInt("status"));
					doc.setResult(rSet.getInt("result"));
					doc.setPlace(rSet.getString("place"));
					list.add(doc);
				}
				return list;
			} catch (SQLException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			finally {
				close(rSet, preparedStatement, connection);
			}
			return null;
		}
		
		
		public static ArrayList<Doc> getReceivedByUser(String type,Users user)
		{
			Connection connection=null;
			PreparedStatement preparedStatement=null;
			ResultSet rSet=null;
			try {
				connection=getConn();
				String sql="";
				if(type.equals("received"))
				{
					sql="select * from doc_list where owner=? and status=10";
				}
				else
				{
					sql="select * from doc_list where owner=? and status!=10";
				}
				preparedStatement=connection.prepareStatement(sql);
				preparedStatement.setString(1, user.getUsername());
				rSet=preparedStatement.executeQuery();
				ArrayList<Doc> list=new ArrayList<>();
				while(rSet.next())
				{
					Doc doc=new Doc();
					doc.setId(rSet.getInt("id"));
					doc.setTitle(rSet.getString("title"));
					doc.setTime(rSet.getString("time"));
					doc.setStatus(rSet.getInt("status"));
					doc.setResult(rSet.getInt("result"));
					list.add(doc);
				}
				return list;
			} catch (SQLException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			finally {
				close(rSet, preparedStatement, connection);
			}
			return null;
		}
		
		public static Doc getDocById(Doc doc)
		{
			Connection connection=null;
			PreparedStatement preparedStatement=null;
			ResultSet rSet=null;
			try {
				connection=getConn();
				String sql="select * from doc_list where id="+doc.getId();
				preparedStatement=connection.prepareStatement(sql);
				rSet=preparedStatement.executeQuery();
				if(rSet.next())
				{
					doc.setTitle(rSet.getString("title"));
					doc.setOwner(rSet.getString("owner"));
					doc.setTime(rSet.getString("time"));
					doc.setReceiver(rSet.getString("receiver"));
					doc.setStatus(rSet.getInt("status"));
					doc.setResult(rSet.getInt("result"));
					doc.setPlace(rSet.getString("place"));
					doc.setTipplace(rSet.getString("tipplace"));
					doc.setFtipplace(rSet.getString("tipfplace"));
					return doc;
				}
			} catch (SQLException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			finally {
				close(rSet, preparedStatement, connection);
			}
			return null;
		}
		
		public static boolean checked_change(Doc doc)
		{
			Connection connection=null;
			PreparedStatement preparedStatement=null;
			String sql_update="update doc_list set status = ?,result = ?,receiver = ?,tipplace = ? where id = ?";
			try {
				connection=getConn();
				preparedStatement=connection.prepareStatement(sql_update);
				preparedStatement.setInt(1, doc.getStatus());
				preparedStatement.setInt(2, doc.getResult());
				preparedStatement.setString(3, doc.getReceiver());
				preparedStatement.setString(4, doc.getTipplace());
				preparedStatement.setInt(5, doc.getId());
				preparedStatement.executeUpdate();
				return true;
			} catch (SQLException e) {
				// TODO 自动生成�? catch �?
				e.printStackTrace();
			}
			finally {
				close(preparedStatement, connection);
			}
			return false;
		}
		
		public static boolean fchecked_change(Doc doc)
		{
			Connection connection=null;
			PreparedStatement preparedStatement=null;
			String sql_update="update doc_list set status = ?,result = ?,receiver = ?,tipfplace = ? where id = ?";
			try {
				connection=getConn();
				preparedStatement=connection.prepareStatement(sql_update);
				preparedStatement.setInt(1, doc.getStatus());
				preparedStatement.setInt(2, doc.getResult());
				preparedStatement.setString(3, doc.getReceiver());
				preparedStatement.setString(4, doc.getFtipplace());
				preparedStatement.setInt(5, doc.getId());
				preparedStatement.executeUpdate();
				return true;
			} catch (SQLException e) {
				// TODO 自动生成�? catch �?
				e.printStackTrace();
			}
			finally {
				close(preparedStatement, connection);
			}
			return false;
		}
		
		public static boolean formatDoc(Doc doc)
		{
			Connection connection=null;
			PreparedStatement preparedStatement=null;
			String sql_update="update doc_list set status = ? where id = ?";
			try {
				connection=getConn();
				preparedStatement=connection.prepareStatement(sql_update);
				preparedStatement.setInt(1, doc.getStatus());
				preparedStatement.setInt(2, doc.getId());
				preparedStatement.executeUpdate();
				return true;
			} catch (SQLException e) {
				// TODO 自动生成�? catch �?
				e.printStackTrace();
			}
			finally {
				close(preparedStatement, connection);
			}
			return false;
		}
		
		public static boolean ReceiveDoc(Doc doc)
		{
			Connection connection=null;
			PreparedStatement preparedStatement=null;
			String sql_update="update doc_list set status = ?,callback = 1 where id = ?";
			try {
				connection=getConn();
				preparedStatement=connection.prepareStatement(sql_update);
				preparedStatement.setInt(1, 10);
				preparedStatement.setInt(2, doc.getId());
				preparedStatement.executeUpdate();
				return true;
			} catch (SQLException e) {
				// TODO 自动生成�? catch �?
				e.printStackTrace();
			}
			finally {
				close(preparedStatement, connection);
			}
			return false;
		}
		
		public static ArrayList<Doc> getDocByTime(Doc doc1,Doc doc2)
		{
			Connection connection=null;
			PreparedStatement preparedStatement=null;
			ResultSet rs=null;
			String sql="select * from doc_list where time between ? and ?";
			try {
				connection=getConn();
				preparedStatement=connection.prepareStatement(sql);
				preparedStatement.setString(1,doc1.getTime());
				preparedStatement.setString(2, doc2.getTime());
				rs=preparedStatement.executeQuery();
				ArrayList<Doc> list=new ArrayList<>();
				while(rs.next())
				{
					Doc doc=new Doc();
					doc.setId(rs.getInt("id"));
					doc.setTitle(rs.getString("title"));
					doc.setTime(rs.getString("time"));
					doc.setOwner(rs.getString("owner"));
					list.add(doc);
				}
				return list;
			} catch (SQLException e) {
				// TODO 自动生成�? catch �?
				e.printStackTrace();
			}
			finally {
				close(preparedStatement, connection);
			}
			return null;
		}
		
		public static ArrayList<Doc> getAllDoc()
		{
			Connection connection=null;
			PreparedStatement preparedStatement=null;
			ResultSet rs=null;
			String sql="select * from doc_list";
			try {
				connection=getConn();
				preparedStatement=connection.prepareStatement(sql);
				rs=preparedStatement.executeQuery();
				ArrayList<Doc> list=new ArrayList<>();
				while(rs.next())
				{
					Doc doc=new Doc();
					doc.setId(rs.getInt("id"));
					doc.setTitle(rs.getString("title"));
					doc.setTime(rs.getString("time"));
					doc.setOwner(rs.getString("owner"));
					list.add(doc);
				}
				return list;
			} catch (SQLException e) {
				// TODO 自动生成�? catch �?
				e.printStackTrace();
			}
			finally {
				close(preparedStatement, connection);
			}
			return null;
		}
		
		public static ArrayList<Users> getAllUser()
		{
			Connection connection=null;
			PreparedStatement preparedStatement=null;
			ResultSet rs=null;
			String sql="select * from users";
			try {
				connection=getConn();
				preparedStatement=connection.prepareStatement(sql);
				rs=preparedStatement.executeQuery();
				ArrayList<Users> list=new ArrayList<>();
				while(rs.next())
				{
					Users user=new Users();
					user.setId(rs.getInt("id"));
					user.setUsername(rs.getString("username"));
					user.setPassword(rs.getString("password"));
					user.setPermissionId(rs.getInt("permissionId"));
					user.setJob(rs.getString("job"));
					user.setStatus(rs.getInt("status"));
					list.add(user);
				}
				return list;
			} catch (SQLException e) {
				// TODO 自动生成�? catch �?
				e.printStackTrace();
			}
			finally {
				close(preparedStatement, connection);
			}
			return null;
		}
		
		public static Users getUserById(Users user)
		{
			Connection connection=null;
			PreparedStatement preparedStatement=null;
			ResultSet rs=null;
			String sql="select * from users where id="+user.getId();
			try {
				connection=getConn();
				preparedStatement=connection.prepareStatement(sql);
				rs=preparedStatement.executeQuery();
				Users user1=new Users();
				if(rs.next())
				{
					user1.setId(rs.getInt("id"));
					user1.setUsername(rs.getString("username"));
					user1.setPassword(rs.getString("password"));
					user1.setPermissionId(rs.getInt("permissionId"));
					user1.setStatus(rs.getInt("status"));
					user1.setJob(rs.getString("job"));
				}
				return user1;
			} catch (SQLException e) {
				// TODO 自动生成�? catch �?
				e.printStackTrace();
			}
			finally {
				close(preparedStatement, connection);
			}
			return null;
		}
		
		public static ArrayList<Permission> getPermission(Permission permission)
		{
			Connection connection=null;
			PreparedStatement preparedStatement=null;
			ResultSet rs=null;
			String sql="select * from permission where id="+permission.getId();
			try {
				connection=getConn();
				preparedStatement=connection.prepareStatement(sql);
				rs=preparedStatement.executeQuery();
				ArrayList<Permission> list=new ArrayList<>();
				while(rs.next())
				{
					Permission permission1=new Permission();
					permission1.setId(rs.getInt("id"));
					permission1.setPermission(rs.getInt("permission"));
					list.add(permission1);
				}
				return list;
			} catch (SQLException e) {
				// TODO 自动生成�? catch �?
				e.printStackTrace();
			}
			finally {
				close(preparedStatement, connection);
			}
			return null;
		}
		
		public static boolean deletePermission(Permission permission)
		{
			Connection con=null;
			PreparedStatement pstmt=null;
			try {
				con=getConn();
				String sql="delete from permission where id="+permission.getId();
				System.out.println(sql);
				pstmt=con.prepareStatement(sql);
				pstmt.executeUpdate();
				return true;
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
			finally {
				close(pstmt, con);
			}
			return false;
		}
		
		public static boolean updatePermission(Permission permission1,Permission permission2)
		{
			Connection con=null;
			PreparedStatement pstmt=null;
			try {
				con=getConn();
				String sql="update permission set permission = ? where id = ? and permission = ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, permission2.getPermission());
				pstmt.setInt(2, permission1.getId());
				pstmt.setInt(3, permission1.getPermission());
				pstmt.executeUpdate();
				return true;
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
			finally {
				close(pstmt, con);
			}
			return false;
		}
		
		public static boolean updatePwd(Users user)
		{
			Connection con=null;
			PreparedStatement pstmt=null;
			try {
				con=getConn();
				String sql="update users set password = ? where username = ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, user.getPassword());
				pstmt.setString(2, user.getUsername());
				pstmt.executeUpdate();
				return true;
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
			finally {
				close(pstmt, con);
			}
			return false;
		}
		
		public static Users getUserByUsername(Users user)
		{
			Connection connection=null;
			PreparedStatement preparedStatement=null;
			ResultSet rs=null;
			String sql="select * from users where username='"+user.getUsername()+"'";
			try {
				connection=getConn();
				preparedStatement=connection.prepareStatement(sql);
				rs=preparedStatement.executeQuery();
				Users user1=new Users();
				if(rs.next())
				{
					user1.setId(rs.getInt("id"));
					user1.setPermissionId(rs.getInt("permissionId"));
					System.out.println(user1.getPermissionId());
				}
				return user1;
			} catch (SQLException e) {
				// TODO 自动生成�? catch �?
				e.printStackTrace();
			}
			finally {
				close(preparedStatement, connection);
			}
			return null;
		}
		
		public static boolean deleteDoc(Doc doc)
		{
			Connection con=null;
			PreparedStatement pstmt=null;
			try {
				con=getConn();
				String sql="update doc_list set deletestatus = ? where id = ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, doc.getDeletestatus());
				pstmt.setInt(2, doc.getId());
				pstmt.executeUpdate();
				return true;
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
			finally {
				close(pstmt, con);
			}
			return false;
		}
		
		public static ArrayList<Doc> getCall()
		{
			Connection connection=null;
			PreparedStatement preparedStatement=null;
			ResultSet rSet=null;
			try {
				connection=getConn();
				String sql="select * from doc_list where callback=1";
				preparedStatement=connection.prepareStatement(sql);
				rSet=preparedStatement.executeQuery();
				ArrayList<Doc> list=new ArrayList<>();
				while(rSet.next())
				{
					Doc doc=new Doc();
					doc.setId(rSet.getInt("id"));
					doc.setTitle(rSet.getString("title"));
					doc.setOwner(rSet.getString("owner"));
					doc.setTime(rSet.getString("time"));
					doc.setReceiver(rSet.getString("receiver"));
					doc.setStatus(rSet.getInt("status"));
					doc.setResult(rSet.getInt("result"));
					doc.setPlace(rSet.getString("place"));
					doc.setDeletestatus(rSet.getInt("deletestatus"));
					doc.setCallback(rSet.getInt("callback"));
					list.add(doc);
				}
				return list;
			} catch (SQLException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			finally {
				close(rSet, preparedStatement, connection);
			}
			return null;
		}
		
		public static boolean setCallOver(Doc doc)
		{
			Connection con=null;
			PreparedStatement pstmt=null;
			try {
				con=getConn();
				String sql="update doc_list set callback = ? where id = ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, 0);
				pstmt.setInt(2, doc.getId());
				pstmt.executeUpdate();
				return true;
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
			finally {
				close(pstmt, con);
			}
			return false;
		}

		public static void main(String[] args) {
			//getConnection();
			
		}
}


