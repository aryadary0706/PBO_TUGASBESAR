package database;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author user
 */
import java.sql.*;

public class UserJDBC {
    private String message;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/test";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "";

    public String getMessage() {
        return message;
    }

    /**
     * Menjalankan query INSERT/UPDATE/DELETE
     */
    public boolean executeUpdate(String query, Object... params) {
        try (
            Connection con = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            PreparedStatement pstmt = con.prepareStatement(query)
        ) {
            setParameters(pstmt, params);
            int rowsAffected = pstmt.executeUpdate();
            message = rowsAffected + " row(s) affected.";
            return true;
        } catch (SQLException e) {
            message = "SQL Error: " + e.getMessage();
            return false;
        }
    }

    /**
     * Menjalankan SELECT dan mengembalikan ResultSet.
     * Caller bertanggung jawab menutup ResultSet dan Connection jika digunakan langsung.
     */
    public ResultSet executeQuery(String query, Object... params) {
        try {
            Connection con = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            PreparedStatement pstmt = con.prepareStatement(query);
            setParameters(pstmt, params);
            return pstmt.executeQuery();
        } catch (SQLException e) {
            message = "SQL Error: " + e.getMessage();
            return null;
        }
    }

    /**
     * Helper untuk mengisi parameter PreparedStatement
     */
    private void setParameters(PreparedStatement pstmt, Object... params) throws SQLException {
        for (int i = 0; i < params.length; i++) {
            pstmt.setObject(i + 1, params[i]);
        }
    }

    /**
     * Contoh method: Menambahkan user baru
     */
    public boolean insertUser(String username, String email, String password) {
        String query = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
        return executeUpdate(query, username, email, password);
    }

    /**
     * Contoh method: Validasi login
     */
    public boolean validateLogin(String username, String password) {
        String query = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (
            Connection con = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            PreparedStatement pstmt = con.prepareStatement(query)
        ) {
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            return rs.next(); // true jika ditemukan
        } catch (SQLException e) {
            message = "Login Error: " + e.getMessage();
            return false;
        }
    }

    /**
     * Contoh method: Ambil user berdasarkan username
     */
    public String getUserEmailByUsername(String username) {
        String query = "SELECT email FROM users WHERE username = ?";
        try (
            Connection con = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            PreparedStatement pstmt = con.prepareStatement(query)
        ) {
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString("email");
            } else {
                return null;
            }
        } catch (SQLException e) {
            message = "Get User Error: " + e.getMessage();
            return null;
        }
    }
}

