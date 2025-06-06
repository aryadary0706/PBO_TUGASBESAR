public class Series {
    private int id;
    private String title;
    private String description;
    private String thumbnailUrl;
    private float averageRating;

    public Series(int id, String title, String description, String thumbnailUrl, float averageRating) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.thumbnailUrl = thumbnailUrl;
        this.averageRating = averageRating;
    }

    public String contentPage() {
        return "seriesDetail.jsp?seriesId=" + id;
    }

    // Getter dan Setter
}
