/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author user
 */
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class GuestUser extends User {

    public GuestUser(int idUser, String role) {
        super(idUser, role);
    }

    //
    //Ini gua tambahin karena konstruktor GuestUser ada yg ga pake parameter di Servlet
    //
    public GuestUser() {
        super(0, "Guest");
    }

    public RegisteredUser loginWithUsername(String username, String password) throws Exception {
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            throw new IllegalArgumentException("Username and password must not be empty.");
        }
        
        // Trim whitespace from inputs
        username = username.trim();
        password = password.trim();
        
        // Basic input validation
        if (username.length() < 3) {
            throw new IllegalArgumentException("Username must be at least 3 characters long.");
        }
        
        if (password.length() < 6) {
            throw new IllegalArgumentException("Password must be at least 6 characters long.");
        }
        
        // Here you would typically:
        // 1. Hash the password before comparing (using BCrypt or similar)
        // 2. Check against a database
        // For demo purposes, we'll keep the simple check but with better structure
        
        // Simulate database check (replace with actual database logic)
        if (authenticateUser(username, password)) {
            RegisteredUser registeredUser = new RegisteredUser(
                username, 
                username + "@example.com", // In real implementation, fetch from DB
                password
            );
            System.out.println("Login successful for user: " + username);
            return registeredUser;
        } else {
            throw new Exception("Invalid username or password. Please try again.");
        }
    }

    public RegisteredUser loginWithEmail(String email, String password) throws Exception {
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            throw new IllegalArgumentException("Email and password must not be empty.");
        }
        
        // Trim whitespace from inputs
        email = email.trim();
        password = password.trim();
        
        // Validate email format
        if (!isValidEmail(email)) {
            throw new IllegalArgumentException("Invalid email format.");
        }
        
        if (password.length() < 6) {
            throw new IllegalArgumentException("Password must be at least 6 characters long.");
        }
        
        // Simulate database check (replace with actual database logic)
        if (authenticateEmail(email, password)) {
            RegisteredUser registeredUser = new RegisteredUser(
                email.split("@")[0], // temporary username from email
                email,
                password
            );
            System.out.println("Login successful for email: " + email);
            return registeredUser;
        } else {
            throw new Exception("Invalid email or password. Please try again.");
        }
    }

    public RegisteredUser register(String username, String email, String password) throws Exception {
        if (username == null || username.isEmpty() || email == null || email.isEmpty() || password == null || password.isEmpty()) {
            throw new IllegalArgumentException("Username, email, and password must not be empty.");
        }

        // Trim whitespace from inputs
        username = username.trim();
        email = email.trim();
        password = password.trim();

        // Enhanced validation
        if (username.length() < 3) {
            throw new IllegalArgumentException("Username must be at least 3 characters long.");
        }
        
        if (!isValidEmail(email)) {
            throw new IllegalArgumentException("Invalid email format.");
        }

        if (password.length() < 6) {
            throw new IllegalArgumentException("Password must be at least 6 characters long.");
        }

        // Check for password strength
        if (!isStrongPassword(password)) {
            throw new IllegalArgumentException("Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character.");
        }

        // Check for reserved/existing usernames
        if (isReservedUsername(username)) {
            throw new Exception("This username is not allowed or already taken.");
        }

        // Check for existing email
        if (isEmailTaken(email)) {
            throw new Exception("This email is already registered.");
        }

        // Create new user (in real implementation, save to database)
        RegisteredUser registeredUser = new RegisteredUser(username, email, password);
        System.out.println("Registration successful for user: " + username);
        return registeredUser;
    }

    // Helper methods for validation
    private boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        return email.matches(emailRegex);
    }

    private boolean isStrongPassword(String password) {
        // Check for at least one uppercase, one lowercase, one number, and one special character
        String passwordRegex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{6,}$";
        return password.matches(passwordRegex);
    }

    private boolean isReservedUsername(String username) {
        // Add more reserved usernames as needed
        List<String> reservedUsernames = List.of("admin", "guest", "system", "root");
        return reservedUsernames.contains(username.toLowerCase());
    }

    private boolean isEmailTaken(String email) {
        // Simulate database check (replace with actual database logic)
        List<String> takenEmails = List.of("guest@example.com", "admin@example.com");
        return takenEmails.contains(email.toLowerCase());
    }

    private boolean authenticateUser(String username, String password) {
        // Simulate database authentication (replace with actual database logic)
        return !"guest".equals(username) && password.length() >= 6;
    }

    private boolean authenticateEmail(String email, String password) {
        // Simulate database authentication (replace with actual database logic)
        return !"guest@example.com".equals(email) && password.length() >= 6;
    }

}
