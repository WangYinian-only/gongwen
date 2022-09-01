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
 * Servlet implementation class writedoc_do
 */
@WebServlet("/writedoc_do")
public class writedoc_do extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public writedoc_do() {
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
		String text=request.getParameter("text");
		String user=request.getParameter("user");
		String title=request.getParameter("title");
		System.out.println(text);
		Date date = new Date();
		SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String time=dateFormat.format(date).toString();
		String path="C:\\Users\\Lenovo\\eclipse-workspace\\Gong\\WebContent\\text\\"+title+"_"+user+"_"+time.split(":| ")[0]+time.split(":| ")[1]+time.split(":| ")[2]+time.split(":| ")[3]+".txt";
		System.out.println(path);
		File file = new File(path);
        FileOutputStream fileOutputStream;
		
		Doc doc=new Doc();
		doc.setTitle(title);
		doc.setOwner(user);
		doc.setReceiver("办公室");
		doc.setTime(time);
		doc.setStatus(-1);
		doc.setResult(0);
		doc.setPlace(path);
		if(DBUtil.add_doc(doc))
		{
			try {
				fileOutputStream = new FileOutputStream(file);
				 try {
					fileOutputStream.write((text).getBytes());
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
		{
			response.getWriter().write("no");
		}
	}

}
