package controller;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.*;
import database.ContentDAO;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ContentServiceController", urlPatterns = {"/ContentServiceController"})
public class ContentServiceController extends HttpServlet {

    private ContentDAO contentDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        contentDAO = new ContentDAO(); // Inisialisasi ContentDAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Ambil semua konten dari database
        List<Content> allContent = null;
        try {
            allContent = contentDAO.getAllContents();
        } catch (SQLException ex) {
            Logger.getLogger(ContentServiceController.class.getName()).log(Level.SEVERE, null, ex);
        }
        ContentService service = new ContentService(allContent);

        HttpSession session = request.getSession();
        RegisteredUser regUser = (RegisteredUser) session.getAttribute("user");
        GuestUser guestUser = (GuestUser) session.getAttribute("guest");

        String action = request.getParameter("action");
        if (action == null) {
            // Jika tidak ada action -> load halaman utama dengan rekomendasi dan konten populer
            handleMainPage(request, response, service, regUser, guestUser);
        } else if (action.equals("searchContent")) {
            handleSearch(request, response, service);
        } else if (action.equals("filterByGenre")) {
            handleGenreFilter(request, response, service);
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    private void handleMainPage(HttpServletRequest request, HttpServletResponse response,
            ContentService service, RegisteredUser regUser, GuestUser guestUser) throws ServletException, IOException {
        List<Content> topRated = service.getTopRated(service.getContents());
        List<Content> mostReviewed = service.getMostReviewed(service.getContents());

        List<Content> recommendedContent = new ArrayList<>();
        if (regUser != null) {
            // Rekomendasi berdasarkan konten terakhir di watchlist/favorites
            List<Content> recentUserContent = regUser.getWatchList();
            if (recentUserContent.isEmpty()) {
                recentUserContent = regUser.getFavorites();
            }
            if (!recentUserContent.isEmpty()) {
                Content current = recentUserContent.get(recentUserContent.size() - 1);
                service.addToRecommendations(current, service.getContents(), regUser);
                List<Content> recList = service.getReccomendations();
                for (int i = 0; i < Math.min(2, recList.size()); i++) {
                    recommendedContent.add(recList.get(i));
                }
            } else {
                // Jika tidak ada history/favorites, ambil dari topRated
                for (int i = 0; i < Math.min(2, topRated.size()); i++) {
                    recommendedContent.add(topRated.get(i));
                }
            }
        } else if (guestUser != null) {
            // Untuk guest, ambil dari topRated
            for (int i = 0; i < Math.min(2, topRated.size()); i++) {
                recommendedContent.add(topRated.get(i));
            }
        }

        request.setAttribute("recommendedContent", recommendedContent);
        request.setAttribute("topRatedContent", topRated);
        request.setAttribute("mostReviewedContent", mostReviewed);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Main.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    private void handleSearch(HttpServletRequest request, HttpServletResponse response,
            ContentService service) throws ServletException, IOException {
        String query = request.getParameter("query");
        if (query != null && !query.trim().isEmpty()) {
            List<Content> results = service.searchContent(query.trim());
            request.setAttribute("searchResults", results);
            request.setAttribute("query", query);
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("SearchResults.jsp");
        dispatcher.forward(request, response);
    }

    private void handleGenreFilter(HttpServletRequest request, HttpServletResponse response,
            ContentService service) throws ServletException, IOException {
        String genre = request.getParameter("genre");
        if (genre != null && !genre.trim().isEmpty()) {
            List<Content> results = service.filterByGenre(genre.trim());
            request.setAttribute("filteredResults", results);
            request.setAttribute("genre", genre);
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("GenreResults.jsp");
        dispatcher.forward(request, response);
    }
}
