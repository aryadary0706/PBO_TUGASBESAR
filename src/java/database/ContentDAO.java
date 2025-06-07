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
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * ContentDAO acts as a Data Access Object for retrieving content data directly from the database.
 */
public class ContentDAO {

    /**
     * Gets a combined list of all contents (movies and series).
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
     * @return List of movie objects
     * @throws SQLException if retrieving data fails
     */
    public List<movie> getAllMovies() throws SQLException {
        List<movie> movies = new ArrayList<>();
        String query = "SELECT c.id, c.title, c.synopsis, c.release_date, c.image_url, "
                + "m.duration, GROUP_CONCAT(DISTINCT a.name) AS actors, "
                + "GROUP_CONCAT(DISTINCT g.name) AS genres "
                + "FROM content c "
                + "LEFT JOIN movie m ON c.id = m.content_id "
                + "LEFT JOIN content_actor ca ON c.id = ca.content_id "
                + "LEFT JOIN actors a ON ca.actor_id = a.id "
                + "LEFT JOIN content_genres cg ON c.id = cg.content_id "
                + "LEFT JOIN genres g ON cg.genres_id = g.id "
                + "WHERE m.content_id IS NOT NULL "
                + "GROUP BY c.id";

        try (Connection con = DBConnection.getConnection(); 
             Statement stmt = con.createStatement(); 
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                // Extract basic content information
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String synopsis = rs.getString("synopsis");
                Date releaseDate = rs.getDate("release_date");
                int duration = rs.getInt("duration");

                // Handle genres
                String genreString = rs.getString("genres");
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

                // Create movie object with all required parameters
                movie movieObj = new movie(duration, id, title, releaseDate, synopsis, actors, genres);

                // Set image URL if available
                String imageUrl = rs.getString("image_url");
                if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                    movieObj.setImageUrl(imageUrl);
                }

                movies.add(movieObj);
            }
        } catch (SQLException e) {
            throw new SQLException("Database error while fetching movies: " + e.getMessage(), e);
        }

        return movies;
    }

    /**
     * Gets a list of all series.
     * @return List of Series objects
     * @throws SQLException if retrieving data fails
     */
    public List<Series> getAllSeries() throws SQLException {
        List<Series> seriesList = new ArrayList<>();
        String query = "SELECT c.id, c.title, c.synopsis, c.release_date, c.image_url, "
                + "s.total_episode, s.total_duration, s.season, "
                + "GROUP_CONCAT(DISTINCT a.name) AS actors, "
                + "GROUP_CONCAT(DISTINCT g.name) AS genres "
                + "FROM content c "
                + "LEFT JOIN series s ON c.id = s.content_id "
                + "LEFT JOIN content_actor ca ON c.id = ca.content_id "
                + "LEFT JOIN actors a ON ca.actor_id = a.id "
                + "LEFT JOIN content_genres cg ON c.id = cg.content_id "
                + "LEFT JOIN genres g ON cg.genres_id = g.id "
                + "WHERE s.content_id IS NOT NULL "
                + "GROUP BY c.id";

        try (Connection con = DBConnection.getConnection(); 
             Statement stmt = con.createStatement(); 
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                // Extract basic content information
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String synopsis = rs.getString("synopsis");
                Date releaseDate = rs.getDate("release_date");

                // Series specific fields
                int totalEpisode = rs.getInt("total_episode");
                int totalDuration = rs.getInt("total_duration");
                int season = rs.getInt("season");

                // Handle genres
                String genreString = rs.getString("genres");
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

                // Create series object with all required parameters
                Series seriesObj = new Series(totalEpisode, totalDuration, season, id, title, releaseDate, synopsis, actors, genres);

                // Set image URL if available
                String imageUrl = rs.getString("image_url");
                if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                    seriesObj.setImageUrl(imageUrl);
                }

                seriesList.add(seriesObj);
            }
        } catch (SQLException e) {
            throw new SQLException("Database error while fetching series: " + e.getMessage(), e);
        }

        return seriesList;
    }

    /**
     * Gets content by its ID, either a movie or a series.
     * @param contentId the ID of the content
     * @return Content object or null if not found
     * @throws SQLException if retrieving data fails
     */
    public Content getContentById(int contentId) throws SQLException {
        Content content = null;

        // First try to get as movie
        String movieQuery = "SELECT c.id, c.title, c.synopsis, c.release_date, c.image_url, "
                + "m.duration, GROUP_CONCAT(DISTINCT a.name) AS actors, "
                + "GROUP_CONCAT(DISTINCT g.name) AS genres "
                + "FROM content c "
                + "LEFT JOIN movie m ON c.id = m.content_id "
                + "LEFT JOIN content_actor ca ON c.id = ca.content_id "
                + "LEFT JOIN actors a ON ca.actor_id = a.id "
                + "LEFT JOIN content_genres cg ON c.id = cg.content_id "
                + "LEFT JOIN genres g ON cg.genres_id = g.id "
                + "WHERE c.id = ? AND m.content_id IS NOT NULL "
                + "GROUP BY c.id";

        try (Connection con = DBConnection.getConnection(); 
             PreparedStatement pstmt = con.prepareStatement(movieQuery)) {
            pstmt.setInt(1, contentId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // Extract movie information
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String synopsis = rs.getString("synopsis");
                Date releaseDate = rs.getDate("release_date");
                int duration = rs.getInt("duration");

                // Handle genres
                String genreString = rs.getString("genres");
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

                // Create movie object
                movie movieObj = new movie(duration, id, title, releaseDate, synopsis, actors, genres);

                // Set image URL if available
                String imageUrl = rs.getString("image_url");
                if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                    movieObj.setImageUrl(imageUrl);
                }

                content = movieObj;
            } else {
                // Try to get as series
                String seriesQuery = "SELECT c.id, c.title, c.synopsis, c.release_date, c.image_url, "
                        + "s.total_episode, s.total_duration, s.season, "
                        + "GROUP_CONCAT(DISTINCT a.name) AS actors, "
                        + "GROUP_CONCAT(DISTINCT g.name) AS genres "
                        + "FROM content c "
                        + "LEFT JOIN series s ON c.id = s.content_id "
                        + "LEFT JOIN content_actor ca ON c.id = ca.content_id "
                        + "LEFT JOIN actors a ON ca.actor_id = a.id "
                        + "LEFT JOIN content_genres cg ON c.id = cg.content_id "
                        + "LEFT JOIN genres g ON cg.genres_id = g.id "
                        + "WHERE c.id = ? AND s.content_id IS NOT NULL "
                        + "GROUP BY c.id";

                try (PreparedStatement pstmtSeries = con.prepareStatement(seriesQuery)) {
                    pstmtSeries.setInt(1, contentId);
                    ResultSet rsSeries = pstmtSeries.executeQuery();

                    if (rsSeries.next()) {
                        // Extract series information
                        int id = rsSeries.getInt("id");
                        String title = rsSeries.getString("title");
                        String synopsis = rsSeries.getString("synopsis");
                        Date releaseDate = rsSeries.getDate("release_date");
                        int totalEpisode = rsSeries.getInt("total_episode");
                        int totalDuration = rsSeries.getInt("total_duration");
                        int season = rsSeries.getInt("season");

                        // Handle genres
                        String genreString = rsSeries.getString("genres");
                        List<String> genres = new ArrayList<>();
                        if (genreString != null && !genreString.trim().isEmpty()) {
                            genres = Arrays.asList(genreString.split(","));
                        }

                        // Handle actors
                        String actorString = rsSeries.getString("actors");
                        List<String> actors = new ArrayList<>();
                        if (actorString != null && !actorString.trim().isEmpty()) {
                            actors = Arrays.asList(actorString.split(","));
                        }

                        // Create series object
                        Series seriesObj = new Series(totalEpisode, totalDuration, season, id, title, releaseDate, synopsis, actors, genres);

                        // Set image URL if available
                        String imageUrl = rsSeries.getString("image_url");
                        if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                            seriesObj.setImageUrl(imageUrl);
                        }

                        content = seriesObj;
                    }
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Error getting content by ID: " + e.getMessage(), e);
        }

        return content;
    }
}

