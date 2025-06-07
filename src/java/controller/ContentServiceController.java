package controller;

import database.ContentDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Collections;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.*;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

/**
 * Servlet untuk mengelola layanan konten.
 */
@WebServlet(name = "ContentServiceController", urlPatterns = {"/ContentServiceController"})
public class ContentServiceController extends HttpServlet {

    private ContentDAO contentDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        contentDAO = new ContentDAO(); // Inisialisasi ContentDAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Inisialisasi objek konten dari database
        List<Content> allContents = null;
        try {
            allContents = contentDAO.getAllContents();
        } catch (SQLException ex) {
            Logger.getLogger(ContentServiceController.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Dapatkan user dari session
        RegisteredUser user = (RegisteredUser) request.getSession().getAttribute("user");

        // Gunakan ContentService sebagai business logic handler
        ContentService contentService = new ContentService(allContents);

        // Rekomendasi konten (belum ditonton user)
        List<Content> recommended = getRecommendedContent(contentService.getContents(), user);

        // Top rated dan most reviewed
        List<Content> topRated = contentService.getTopRated().stream().limit(4).collect(Collectors.toList());
        List<Content> mostReviewed = contentService.getMostReviewed().stream().limit(3).collect(Collectors.toList());

        // Set atribut ke request untuk JSP
        request.setAttribute("recommended", recommended);
        request.setAttribute("topRated", topRated);
        request.setAttribute("mostReviewed", mostReviewed);

        request.getRequestDispatcher("Kemas/Main.jsp").forward(request, response);
    }

    // Fallback untuk POST jika dibutuhkan
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Contoh pemanggilan search dari ContentService
        String action = request.getParameter("action");
        if ("search".equals(action)) {
            String keyword = request.getParameter("keyword");
            List<Content> results = null;
            try {
                results = contentDAO.getAllContents().stream()
                        .filter(content -> content.getTitle().toLowerCase().contains(keyword.toLowerCase()))
                        .collect(Collectors.toList());
            } catch (SQLException ex) {
                Logger.getLogger(ContentServiceController.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.setAttribute("searchResults", results);
            request.getRequestDispatcher("Kemas/SearchResult.jsp").forward(request, response);
        } else {
            doGet(request, response);
        }
    }

    private List<Content> getRecommendedContent(List<Content> allContents, RegisteredUser user) {
        if (allContents == null || allContents.isEmpty() || user == null) {
            return Collections.emptyList();
        }
        return allContents.stream()
                .filter(c -> !user.getContentHistory().contains(c))
                .collect(Collectors.toList());
    }

}
