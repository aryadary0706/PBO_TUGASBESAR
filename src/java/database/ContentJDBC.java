/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Database;

import java.sql.*;
import model.Content;
import model.movie;
import model.Series;
import java.util.*;
import java.sql.Date;


/**
 *
 * @author User
 */
public class ContentJDBC {

    private Connection con;
    private Statement stmt;
    private boolean isConnected;
    private String message;

    public void connect() {
        String dbname = "db_tubes";
        String username = "root";
        String password = "";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"
                    + dbname, username, password);
            stmt = con.createStatement();
            isConnected = true;
            message = "DB connected";
        } catch (ClassNotFoundException | SQLException e) {
            isConnected = false;
            message = e.getMessage();
        }
    }

    private void disconnect() {
        try {
            stmt.close();
            con.close();
        } catch (SQLException e) {
            message = e.getMessage();
        }
    }

    public void runQuery(String query) {
        try {
            connect();
            int result = stmt.executeUpdate(query);
            message = "info: " + result + " rows affected";
        } catch (SQLException e) {
            message = e.getMessage();
        } finally {
            disconnect();
        }
    }

    public ResultSet getData(String query) {
        ResultSet rs = null;
        try {
            connect();
            rs = stmt.executeQuery(query);
        } catch (SQLException e) {
            message = e.getMessage();
        }
        return rs;
    }

    public List<Content> getAllContents() {
        List<Content> contents = new ArrayList<>();
        contents.addAll(getAllMovies());
        contents.addAll(getAllSeries());
        return contents;
    }

    public List<movie> getAllMovies() {
        List<movie> movies = new ArrayList<>();
        String query = "SELECT * FROM content LEFT JOIN movie ON content.id = movie.id";

        try {
            connect();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                try {
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
                } catch (Exception e) {
                    message = "Error processing movie: " + e.getMessage();
                }
            }
        } catch (SQLException e) {
            message = "Database error while fetching movies: " + e.getMessage();
        } finally {
            disconnect();
        }

        return movies;
    }

    public List<Series> getAllSeries() {
        List<Series> seriesList = new ArrayList<>();
        String query = "SELECT * FROM content LEFT JOIN series ON content.id = series.id";

        try {
            connect();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                try {
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
                } catch (Exception e) {
                    message = "Error processing series: " + e.getMessage();
                }
            }
        } catch (SQLException e) {
            message = "Database error while fetching series: " + e.getMessage();
        } finally {
            disconnect();
        }

        return seriesList;
    }

    public Content getContentById(int contentId) {
        Content content = null;
        String query = "SELECT * FROM contents WHERE id = " + contentId;

        try {
            connect();
            ResultSet rs = getData(query);

            if (rs.next()) {
                String type = rs.getString("type");
                
                if ("movie".equalsIgnoreCase(type)) {
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
                    
                } else if ("series".equalsIgnoreCase(type)) {
                    // Extract series information
                    int id = rs.getInt("id");
                    String title = rs.getString("title");
                    String synopsis = rs.getString("synopsis");
                    Date releaseDate = rs.getDate("release_date");
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

                    // Create series object
                    Series seriesObj = new Series(totalEpisode, totalDuration, season, id, title, releaseDate, synopsis, actors, genres);
                    
                    // Set image URL if available
                    String imageUrl = rs.getString("image_url");
                    if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                        seriesObj.setImageUrl(imageUrl);
                    }
                    
                    content = seriesObj;
                }
            }
        } catch (SQLException e) {
            message = "Error getting content by ID: " + e.getMessage();
        } finally {
            disconnect();
        }

        return content;
    }

    public String getMessage() {
        return message;
    }
}
