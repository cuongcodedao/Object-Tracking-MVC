package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.google.gson.Gson;

import model.bean.Project;
import model.bo.ProjectBO;

@WebServlet(value= {"/project", "/project-detail", "/project-progress"})
@MultipartConfig
public class ProjectServlet extends HttpServlet {
	private ProjectBO projectBO = new ProjectBO();
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String url = req.getRequestURI();
    	if(url.contains("/project-progress")) {
    		res.setContentType("application/json");
            res.setCharacterEncoding("UTF-8");
    		String id = req.getParameter("id");
    		Project project = projectBO.getById(Integer.parseInt(id));
    		Gson gson = new Gson();
    		String json = gson.toJson(project);
    		PrintWriter out;
			try {
				out = res.getWriter();
				out.print(json);
		    	out.flush();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}
    	else if(url.contains("/project-detail")) {
			String mod = req.getParameter("mod");
			if(mod!=null){
				if(mod.equals("tracking")){
					String id = req.getParameter("id");
					projectBO.tracking(Integer.parseInt(id));
				}
				else if(mod.equals("cancel")){
					String id = req.getParameter("id");
					projectBO.cancelTracking(Integer.parseInt(id));
				}

			}
			else{
				String id = req.getParameter("id");
				Project project = projectBO.getById(Integer.parseInt(id));
				req.setAttribute("project", project);
				req.getRequestDispatcher("project-detail.jsp").forward(req, res);
			}
		}
	}
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String mod = request.getParameter("mod");
    	if(mod.equals("create")) {
    		String user_id = request.getParameter("user-id");
        	String name = request.getParameter("name");
        	String description = request.getParameter("description");
            String savePath = getServletContext().getRealPath("/videos");
			String yoloVerId = request.getParameter("yoloVersion");

            Part filePart = request.getPart("file");
            Project project = projectBO.create(savePath, filePart, Integer.parseInt(user_id), name, description, Integer.parseInt(yoloVerId));
            response.sendRedirect("project-detail?id=" + project.getId());
    	}
		else if(mod.equals("edit")){
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String description = request.getParameter("description");
			Project existProject = projectBO.getById(Integer.parseInt(id));
			existProject.setName(name);
			existProject.setDescription(description);
			projectBO.update(existProject);
		}
		else if (mod.equals("delete")){
			String id = request.getParameter("id");
			projectBO.delete(Integer.parseInt(id));
		}
    }
}
