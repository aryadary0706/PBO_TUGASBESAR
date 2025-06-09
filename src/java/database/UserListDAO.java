package database;

import model.Content;
import model.Series;
import model.movie;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class UserListDAO {

    /**
     * Gets user's favorite contents.
     *
     * @param userId the ID of the user
     * @return List of Content objects in user's favorites
     * @throws SQLException if retrieving data fails
     */
    public List<Content> getUserFavorites(int userId) throws SQLException {
        String query = """
    SELECT c.*, 
           GROUP_CONCAT(DISTINCT g.name) AS genre, 
           GROUP_CONCAT(DISTINCT a.name) AS actors
    FROM favoritecontent fc
    JOIN content c ON c.id = fc.contentId
    LEFT JOIN content_genre cg ON c.id = cg.content_id
    LEFT JOIN genre g ON g.id = cg.genre_id
    LEFT JOIN content_actor ca ON c.id = ca.content_id
    LEFT JOIN actor a ON a.id = ca.actor_id
    WHERE fc.userId = ?
    GROUP BY c.id
    """;

        List<Content> favorites = new ArrayList<>();
        try (Connection con = DBConnection.getConnection(); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Content content = createContentFromResultSet(rs);
                if (content != null) {
                    favorites.add(content);
                }
            }
        }
        return favorites;
    }

    /**
     * Gets user's watchlist contents.
     *
     * @param userId the ID of the user
     * @return List of Content objects in user's watchlist
     * @throws SQLException if retrieving data fails
     */
    public List<Content> getUserWatchlist(int userId) throws SQLException {
        String query = """
    SELECT c.*, 
           GROUP_CONCAT(DISTINCT g.name) AS genre, 
           GROUP_CONCAT(DISTINCT a.name) AS actors
    FROM watchlist w
    JOIN content c ON c.id = w.contentId
    LEFT JOIN content_genre cg ON c.id = cg.content_id
    LEFT JOIN genre g ON g.id = cg.genre_id
    LEFT JOIN content_actor ca ON c.id = ca.content_id
    LEFT JOIN actor a ON a.id = ca.actor_id
    WHERE w.userId = ?
    GROUP BY c.id
    """;

        List<Content> watchlist = new ArrayList<>();
        try (Connection con = DBConnection.getConnection(); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Content content = createContentFromResultSet(rs);
                if (content != null) {
                    watchlist.add(content);
                }
            }
        }
        return watchlist;
    }

    /**
     * Gets user's content history.
     *
     * @param userId the ID of the user
     * @return List of Content objects in user's history
     * @throws SQLException if retrieving data fails
     */
    public List<Content> getUserHistory(int userId) throws SQLException {
        String query = """
    SELECT c.*, 
           GROUP_CONCAT(DISTINCT g.name) AS genre, 
           GROUP_CONCAT(DISTINCT a.name) AS actors
    FROM contenthistory ch
    JOIN content c ON c.id = ch.contentId
    LEFT JOIN content_genre cg ON c.id = cg.content_id
    LEFT JOIN genre g ON g.id = cg.genre_id
    LEFT JOIN content_actor ca ON c.id = ca.content_id
    LEFT JOIN actor a ON a.id = ca.actor_id
    WHERE ch.userId = ?
    GROUP BY c.id
    """;

        List<Content> history = new ArrayList<>();
        try (Connection con = DBConnection.getConnection(); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Content content = createContentFromResultSet(rs);
                if (content != null) {
                    history.add(content);
                }
            }
        }
        return history;
    }

    /**
     * Adds content to user's favorites.
     *
     * @param userId the ID of the user
     * @param contentId the ID of the content to add
     * @return true if content was added, false if it was already in favorites
     * @throws SQLException if database operation fails
     */
    public boolean addToFavorites(int userId, int contentId) throws SQLException {
        String query = "INSERT IGNORE INTO favoritecontent (userId, contentId) VALUES (?, ?)";
        try (Connection con = DBConnection.getConnection(); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, contentId);
            return pstmt.executeUpdate() > 0;
        }
    }

    /**
     * Removes content from user's favorites.
     *
     * @param userId the ID of the user
     * @param contentId the ID of the content to remove
     * @return true if content was removed, false if it wasn't in favorites
     * @throws SQLException if database operation fails
     */
    public boolean removeFromFavorites(int userId, int contentId) throws SQLException {
        String query = "DELETE FROM favoritecontent WHERE userId = ? AND contentId = ?";
        try (Connection con = DBConnection.getConnection(); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, contentId);
            return pstmt.executeUpdate() > 0;
        }
    }

    /**
     * Adds content to user's watchlist.
     *
     * @param userId the ID of the user
     * @param contentId the ID of the content to add
     * @return true if content was added, false if it was already in watchlist
     * @throws SQLException if database operation fails
     */
    public boolean addToWatchlist(int userId, int contentId) throws SQLException {
        String query = "INSERT IGNORE INTO watchlist (userId, contentId) VALUES (?, ?)";
        try (Connection con = DBConnection.getConnection(); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, contentId);
            return pstmt.executeUpdate() > 0;
        }
    }

    /**
     * Removes content from user's watchlist.
     *
     * @param userId the ID of the user
     * @param contentId the ID of the content to remove
     * @return true if content was removed, false if it wasn't in watchlist
     * @throws SQLException if database operation fails
     */
    public boolean removeFromWatchlist(int userId, int contentId) throws SQLException {
        String query = "DELETE FROM watchlist WHERE userId = ? AND contentId = ?";
        try (Connection con = DBConnection.getConnection(); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, contentId);
            return pstmt.executeUpdate() > 0;
        }
    }

    /**
     * Adds content to user's history.
     *
     * @param userId the ID of the user
     * @param contentId the ID of the content to add
     * @return true if content was added to history
     * @throws SQLException if database operation fails
     */
    public boolean addToHistory(int userId, int contentId) throws SQLException {
        String query = "INSERT INTO contenthistory (userId, contentId) VALUES (?, ?)";
        try (Connection con = DBConnection.getConnection(); PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, contentId);
            return pstmt.executeUpdate() > 0;
        }
    }

    /**
     * Helper method to create Content object from ResultSet.
     */
    private Content createContentFromResultSet(ResultSet rs) throws SQLException {
        int id = rs.getInt("id");
        String title = rs.getString("title");
        String synopsis = rs.getString("synopsis");
        Date releaseDate = rs.getDate("release_date");
        String imageUrl = rs.getString("image_url");
        double avgRating = rs.getDouble("rating");

        // Handle genres
        String genreString = rs.getString("genre");
        List<String> genres = new ArrayList<>();
        if (genreString != null && !genreString.trim().isEmpty()) {
            genres = Arrays.asList(genreString.split(","));
        }

        // Handle actors
        String actorString = rs.getString("actors");
        List<String> actors = new ArrayList<>();
        if (actorString != null && !actorString.trim().isEmpty()) {
            actors = Arrays.asList(actorString.split(","));
        }

        Content content;
        if (rs.getObject("duration") != null) {
            // It's a movie
            int duration = rs.getInt("duration");
            content = new movie(duration, id, title, releaseDate, synopsis, actors, genres, imageUrl);
        } else {
            // It's a series
            int totalEpisode = rs.getInt("total_episode");
            int totalDuration = rs.getInt("total_duration");
            int season = rs.getInt("season");
            content = new Series(totalEpisode, totalDuration, season, id, title, releaseDate, synopsis, actors, genres);
        }

        content.setImageUrl(imageUrl);
        content.setAverageRating(avgRating);

        return content;
    }
}
