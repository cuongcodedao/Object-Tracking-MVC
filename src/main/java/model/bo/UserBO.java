package model.bo;

import model.bean.User;
import model.dao.UserDAO;

public class UserBO {
    private UserDAO userDAO = new UserDAO();
    public User login(String username, String password){
        return userDAO.login(username, password);
    }
}
