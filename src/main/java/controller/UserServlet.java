package controller;

import model.bean.User;
import model.bo.UserBO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = {"/login", "/logout", "/register"})
public class UserServlet extends HttpServlet {
    private final UserBO userBO = new UserBO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getRequestURI();
        if(url.contains("/login")) {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if(user != null) {
                response.sendRedirect("home");
            }
            else {
                response.sendRedirect("login.jsp");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getRequestURI();
        if(url.contains("/login")){
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            if(username != null && password != null){
                HttpSession session = request.getSession();
                User user = userBO.login(username, password);
                if(user != null){
                    session.setAttribute("user", user);
                    response.sendRedirect("home");
                }
                else{
                    response.sendRedirect("login.jsp");
                }
            }
        }
        else if(url.contains("/register")){
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            if(username != null && password != null){
                if(userBO.register(username, password)){
                    response.sendRedirect("login");
                }
                else response.sendRedirect("register.jsp?error=Registeration is not successful");
            }
        }
    }
}
