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
import java.util.Collections;
import java.util.stream.Collectors;

public class RegisteredUser extends User {

    private String username;
    private String email;
    private String password;
    private List<Content> favorites;
    private List<Content> watchlist;
    private List<Content> contentHistory;

    // Constructor with all parameters
    public RegisteredUser(int id, String username, String email, String password) {
        super(id, "registered"); // Menetapkan role secara default
        validateAndInitialize(username, email, password);
    }

    public RegisteredUser(String username, String email, String password) {
        super(generateUserId(), "registered");
        this.username = username;
        this.email = email;
        this.password = password;
    }

    // Helper method to validate and initialize fields
    private void validateAndInitialize(String username, String email, String password) {
        if (username == null || username.trim().isEmpty()) {
            throw new IllegalArgumentException("Username tidak boleh kosong.");
        }
        if (email == null || !email.contains("@")) {
            throw new IllegalArgumentException("Email tidak valid.");
        }
        if (password == null || password.length() < 6) {
            throw new IllegalArgumentException("Password harus minimal 6 karakter.");
        }

        this.username = username;
        this.email = email;
        this.password = password;
        this.favorites = new ArrayList<>();
        this.watchlist = new ArrayList<>();
        this.contentHistory = new ArrayList<>();
    }

    // Helper method to generate user ID
    private static int generateUserId() {
        return (int) (Math.random() * (99999 - 10001 + 1)) + 10001;
    }

    //    
//    setter-getter atribut non list
//    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
//
//    setter-getter atribut list
//    

    public List<Content> getFavorites() {
        if (getRole().equals("Registered")) {
            return (new ArrayList<>(favorites));
        } else {
            throw new IllegalArgumentException("Harap login terlebih dahulu!");
        }
    }

    public void setFavorites(List<Content> favorites) {
        this.favorites = favorites;
    }

    public List<Content> getWatchList() {
        if (getRole().equals("Registered")) {
            return (new ArrayList<>(watchlist));
        } else {
            throw new IllegalArgumentException("Harap login terlebih dahulu!");
        }
    }

    public void setWatchlist(List<Content> watchlist) {
        this.watchlist = watchlist;
    }


    public List<Content> getContentHistory() {
        return contentHistory;
    }

    public void setContentHistory(List<Content> contentHistory) {
        this.contentHistory = contentHistory;
    }

// Tambah-Hapus method list
    public void addToFavorites(Content c) {
        if (!favorites.contains(c)) {
            favorites.add(c);
        } else {
            throw new IllegalArgumentException(c.getTitle() + " sudah ada di favorites.");
        }
    }

    public void addToWatchList(Content c) {
        if (!watchlist.contains(c)) {
            watchlist.add(c);
            System.out.println(c.getTitle() + " ditambahkan ke watchlist.");
        } else {
            throw new IllegalArgumentException(c.getTitle() + " sudah ada di watchlist.");
        }
    }

    public void addToHistory(Content c) {
        contentHistory.add(c);
    }

    public void removeFromWatchlist(Content c) {
        if (watchlist.remove(c)) {
            System.out.println(c.getTitle() + " dihapus dari watchlist.");
        } else {
            System.out.println(c.getTitle() + " tidak ditemukan di watchlist.");
        }
    }

    public void removeFromFavorites(Content c) {
        if (favorites.remove(c)) {
            System.out.println(c.getTitle() + " dihapus dari watchlist.");
        } else {
            System.out.println(c.getTitle() + " tidak ditemukan di watchlist.");
        }
    }

    public void tampilkanRiwayat() {
        System.out.println("Riwayat Konten:");
        for (Content c : contentHistory) {
            System.out.println("- " + c.getTitle());
        }
    }

    public boolean isFavorite(Content c) {
        return favorites.contains(c);
    }

    public boolean isInWatchlist(Content c) {
        return watchlist.contains(c);
    }

    public void clearFavorites() {
        favorites.clear();
        System.out.println("Favorit dikosongkan.");
    }

    public void clearWatchlist() {
        watchlist.clear();
        System.out.println("Watchlist dikosongkan.");
    }

    public void clearContentHistory() {
        contentHistory.clear();
        System.out.println("Riwayat ditandai kosong.");
    }
    
    
}
