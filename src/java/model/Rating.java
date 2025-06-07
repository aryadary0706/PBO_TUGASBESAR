/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author user
 */
public class Rating {
    private int storyRate;
    private int actingRate;
    private int visualRate;
    private int directingRate;
    private float expectationScore;
    private float averageRate;

    public Rating(int storyRate, int actingRate, int visualRate, int directingRate, float expectationScore) {
        validateIntInput(storyRate, "Story Rate");
        validateIntInput(actingRate, "Acting Rate");
        validateIntInput(visualRate, "Visual Rate");
        validateIntInput(directingRate, "Directing Rate");
        
        this.storyRate = storyRate;
        this.actingRate = actingRate;
        this.visualRate = visualRate;
        this.directingRate = directingRate;
        this.expectationScore = expectationScore;
        calculateAverage();
    }
    
    private void validateIntInput(int value, String fieldName) {
        if (value < 0 || value > 10) {
            throw new IllegalArgumentException(fieldName + " harus antara 0 sampai 10.");
        }
    }

    private float calculateAverage() {
        return (storyRate + actingRate + visualRate + directingRate + expectationScore) / 5f;
    }

    public int getStoryRate() {
        return storyRate;
    }

    public void setStoryRate(int storyRate) {
        this.storyRate = storyRate;
    }

    public int getActingRate() {
        return actingRate;
    }

    public void setActingRate(int actingRate) {
        this.actingRate = actingRate;
    }

    public int getVisualRate() {
        return visualRate;
    }

    public void setVisualRate(int visualRate) {
        this.visualRate = visualRate;
    }

    public int getDirectingRate() {
        return directingRate;
    }

    public void setDirectingRate(int directingRate) {
        this.directingRate = directingRate;
    }

    public float getExpectationScore() {
        return expectationScore;
    }

    public void setExpectationScore() {
        this.expectationScore = calculateAverage();
    }

    public float getAverageRate() {
        return averageRate;
    }
    
    public void updateRating(int storyRate, int actingRate, int visualRate, int directingRate, float expectationScore) {
        this.storyRate = storyRate;
        this.actingRate = actingRate;
        this.visualRate = visualRate;
        this.directingRate = directingRate;
        this.expectationScore = expectationScore;
        calculateAverage();
    }
}