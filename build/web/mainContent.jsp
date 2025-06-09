<%@ page import="java.sql.*" %>
<%
    int seriesId = Integer.parseInt(request.getParameter("seriesId"));
    String reviewer = request.getParameter("reviewer");
    float rating = Float.parseFloat(request.getParameter("rating"));
    String comment = request.getParameter("comment");

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinemagz", "root", "");

    PreparedStatement ps = conn.prepareStatement("INSERT INTO Review(series_id, reviewer_name, rating, comment) VALUES (?, ?, ?, ?)");
    ps.setInt(1, seriesId);
    ps.setString(2, reviewer);
    ps.setFloat(3, rating);
    ps.setString(4, comment);
    ps.executeUpdate();

    ps.close();
    conn.close();

    response.sendRedirect("seriesDetail.jsp?seriesId=" + seriesId);
%>
