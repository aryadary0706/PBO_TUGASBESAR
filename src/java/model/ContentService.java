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

public class ContentService {
    private List<Content> contents;
    private List<Content> Reccomendations;

    public ContentService(List<Content> contents) {
        this.contents = contents;
    }

    public List<Content> searchContent(String keyword) {
        List<Content> result = new ArrayList<>();
        for (Content content : contents) {
            if (content.getTitle().toLowerCase().contains(keyword.toLowerCase())) {
                result.add(content);
            }
        }
        return result;
    }

    public List<Content> filterByGenre(String genre) {
        List<Content> result = new ArrayList<>();
        for (Content content : contents) {
            if (content.getGenres().contains(genre)) {
                result.add(content);
            }
        }
        return result;
    }

    public List<Content> getTopRated() {
        List<Content> sorted = new ArrayList<>(contents);
        sorted.sort((c1, c2) -> Double.compare(c2.getAverageRating(), c1.getAverageRating()));
        return sorted;
    }

    public List<Content> getMostReviewed() {
        List<Content> sorted = new ArrayList<>(contents);
        sorted.sort((c1, c2) -> Integer.compare(c2.getReviews().size(), c1.getReviews().size()));
        return sorted;
    }

    public List<Content> getContents() {
        return contents;
    }

    public void setContents(List<Content> contents) {
        this.contents = contents;
    }
    
    public void addToRecommendations(Content currentContent, List<Content> allContents) {
        if (currentContent == null || currentContent.getGenres() == null || currentContent.getGenres().isEmpty()) {
            System.out.println("Konten tidak valid atau tidak memiliki genre.");
            return;
        }

        if (allContents == null || allContents.isEmpty()) {
            System.out.println("Daftar semua konten kosong. Tidak bisa memberikan rekomendasi.");
            return;
        }

        Set<Content> newRecommendations = new HashSet<>();

        for (Content other : allContents) {
            if (other.equals(currentContent)) {
                continue; // Hindari merekomendasikan konten yang sama
            }
            for (String genre : currentContent.getGenres()) {
                if (other.getGenres().contains(genre)) {
                    newRecommendations.add(other);
                    break; // Ambil konten hanya sekali meskipun cocok lebih dari satu genre
                }
            }
        }

        int count = 0;
        for (Content rec : newRecommendations) {
            if (!Reccomendations.contains(rec)) {
                Reccomendations.add(rec);
                System.out.println("Rekomendasi ditambahkan: " + rec.getTitle());
                count++;
                if (count >= 5) {
                    break; // batasi jumlah rekomendasi
                }
            }
        }

        if (count == 0) {
            System.out.println("Tidak ada rekomendasi baru yang tersedia.");
        }
    }
}
