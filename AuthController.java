package controller;

import model.UserDAO;
import model.RegisteredUser;
import model.GuestUser;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "AuthController", urlPatterns = {"/AuthController"})
public class AuthController extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate(); // hapus semua session
            }
            // Setelah logout, set guest user baru ke session
            request.getSession(true).setAttribute("guest", new GuestUser());
            response.sendRedirect("index.jsp");
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("login".equals(action)) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                RegisteredUser user = userDAO.login(username, password);

                if (user != null) {
                    HttpSession session = request.getSession();
                    session.removeAttribute("guest");
                    session.setAttribute("user", user); // simpan object RegisteredUser ke session
                    response.sendRedirect("home.jsp");
                } else {
                    request.setAttribute("error", "Login gagal!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else if ("register".equals(action)) {
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                RegisteredUser user = userDAO.register(username, email, password);

                HttpSession session = request.getSession();
                session.removeAttribute("guest");
                session.setAttribute("user", user);
                response.sendRedirect("home.jsp");
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}