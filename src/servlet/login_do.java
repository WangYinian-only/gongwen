package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.Users;
import util.DBUtil;

/**
 * Servlet implementation class login_do
 */
@WebServlet("/login_do")
public class login_do extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public login_do() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		Users user=new Users();
		user.setUsername(username);
		user.setPassword(password);
		if(DBUtil.log_isExist(user))
		{
			Cookie cookie=new Cookie("username", username);
			cookie.setPath("/");
			//设置存活时间
			cookie.setMaxAge(60*60*24);
			response.addCookie(cookie);
			Users users=DBUtil.getUserByUsername(user);
			int pid=users.getPermissionId();
			Cookie cookie2=new Cookie("pid", Integer.toString(pid));
			cookie2.setPath("/");
			cookie2.setMaxAge(60*60*24);
			response.addCookie(cookie2);
			response.getWriter().write("yes");
		}
		else
		{
			response.getWriter().write("no");
		}
	}

}
