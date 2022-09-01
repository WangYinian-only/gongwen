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
 * Servlet implementation class queryByTime
 */
@WebServlet("/queryByTime")
public class queryByTime extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public queryByTime() {
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
		String begin=request.getParameter("begin");
		String end=request.getParameter("end");
		System.out.println(begin+" "+end);
		Doc doc1=new Doc();
		Doc doc2=new Doc();
		doc1.setTime(begin);
		doc2.setTime(end);
		ArrayList<Doc> list=DBUtil.getDocByTime(doc1, doc2);
		response.setContentType("text/html;charset=utf-8"); 
		response.getWriter().print(com.alibaba.fastjson.JSONArray.toJSON(list).toString());
	}

}
