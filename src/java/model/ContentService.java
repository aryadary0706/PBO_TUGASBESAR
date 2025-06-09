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
    private List<Content> Reccomendations = null;

    public ContentService(List<Content> contents) {
        this.contents = contents;
        this.Reccomendations = new ArrayList<>();
    }

    public List<Content> getReccomendations() {
        return Reccomendations;
    }

    public void setReccomendations(List<Content> Reccomendations) {
        this.Reccomendations = Reccomendations;
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

    public List<Content> getTopRated(List<Content> contentList) {
        List<Content> sorted = new ArrayList<>(contentList);
        sorted.sort((c1, c2) -> Double.compare(c2.getAverageRating(), c1.getAverageRating()));
        return sorted;
    }

    public List<Content> getMostReviewed(List<Content> contentList) {
        List<Content> sorted = new ArrayList<>(contentList);
        sorted.sort((c1, c2) -> Integer.compare(c2.getReviews().size(), c1.getReviews().size()));
        return sorted;
    }

    public List<Content> getContents() {
        return contents;
    }

    public void setContents(List<Content> contents) {
        this.contents = contents;
    }

    public void addToRecommendations(Content currentContent, List<Content> allContents, RegisteredUser user) {
        if (currentContent == null || currentContent.getGenres() == null || currentContent.getGenres().isEmpty()) {
            return;
        }
        if (allContents == null || allContents.isEmpty()) {
            return;
        }

        Set<Content> newRecommendations = new LinkedHashSet<>();

        // Gabungkan watchlist dan favorites
        List<Content> userContent = new ArrayList<>();
        if (user != null) {
            userContent.addAll(user.getWatchList());
            userContent.addAll(user.getFavorites());
        }

        if (userContent.isEmpty()) {
            // Jika tidak ada riwayat, rekomendasikan top rated
            List<Content> topRated = getTopRated(allContents);
            for (Content content : topRated) {
                if (!content.equals(currentContent)) {
                    newRecommendations.add(content);
                    if (newRecommendations.size() >= 5) {
                        break;
                    }
                }
            }
        } else {
            // Ambil genre dari konten milik user
            Set<String> userGenres = new HashSet<>();
            for (Content content : userContent) {
                if (content.getGenres() != null) {
                    userGenres.addAll(content.getGenres());
                }
            }

            // Cari konten dengan genre yang cocok
            for (Content other : allContents) {
                if (other.equals(currentContent)) {
                    continue;
                }
                if (other.getTitle().equals(currentContent.getTitle())) {
                    continue;
                }

                if (other.getGenres() != null) {
                    for (String genre : other.getGenres()) {
                        if (userGenres.contains(genre)) {
                            newRecommendations.add(other);
                            break;
                        }
                    }
                }

                if (newRecommendations.size() >= 5) {
                    break;
                }
            }
        }

        // Tambahkan ke Reccomendations (max 2 item, FIFO)
        for (Content rec : newRecommendations) {
            if (!Reccomendations.contains(rec)) {
                if (Reccomendations.size() >= 2) {
                    Reccomendations.removeFirst(); // Hapus yang paling lama
                }
                Reccomendations.add(rec); // Tambah baru
            }
        }
    }

}
