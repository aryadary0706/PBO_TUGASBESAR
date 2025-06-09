/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author user
 */
import java.util.*;
import java.util.ArrayList;

public abstract class Content {

    protected int id;
    protected String title;
    protected String synopsis;
    protected List<String> genres;
    protected List<String> actors;
    protected Date releaseDate;
    protected List<Review> reviews;
    protected String imageUrl;
    protected double Rating;

    public Content(int id, String title, Date releaseDate, String sinopsis, List<String> aktor, List<String> genre, String imageUrl) {
        this.id = id;
        this.imageUrl = imageUrl;
        this.title = title;
        this.releaseDate = releaseDate;
        this.genres = genre;
        this.actors = aktor;
        this.synopsis = sinopsis;
        this.reviews = null;
        this.imageUrl = imageUrl;
        this.Rating = 0.0;
    }

    public Content(int id, String title, Date releaseDate, String synopsis, List<String> actors, List<String> genres) {
        this.id = id;
        this.title = title;
        this.synopsis = synopsis;
        this.genres = genres;
        this.actors = actors;
        this.releaseDate = releaseDate;
        this.reviews = new ArrayList<>();
        this.Rating = 0.0;
    }

    public Content(int id, String title, String synopsis, List<String> genres, List<String> actors, Date releaseDate, List<Review> reviews, String imageUrl, double Rating) {
        this.id = id;
        this.title = title;
        this.synopsis = synopsis;
        this.genres = genres;
        this.actors = actors;
        this.releaseDate = releaseDate;
        this.reviews = reviews;
        this.imageUrl = imageUrl;
        this.Rating = Rating;
    }
    
    

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSynopsis() {
        return synopsis;
    }

    public void setSynopsis(String synopsis) {
        this.synopsis = synopsis;
    }

    public List<String> getGenres() {
        return genres;
    }

    public void setGenres(List<String> genres) {
        this.genres = genres;
    }

    public List<String> getActors() {
        return actors;
    }

    public void setActors(List<String> actors) {
        this.actors = actors;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    // Hapus method setAverageRating
    public double getAverageRating() {
        if (reviews == null || reviews.isEmpty()) {
            return 0.0;
        }

        double total = 0.0;
        int count = 0;

        for (Review review : reviews) {
            if (review.getRating() != null) {
                total += review.getRating().getAverageRate();
                count++;
            }
        }

        return (count == 0) ? 0.0 : total / count;
    }

    public void setAverageRating(double averageRating) {
        this.Rating = getAverageRating();
    }

    public List<Review> getReviews() {
        return reviews;
    }

    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }

}
