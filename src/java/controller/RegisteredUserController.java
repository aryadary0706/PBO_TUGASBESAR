package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.*;
import java.util.List;
import database.ContentDAO;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "RegisteredUserController", urlPatterns = {"/RegisteredUserController"})
public class RegisteredUserController extends HttpServlet {

    private ContentDAO contentDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        contentDAO = new ContentDAO(); // Inisialisasi ContentDAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect("GuestHome.jsp");
                return;
            }
            
            RegisteredUser  user = (RegisteredUser) session.getAttribute("user");
            String action = request.getParameter("action");
            
            switch (action == null ? "" : action) {
                case "favourites":
                    request.setAttribute("contents", user.getFavorites());
                    request.getRequestDispatcher("Kemas/FavoritesList.jsp").forward(request, response);
                    break;
                    
                case "watchlist":
                    request.setAttribute("contents", user.getWatchList());
                    request.getRequestDispatcher("Kemas/WatchList.jsp").forward(request, response);
                    break;
                    
                case "history":
                    request.setAttribute("contents", user.getContentHistory());
                    request.getRequestDispatcher("Kemas/History.jsp").forward(request, response);
                    break;
                   
                    
                case "viewContent":
                    try {
                        int contentId = Integer.parseInt(request.getParameter("contentId"));
                        Content viewedContent = contentDAO.getContentById(contentId);
                        if (viewedContent != null) {
                            user.addToHistory(viewedContent);
                            session.setAttribute("user", user);
                            request.setAttribute("content", viewedContent);
                            String targetPage = (viewedContent instanceof movie)
                                    ? "Kemas/ViewMovie.jsp" : "Kemas/ViewSeries.jsp";
                            request.getRequestDispatcher(targetPage).forward(request, response);
                        } else {
                            response.sendRedirect("RegisteredUser Controller?action=favourites");
                        }
                    } catch (NumberFormatException e) {
                        response.sendRedirect("RegisteredUser Controller?action=favourites");
                    }
                    break;
                    
                case "logout":
                    session.invalidate();
                    response.sendRedirect("Kemas/login.jsp");
                    break;
                    
                default:
                    // Tampilkan semua konten sebagai fallback
                    List<Content> all = contentDAO.getAllContents();
                    request.setAttribute("contents", all);
                    request.getRequestDispatcher("Kemas/Main.jsp").forward(request, response);
                    break;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisteredUserController.class.getName()).log(Level.SEVERE, null, ex);
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

        RegisteredUser  user = (RegisteredUser ) session.getAttribute("user");
        String action = request.getParameter("action");
        String contentId = request.getParameter("contentId");

        try {
            if (contentId != null && !contentId.isEmpty()) {
                Content content = contentDAO.getContentById(Integer.parseInt(contentId));
                if (content != null) {
                    switch (action) {
                        case "addToFavourites":
                            user.addToFavorites(content);
                            break;
                        case "removeFromFavourites":
                            user.removeFromFavorites(content);
                            break;
                        case "addToWatchlist":
                            user.addToWatchList(content);
                            break;
                        case "removeFromWatchlist":
                            user.removeFromWatchlist(content);
                            break;
                        case "addToHistory":
                            user.addToHistory(content);
                            break;
                    }
                    session.setAttribute("user", user);
                }
            }
            response.sendRedirect(request.getHeader("Referer") != null
                    ? request.getHeader("Referer")
                    : "RegisteredUser Controller?action=favourites");

        } catch (Exception e) {
            response.sendRedirect("RegisteredUser Controller?action=favourites");
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("Kemas/login.jsp");
            return;
        }

        RegisteredUser  user = (RegisteredUser ) session.getAttribute("user");
        String action = request.getParameter("action");

        try {
            int contentId = Integer.parseInt(request.getParameter("contentId"));
            Content content = contentDAO.getContentById(contentId);

            if (content != null) {
                switch (action) {
                    case "addToFavorites":
                        user.addToFavorites(content);
                        break;

                    case "removeFromFavorites":
                        user.removeFromFavorites(content);
                        break;

                    case "addToWatchlist":
                        user.addToWatchList(content);
                        break;

                    case "removeFromWatchlist":
                        user.removeFromWatchlist(content);
                        break;

                    case "addToHistory":
                        user.addToHistory(content);
                        break;
                }

                session.setAttribute("user", user);
            }

            response.sendRedirect(request.getHeader("Referer") != null
                    ? request.getHeader("Referer")
                    : "RegisteredUser Controller?action=favourites");

        } catch (Exception e) {
            response.sendRedirect("RegisteredUser Controller?action=favourites");
        }
    }

    
}
