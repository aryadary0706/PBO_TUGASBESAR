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
import model.*;
import java.util.*;
import javax.servlet.http.HttpSession;

/**
 *
 * @author user
 */
@WebServlet(name = "UserListServlet", urlPatterns = {"/UserListServlet"})
public class UserListServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action"); // add/remove/clear
        String listType = request.getParameter("list"); // favorites/watchlist/history
        String contentTitle = request.getParameter("title"); // title of the content (optional)

        // Ambil user yang sedang login dari session
        HttpSession session = request.getSession();
        RegisteredUser user = (RegisteredUser) session.getAttribute("loggedInUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Ambil list konten dari context
        List<Content> contentList = (List<Content>) getServletContext().getAttribute("allContent");

        // Temukan konten berdasarkan judul
        Content target = null;
        if (contentTitle != null && !contentTitle.isEmpty() && contentList != null) {
            for (Content c : contentList) {
                if (c.getTitle().equalsIgnoreCase(contentTitle)) {
                    target = c;
                    break;
                }
            }
        }

        try {
            if ("add".equalsIgnoreCase(action)) {
                if ("favorites".equalsIgnoreCase(listType)) {
                    user.addToFavorites(target);
                } else if ("watchlist".equalsIgnoreCase(listType)) {
                    user.addToWatchList(target);
                } else if ("history".equalsIgnoreCase(listType)) {
                    user.getContentHistory().add(target);
                }
            } else if ("remove".equalsIgnoreCase(action)) {
                if ("favorites".equalsIgnoreCase(listType)) {
                    user.removeFromFavorites(target);
                } else if ("watchlist".equalsIgnoreCase(listType)) {
                    user.removeFromWatchlist(target);
                } else if ("history".equalsIgnoreCase(listType)) {
                    user.getContentHistory().remove(target);
                }
            } else if ("clear".equalsIgnoreCase(action)) {
                if ("favorites".equalsIgnoreCase(listType)) {
                    user.clearFavorites();
                } else if ("watchlist".equalsIgnoreCase(listType)) {
                    user.clearWatchlist();
                } else if ("history".equalsIgnoreCase(listType)) {
                    user.clearContentHistory();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
        }

        // Setelah operasi, redirect ke halaman profil atau dashboard
        response.sendRedirect("userProfile.jsp");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Mengatur operasi user list seperti favorites, watchlist, dan history.";
    }

}
