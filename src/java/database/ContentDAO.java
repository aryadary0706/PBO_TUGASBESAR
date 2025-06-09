/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database;

/**
 *
 * @author user
 */
import model.Content;
import model.Series;
import model.movie;
import model.ContentService;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * ContentDAO acts as a Data Access Object for retrieving content data directly
 * from the database.
 */
public class ContentDAO {

    private ContentService contentService;

    /**
     * Gets a combined list of all contents (movies and series).
     *
     * @return List of Content objects
     * @throws SQLException if retrieving data fails
     */
    public List<Content> getAllContents() throws SQLException {
        List<Content> contents = new ArrayList<>();
        contents.addAll(getAllMovies());
        contents.addAll(getAllSeries());
        return contents;
    }

    /**
     * Gets a list of all movies.
     *
     * @return List of movie objects
     * @throws SQLException if retrieving data fails
     */
    public List<movie> getAllMovies() throws SQLException {
        List<movie> movies = new ArrayList<>();
        String query = """
    SELECT c.id, c.title, c.synopsis, c.release_date, c.image_url, c.rating, m.duration,
           GROUP_CONCAT(DISTINCT g.name SEPARATOR '|') AS genre,
           GROUP_CONCAT(DISTINCT a.name SEPARATOR '|') AS actors
    FROM content AS c
    LEFT JOIN movie m ON c.id = m.content_id
    LEFT JOIN content_actor ca ON ca.content_id = c.id
    LEFT JOIN actor a ON ca.actor_id = a.id
    LEFT JOIN content_genre cg ON c.id = cg.content_id
    LEFT JOIN genre g ON cg.genre_id = g.id
    LEFT JOIN review r ON c.id = r.content_id
    WHERE m.content_id IS NOT NULL
    GROUP BY c.id, c.title, c.synopsis, c.release_date, c.image_url, c.rating, m.duration
    """;

        try (Connection con = DBConnection.getConnection(); Statement stmt = con.createStatement(); ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                // Extract basic content information
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String synopsis = rs.getString("synopsis");
                Date releaseDate = rs.getDate("release_date");
                int duration = rs.getInt("duration");
                double avgRating = rs.getDouble("rating");
                String imageUrl = rs.getString("image_url");

                // Handle genres
                String genreString = rs.getString("genre");
                List<String> genres = new ArrayList<>();
                if (genreString != null && !genreString.trim().isEmpty()) {
                    genres = Arrays.asList(genreString.split("\\|"));
                }

                // Handle actors
                String actorString = rs.getString("actors");
                List<String> actors = new ArrayList<>();
                if (actorString != null && !actorString.trim().isEmpty()) {
                    actors = Arrays.asList(actorString.split("\\|"));
                }

                // Create movie object with all required parameters
                movie movieObj = new movie(duration, id, title, releaseDate, synopsis, actors, genres, imageUrl);
                movieObj.setAverageRating(avgRating);

                // Tambahkan validasi untuk memastikan data yang diperlukan ada
                if (title == null || title.trim().isEmpty()) {
                    throw new SQLException("Title is required");
                }

                if (releaseDate == null) {
                    throw new SQLException("Release date is required");
                }

                // Untuk movie
                if (duration <= 0) {
                    throw new SQLException("Duration must be greater than 0");
                }

                movies.add(movieObj);
            }
        } catch (SQLException e) {
            Logger.getLogger(ContentDAO.class.getName()).log(Level.SEVERE,
                    "Error accessing database: " + e.getMessage(), e);
            throw new SQLException("Failed to retrieve content data. Please try again later.");
        } catch (Exception e) {
            Logger.getLogger(ContentDAO.class.getName()).log(Level.SEVERE,
                    "Unexpected error: " + e.getMessage(), e);
            throw new SQLException("An unexpected error occurred. Please try again later.");
        }

