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
    //Tambahan buat gambar
    protected String imageUrl; // atau imagePath

    public Content(int id, String title, Date releaseDate, String sinopsis, List<String> aktor, List<String> genre, String imageUrl) {
        this.id = id;
        this.imageUrl = imageUrl;
        this.title = title;
        this.releaseDate = releaseDate;
        this.genres = genre;
        this.actors = aktor;
        this.synopsis = sinopsis;
        this.reviews = new ArrayList<>();
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

    public List<Review> getReviews() {
        return reviews;
    }

    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }
}
