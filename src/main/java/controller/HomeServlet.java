package controller;
import model.bean.Project;
import model.bean.User;
import model.bo.ProjectBO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value = {"/home", "/"})
public class HomeServlet extends HttpServlet {
    ProjectBO projectBO = new ProjectBO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if(user == null) {
            response.sendRedirect("login");
        }
        else{
            List<Project> projects = projectBO.getAllByUserId(user.getId());
            request.setAttribute("projects", projects);
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }
}
