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
            if (content.getGenre().equalsIgnoreCase(genre)) {
                result.add(content);
            }
        }
        return result;
    }

    public List<Content> getTopRated() {
        List<Content> sorted = new ArrayList<>(contents);
        sorted.sort((c1, c2) -> Double.compare(c2.getRating(), c1.getRating()));
        return sorted;
    }

    public List<Content> getMostReviewed() {
        List<Content> sorted = new ArrayList<>(contents);
        sorted.sort((c1, c2) -> Integer.compare(c2.getReviewCount(), c1.getReviewCount()));
        return sorted;
    }

    public List<Content> getContents() {
        return contents;
    }

    public void setContents(List<Content> contents) {
        this.contents = contents;
    }
}
