package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.Doc;
import util.DBUtil;

/**
 * Servlet implementation class queryDoc
 */
@WebServlet("/queryDoc")
public class queryDoc extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public queryDoc() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		request.setCharacterEncoding("utf-8");
		String type=request.getParameter("type");
		if(type.equals("all"))
		{
			ArrayList<Doc> list=DBUtil.getDoces("all");
			request.setAttribute("list", list);
			request.getRequestDispatcher("querydoc.jsp").forward(request, response);
		}
		else
		{
			String value=request.getParameter("value");
			System.out.println(value);
			ArrayList<Doc> list=DBUtil.getDocesByCase(type,value);
			request.setAttribute("list", list);
			request.getRequestDispatcher("querydoc.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
