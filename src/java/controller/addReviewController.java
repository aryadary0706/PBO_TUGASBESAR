/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.*;
import java.util.*;
import Database.*;

/**
 *
 * @author user
 */
@WebServlet(name = "addReviewController", urlPatterns = {"/addReviewController"})
public class addReviewController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nama = request.getParameter("nama");
        String reviewText = request.getParameter("reviewText");
        String movieTitle = request.getParameter("movieTitle");

        int storyRate = Integer.parseInt(request.getParameter("storyRate"));
        int actingRate = Integer.parseInt(request.getParameter("actingRate"));
        int visualRate = Integer.parseInt(request.getParameter("visualRate"));
        int directingRate = Integer.parseInt(request.getParameter("directingRate"));
        float expectationScore = Float.parseFloat(request.getParameter("expectationScore"));

        Rating rating = new Rating(storyRate, actingRate, visualRate, directingRate, expectationScore);
        Review review = new Review(nama, reviewText, rating);

        // Ambil daftar movie dari application scope
        List<movie> movieList = (List<movie>) getServletContext().getAttribute("movies");

        for (movie m : movieList) {
            if (m.getTitle().equals(movieTitle)) {
                m.addReviewtoList(review); // Panggil method dengan objek Review
                break;
            }
        }

        // Redirect kembali ke halaman movie.jsp
        response.sendRedirect("movie.jsp?title=" + movieTitle);
    }
}
