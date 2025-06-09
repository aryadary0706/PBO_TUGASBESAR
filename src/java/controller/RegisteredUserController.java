package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.*;
import java.util.List;
import database.ContentDAO;
import database.UserListDAO;
import java.sql.SQLException;

@WebServlet(name = "RegisteredUserController", urlPatterns = {"/RegisteredUserController"})
public class RegisteredUserController extends HttpServlet {
    
    private ContentDAO contentDAO;
    private UserListDAO userListDAO;
    
    @Override
    public void init() throws ServletException {
        contentDAO = new ContentDAO();
        userListDAO = new UserListDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("GuestHome.jsp");
            return;
        }

        RegisteredUser user = (RegisteredUser) session.getAttribute("user");
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "favorites":
                    request.setAttribute("contents", userListDAO.getUserFavorites(user.getIdUser()));
                    request.getRequestDispatcher("Kemas/FavoritesList.jsp").forward(request, response);
                    break;
                case "watchlist":
                    request.setAttribute("contents", userListDAO.getUserWatchlist(user.getIdUser()));
                    request.getRequestDispatcher("Kemas/WatchList.jsp").forward(request, response);
                    break;
                case "history":
                    request.setAttribute("contents", userListDAO.getUserHistory(user.getIdUser()));
                    request.getRequestDispatcher("Kemas/History.jsp").forward(request, response);
                    break;
                default:
                    response.sendRedirect("Kemas/Main.jsp");
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Error loading content");
            request.getRequestDispatcher("Kemas/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("GuestHome.jsp");
            return;
        }

        RegisteredUser user = (RegisteredUser) session.getAttribute("user");
        String action = request.getParameter("action");
        String contentId = request.getParameter("contentId");

        try {
            int id = Integer.parseInt(contentId);
            String message = "";
            switch (action) {
                case "addFavorite":
                    userListDAO.addToFavorites(user.getIdUser(), id);
                    message = "Added to favorites";
                    break;
                case "removeFavorite":
                    userListDAO.removeFromFavorites(user.getIdUser(), id);
                    message = "Removed from favorites";
                    break;
                case "addWatchlist":
                    userListDAO.addToWatchlist(user.getIdUser(), id);
                    message = "Added to watchlist";
                    break;
                case "removeWatchlist":
                    userListDAO.removeFromWatchlist(user.getIdUser(), id);
                    message = "Removed from watchlist";
                    break;
                case "addHistory":
                    userListDAO.addToHistory(user.getIdUser(), id);
                    message = "Added to history";
                    break;
            }

            request.setAttribute("message", message);
            response.sendRedirect("RegisteredUserController?action=" + getRedirectAction(action));
            
        } catch (Exception e) {
            request.setAttribute("error", "Operation failed");
            request.getRequestDispatcher("Kemas/error.jsp").forward(request, response);
        }
    }
    
    private String getRedirectAction(String action) {
        if (action.startsWith("addFavorite") || action.startsWith("removeFavorite")) {
            return "favorites";
        } else if (action.startsWith("addWatchlist") || action.startsWith("removeWatchlist")) {
            return "watchlist";
        } else {
            return "history";
        }
    }
}
