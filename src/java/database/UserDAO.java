package database;

import java.sql.*;
import model.RegisteredUser;

public class UserDAO {

    public RegisteredUser login(String username, String password) throws SQLException {
        String q = "SELECT * FROM users WHERE username=? AND password=?";
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(q)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new RegisteredUser(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("password")
                );
            }
        }
        return null;
    }

    public RegisteredUser register(String username, String email, String password) throws Exception {
        if (isUsernameExist(username)) {
            throw new Exception("Username sudah dipakai.");
        }
        if (isEmailExist(email)) {
            throw new Exception("Email sudah dipakai.");
        }
        String q = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(q, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, password);
            int ok = ps.executeUpdate();
            if (ok == 0) {
                throw new SQLException("Gagal mendaftar!");
            }
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    return new RegisteredUser(keys.getInt(1), username, email, password);
                }
            }
        }
        throw new SQLException("Gagal mendapatkan ID user!");
    }

    public boolean isUsernameExist(String username) throws SQLException {
        String q = "SELECT id FROM users WHERE username=?";
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(q)) {
            ps.setString(1, username);
            return ps.executeQuery().next();
        }
    }

    public boolean isEmailExist(String email) throws SQLException {
        String q = "SELECT id FROM registereduser WHERE email=?";
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(q)) {
            ps.setString(1, email);
            return ps.executeQuery().next();
        }
    }
}