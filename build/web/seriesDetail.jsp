<%@ page import="java.sql.*" %>
<%
    int seriesId = Integer.parseInt(request.getParameter("seriesId"));

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinemagz", "root", "");

    PreparedStatement ps = conn.prepareStatement("SELECT * FROM Series WHERE id = ?");
    ps.setInt(1, seriesId);
    ResultSet rs = ps.executeQuery();
    rs.next();
%>

<html>
<head>
    <title><%= rs.getString("title") %></title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="series-detail">
        <h1><%= rs.getString("title") %></h1>
        <img src="<%= rs.getString("thumbnail_url") %>" class="detail-image"/>
        <p><%= rs.getString("description") %></p>
    </div>

    <h2>Reviews</h2>
<%
    PreparedStatement psReview = conn.prepareStatement("SELECT * FROM Review WHERE series_id = ?");
    psReview.setInt(1, seriesId);
    ResultSet reviews = psReview.executeQuery();
    while (reviews.next()) {
%>
    <div class="review">
        <strong><%= reviews.getString("reviewer_name") %></strong> - <%= reviews.getFloat("rating") %>/5<br>
        <em><%= reviews.getString("comment") %></em>
    </div>
<% } %>

    <h3>Tambah Review</h3>
    <form action="addReview.jsp" method="post">
        <input type="hidden" name="seriesId" value="<%= seriesId %>"/>
        <input type="text" name="reviewer" placeholder="Nama" required/><br>
        <input type="number" name="rating" step="0.1" min="0" max="5" placeholder="Rating" required/><br>
        <textarea name="comment" placeholder="Komentar..." required></textarea><br>
        <input type="submit" value="Kirim Review"/>
    </form>

<%
    rs.close();
    ps.close();
    psReview.close();
    conn.close();
%>
</body>
</html>
