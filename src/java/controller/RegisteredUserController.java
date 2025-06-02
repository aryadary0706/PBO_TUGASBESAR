/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.*;
import java.util.List;
import database.*;
import java.util.ArrayList;
import java.util.Comparator;

/**
 *
 * @author user
 */
@WebServlet(name = "RegisteredUserController", urlPatterns = {"/RegisteredUserController"})
public class RegisteredUserController extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("Kemas/main.jsp");
            return;
        }

        RegisteredUser user = (RegisteredUser) session.getAttribute("user");
        String action = request.getParameter("action");
        ContentJDBC contentJDBC = new ContentJDBC();

        if (action == null || action.isEmpty()) {
            loadMainPage(request, response, user, contentJDBC);
            return;
        }

        switch (action) {
            case "forYou":
                loadMainPage(request, response, user, contentJDBC);
                break;

            case "favourites":
                List<Content> favorites = user.getFavorites();
                request.setAttribute("contents", favorites);
                request.getRequestDispatcher("Kemas/FavoritesList.jsp").forward(request, response);
                break;

            case "watchlist":
                List<Content> watchlist = user.getWatchList();
                request.setAttribute("contents", watchlist);
                request.getRequestDispatcher("Kemas/WatchList.jsp").forward(request, response);
                break;

            case "history":
                List<Content> history = user.getContentHistory();
                request.setAttribute("contents", history);
                request.getRequestDispatcher("Kemas/History.jsp").forward(request, response);
                break;

            // case "movies":
            //     List<movie> movies = contentJDBC.getAllMovies();
            //     request.setAttribute("contents", movies);
            //     request.getRequestDispatcher("Kemas/Movies.jsp").forward(request, response);
            //     break;

            // case "series":
            //     List<Series> series = contentJDBC.getAllSeries();
            //     request.setAttribute("contents", series);
            //     request.getRequestDispatcher("Kemas/Series.jsp").forward(request, response);
            //     break;

            case "search":
                String query = request.getParameter("query");
                if (query != null && !query.isEmpty()) {
                    List<Content> searchResults = searchContent(query, contentJDBC);
                    request.setAttribute("contents", searchResults);
                    request.setAttribute("searchQuery", query);
                    request.getRequestDispatcher("Kemas/SearchResults.jsp").forward(request, response);
                } else {
                    response.sendRedirect("RegisteredUserController?action=forYou");
                }
                break;

            case "logout":
                session.invalidate();
                response.sendRedirect("Kemas/login.jsp");
                break;

            default:
                response.sendRedirect("RegisteredUserController?action=forYou");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("Kemas/main.jsp");
            return;
        }

        RegisteredUser user = (RegisteredUser) session.getAttribute("user");
        String action = request.getParameter("action");
        String contentId = request.getParameter("contentId");
        ContentJDBC contentJDBC = new ContentJDBC();

        try {
            if (contentId != null && !contentId.isEmpty()) {
                Content content = contentJDBC.getContentById(Integer.parseInt(contentId));
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
                    }
                }
            }

            // Update session with modified user
            session.setAttribute("user", user);
            
            // Redirect back to the appropriate page
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null ? referer : "RegisteredUserController?action=forYou");

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid content ID");
            response.sendRedirect("RegisteredUserController?action=forYou");
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            response.sendRedirect("RegisteredUserController?action=forYou");
        }
    }

    private void loadMainPage(HttpServletRequest request, HttpServletResponse response,
            RegisteredUser user, ContentJDBC contentJDBC)
            throws ServletException, IOException {
        
        List<Content> allContents = contentJDBC.getAllContents();
        
        // Get recommended content (first unwatched content)
        Content recommended = allContents.stream()
                .filter(c -> !user.getContentHistory().contains(c))
                .findFirst()
                .orElse(allContents.isEmpty() ? null : allContents.get(0));
        
        // Get top rated content
        List<Content> topRated = allContents.stream()
                .filter(c -> !c.getReviews().isEmpty())
                .sorted((c1, c2) -> {
                    double rating1 = c1.getReviews().stream()
                            .mapToDouble(r -> r.getRating().getAverageRate())
                            .average()
                            .orElse(0.0);
                    double rating2 = c2.getReviews().stream()
                            .mapToDouble(r -> r.getRating().getAverageRate())
                            .average()
                            .orElse(0.0);
                    return Double.compare(rating2, rating1);
                })
                .limit(4)
                .collect(java.util.stream.Collectors.toList());
        
        // Get most viewed content
        List<Content> mostViewed = allContents.stream()
                .limit(3)
                .collect(java.util.stream.Collectors.toList());
        
        request.setAttribute("recommended", recommended);
        request.setAttribute("topRated", topRated);
        request.setAttribute("mostViewed", mostViewed);
        
        request.getRequestDispatcher("Kemas/Main.jsp").forward(request, response);
    }

    private List<Content> searchContent(String query, ContentJDBC contentJDBC) {
        List<Content> allContents = contentJDBC.getAllContents();
        return allContents.stream()
                .filter(content -> 
                    content.getTitle().toLowerCase().contains(query.toLowerCase()) ||
                    content.getSynopsis().toLowerCase().contains(query.toLowerCase()) ||
                    content.getGenres().stream().anyMatch(genre -> 
                        genre.toLowerCase().contains(query.toLowerCase())) ||
                    content.getActors().stream().anyMatch(actor -> 
                        actor.toLowerCase().contains(query.toLowerCase()))
                )
                .collect(java.util.stream.Collectors.toList());
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "RegisteredUserController handles user actions and content management for CineMagz";
    }// </editor-fold>

}