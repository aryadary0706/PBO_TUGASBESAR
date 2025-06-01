/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package model;

/**
 *
 * @author user
 */
public interface ContentPage {

    void showPage();
    void showTopRated();
    void showMostReviewed();
    void showByGenre();
    void addReviewtoList(Review review);

}
