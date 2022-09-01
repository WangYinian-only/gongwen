package servlet;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.Doc;
import util.DBUtil;

/**
 * Servlet implementation class checked_change
 */
@WebServlet("/checked_change")
public class checked_change extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public checked_change() {
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
		int id=Integer.parseInt(request.getParameter("id"));
		int result=Integer.parseInt(request.getParameter("result"));
		String tip=request.getParameter("tip");
		Date date = new Date();
		SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd-hh-mm-ss");
		String time=dateFormat.format(date).toString();
		String path="C:\\Users\\Lenovo\\eclipse-workspace\\Gong\\WebContent\\tip"+id+"_"+time+"_tip.txt";
		File file = new File(path);
        FileOutputStream fileOutputStream;
        
		int status;
		if(result==0)
			status=3;
		else
			status=2;
		Doc doc=new Doc();
		doc.setId(id);
		doc.setResult(result);
		doc.setStatus(status);
		doc.setReceiver("办公室");
		doc.setTipplace(path);
		if(DBUtil.checked_change(doc))
		{
			try {
				fileOutputStream = new FileOutputStream(file);
				 try {
					fileOutputStream.write((tip).getBytes());
					fileOutputStream.close();
					response.getWriter().write("yes");
					
				} catch (IOException e) {
					// TODO 自动生成的 catch 块
					response.getWriter().write("no");
					e.printStackTrace();
				}
				
			} catch (FileNotFoundException e) {
				// TODO 自动生成的 catch 块
				response.getWriter().write("no");
				e.printStackTrace();
			}
		}
		else
			response.getWriter().write("no");
		
	}
	

}
