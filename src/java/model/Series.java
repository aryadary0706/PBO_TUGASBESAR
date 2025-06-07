/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author user
 */
import java.util.Date;
import java.util.List;

public class Series extends Content implements ContentPage {

    private int totalEpisode;
    private int totalDuration;
    private int season;

    public Series(int totalEpisode, int totalDuration, int season, int id, String title, Date releaseDate, String synopsis, List<String> actors, List<String> genres, String imageUrl) {
        super(id, title, releaseDate, synopsis, actors, genres, imageUrl);
        this.totalEpisode = totalEpisode;
        this.totalDuration = totalDuration;
        this.season = season;
    }
    @Override
    public float getAverageRating() {
        if (this.reviews == null || this.reviews.isEmpty()) {
            return 0; // Avoid division by zero and handle null
        }
        float accRating = 0;
        for (Review review : reviews) {
            accRating += review.getRating().getAverageRate();
        }
        return accRating / reviews.size(); // Return the average rating
    }

    public int getTotalEpisode() {
        return totalEpisode;
    }

    public void setTotalEpisode(int totalEpisode) {
        this.totalEpisode = totalEpisode;
    }

    public int getTotalDuration() {
        return totalDuration;
    }

    public void setTotalDuration(int totalDuration) {
        this.totalDuration = totalDuration;
    }

    public int getSeason() {
        return season;
    }

    public void setSeason(int season) {
        this.season = season;
    }

    @Override
    public void showPage() {
        System.out.println("Menampilkan halaman untuk series: " + title);
    }

    @Override
    public void showTopRated() {
        System.out.println("Series dengan rating tertinggi: " + title + " (" + getAverageRating() + ")");
    }

    @Override
    public void showMostReviewed() {
        System.out.println("Jumlah review untuk series: " + (reviews != null ? reviews.size() : 0));
    }

    @Override
    public void showByGenre() {
        System.out.println("Genre series ini: " + String.join(", ", genres));
    }

    @Override
    public void addReviewtoList(Review review) {
        if (review == null) {
            throw new IllegalArgumentException("Review tidak boleh null");
        }
        getReviews().add(review);
    }
}