        return movies;
    }

    /**
     * Gets a list of all series.
     *
     * @return List of Series objects
     * @throws SQLException if retrieving data fails
     */
    public List<Series> getAllSeries() throws SQLException {
        List<Series> seriesList = new ArrayList<>();
        String query = """
    SELECT 
        c.id, c.title, c.synopsis, c.release_date, c.image_url, c.rating,
        s.total_episode, s.total_duration, s.season,
        COALESCE(GROUP_CONCAT(DISTINCT g.name SEPARATOR '|'), '') AS genre,
        COALESCE(GROUP_CONCAT(DISTINCT a.name SEPARATOR '|'), '') AS actors
    FROM content AS c
    LEFT JOIN series s ON c.id = s.content_id
    LEFT JOIN content_actor ca ON ca.content_id = c.id
    LEFT JOIN actor a ON ca.actor_id = a.id
    LEFT JOIN content_genre cg ON c.id = cg.content_id
    LEFT JOIN genre g ON cg.genre_id = g.id
    LEFT JOIN review r ON c.id = r.content_id
    WHERE s.content_id IS NOT NULL
    GROUP BY 
        c.id, c.title, c.synopsis, c.release_date, c.image_url, c.rating,
        s.total_episode, s.total_duration, s.season
    """;

        try (Connection con = DBConnection.getConnection(); Statement stmt = con.createStatement(); ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String synopsis = rs.getString("synopsis");
                Date releaseDate = rs.getDate("release_date");
                String imageUrl = rs.getString("image_url");
                double rating = rs.getDouble("rating");

                int totalEpisode = rs.getInt("total_episode");
                int totalDuration = rs.getInt("total_duration");
                int season = rs.getInt("season");

                String genreString = rs.getString("genre");
                List<String> genres = new ArrayList<>();
                if (genreString != null && !genreString.trim().isEmpty()) {
                    genres = Arrays.asList(genreString.split("\\|"));
                }

                String actorString = rs.getString("actors");
                List<String> actors = new ArrayList<>();
                if (actorString != null && !actorString.trim().isEmpty()) {
                    actors = Arrays.asList(actorString.split("\\|"));
                }

                Series seriesObj = new Series(totalEpisode, totalDuration, season,
                        id, title, releaseDate, synopsis,
                        actors, genres, imageUrl);
                seriesObj.setAverageRating(rating);

                if (title == null || title.trim().isEmpty()) {
                    throw new SQLException("Title is required");
                }
                if (releaseDate == null) {
                    throw new SQLException("Release date is required");
                }
                if (totalEpisode <= 0) {
                    throw new SQLException("Total episode must be greater than 0");
                }
                if (season <= 0) {
                    throw new SQLException("Season must be greater than 0");
                }

                seriesList.add(seriesObj);
            }

        } catch (SQLException e) {
            Logger.getLogger(ContentDAO.class.getName()).log(Level.SEVERE,
                    "Error accessing database: " + e.getMessage(), e);
            throw new SQLException("Failed to retrieve series data. Please try again later.");
        } catch (Exception e) {
            Logger.getLogger(ContentDAO.class.getName()).log(Level.SEVERE,
                    "Unexpected error: " + e.getMessage(), e);
            throw new SQLException("An unexpected error occurred. Please try again later.");
        }

        return seriesList;
    }

    public Content getContentById(int id) throws SQLException {
        // Cek apakah ID ini ada di tabel movie
        String checkMovieQuery = "SELECT COUNT(*) FROM movie WHERE content_id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement checkStmt = conn.prepareStatement(checkMovieQuery)) {

            checkStmt.setInt(1, id);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return getMovieById(id); // Movie ditemukan
            } else {
                return getSeriesById(id); // Jika bukan movie, coba series
            }
        }
    }

    public movie getMovieById(int id) throws SQLException {
        String query = """
                       SELECT c.id, c.title, c.synopsis, c.release_date, c.image_url, c.rating,
                              m.duration,
                              COALESCE(GROUP_CONCAT(DISTINCT g.name SEPARATOR '|'), '') AS genre,
                              COALESCE(GROUP_CONCAT(DISTINCT a.name SEPARATOR '|'), '') AS actors
                       FROM content AS c
                       LEFT JOIN movie m ON c.id = m.content_id
                       LEFT JOIN content_actor ca ON ca.content_id = c.id
                       LEFT JOIN actor a ON ca.actor_id = a.id
                       LEFT JOIN content_genre cg ON c.id = cg.content_id
                       LEFT JOIN genre g ON cg.genre_id = g.id
                       WHERE c.id = ? AND m.content_id IS NOT NULL
                       GROUP BY c.id, c.title, c.synopsis, c.release_date, c.image_url, c.rating, m.duration;
                       """;

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int idUser = rs.getInt("id");
                String title = rs.getString("title");
                String synopsis = rs.getString("synopsis");
                Date releaseDate = rs.getDate("release_date");
                int duration = rs.getInt("duration");
                double avgRating = rs.getDouble("rating");
                String imageUrl = rs.getString("image_url");

                // Handle genres
                String genreString = rs.getString("genre");
                List<String> genres = new ArrayList<>();
                if (genreString != null && !genreString.trim().isEmpty()) {
                    genres = Arrays.asList(genreString.split("\\|"));
                }

                // Handle actors
                String actorString = rs.getString("actors");
                List<String> actors = new ArrayList<>();
                if (actorString != null && !actorString.trim().isEmpty()) {
                    actors = Arrays.asList(actorString.split("\\|"));
                }

                // Create movie object with all required parameters
                movie m = new movie(duration, idUser, title, releaseDate, synopsis, actors, genres, imageUrl);
                m.setAverageRating(avgRating);

                return m;
            }
        }
        return null;
    }

    public Series getSeriesById(int id) throws SQLException {
        String query = """
                       SELECT c.id, c.title, c.synopsis, c.release_date, c.image_url, c.rating,
                              s.total_episode, s.total_duration, s.season,
                              COALESCE(GROUP_CONCAT(DISTINCT g.name SEPARATOR '|'), '') AS genre,
                              COALESCE(GROUP_CONCAT(DISTINCT a.name SEPARATOR '|'), '') AS actors
                       FROM content AS c
                       LEFT JOIN series s ON c.id = s.content_id
                       LEFT JOIN content_actor ca ON ca.content_id = c.id
                       LEFT JOIN actor a ON ca.actor_id = a.id
                       LEFT JOIN content_genre cg ON c.id = cg.content_id
                       LEFT JOIN genre g ON cg.genre_id = g.id
                       WHERE c.id = ? AND s.content_id IS NOT NULL
                       GROUP BY c.id, c.title, c.synopsis, c.release_date, c.image_url, c.rating,
                                s.total_episode, s.total_duration, s.season;
                       """;

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int idUser = rs.getInt("id");
                String title = rs.getString("title");
                String synopsis = rs.getString("synopsis");
                Date releaseDate = rs.getDate("release_date");
                String imageUrl = rs.getString("image_url");
                double rating = rs.getDouble("rating");

                int totalEpisode = rs.getInt("total_episode");
                int totalDuration = rs.getInt("total_duration");
                int season = rs.getInt("season");

                String genreString = rs.getString("genre");
                List<String> genres = new ArrayList<>();
                if (genreString != null && !genreString.trim().isEmpty()) {
                    genres = Arrays.asList(genreString.split("\\|"));
                }

                String actorString = rs.getString("actors");
                List<String> actors = new ArrayList<>();
                if (actorString != null && !actorString.trim().isEmpty()) {
                    actors = Arrays.asList(actorString.split("\\|"));
                }

                Series s = new Series(totalEpisode, totalDuration, season,
                        idUser, title, releaseDate, synopsis,
                        actors, genres, imageUrl);
                s.setAverageRating(rating);

                return s;
            }
        }
        return null;
    }

}
