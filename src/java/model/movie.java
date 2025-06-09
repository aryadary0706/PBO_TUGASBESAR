package model;

import java.util.Date;
import java.util.List;


// Implementasi interface ContentPage langsung di Movie
public class movie extends Content implements ContentPage {

    private int duration;

    public movie(int duration, int id, String title, Date releaseDate, String sinopsis, List<String> aktor, List<String> genre, String imageUrl) {
        super(id, title, releaseDate, sinopsis, aktor, genre, imageUrl);
        this.duration = duration;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    @Override
    public String toString() {
        return "Movie{" + "title=" + getTitle() + ", duration=" + duration + " mins}";
    }

    public void info() {
        System.out.println("Movie: " + getTitle() + " | Duration: " + duration + " mins");
    }

    @Override
    public List<String> getGenres() {
        return genres;
    }

    // Implementasi ContentPage
    @Override
    public void showPage() {
        System.out.println("Halaman untuk film: " + getTitle());
        System.out.println("Genre: " + String.join(", ", getGenres()));
        System.out.println("Durasi: " + duration + " menit");
        System.out.println("Rating rata-rata: " + getAverageRating());
    }

    @Override
    public void showTopRated() {
        // Asumsinya ini hanya menampilkan movie jika ratingnya di atas threshold
        if (getAverageRating() >= 4.0) {
            System.out.println(getTitle() + " adalah film dengan rating tinggi.");
        }
    }

    @Override
    public void showMostReviewed() {
        System.out.println(getTitle() + " memiliki " + getReviews().size() + " review.");
    }

    @Override
    public void showByGenre() {
        for (String genre : getGenres()) {
            System.out.println("Film ini termasuk genre: " + genre);
        }
    }

    public void everyRating() {
        if (getReviews() == null || getReviews().isEmpty()) {
            System.out.println("Belum ada rating atau review.");
            return;
        }

        for (Review review : getReviews()) {
            System.out.println(review.getNameUser() + " memberi nilai: " + review.getRating().getAverageRate() + " dengan review: " + review.getReviewText());
        }
    }

    @Override
    public void addReviewtoList(Review review) {
        if (review == null) {
            throw new IllegalArgumentException("Review tidak boleh null");
        }
        getReviews().add(review);
    }

}
