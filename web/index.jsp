<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.GuestUser,model.RegisteredUser" %>
<%
    RegisteredUser user = (RegisteredUser) session.getAttribute("user");
    GuestUser guest = (GuestUser) session.getAttribute("guest");
    if (user != null) {
        response.sendRedirect("home.jsp"); return;
    }
    if (guest != null) {
        response.sendRedirect("guesthome.jsp"); return;
    }
    guest = new GuestUser();
    session.setAttribute("guest", guest);
    response.sendRedirect("guesthome.jsp");
    return;
%>