package config;

import models.quizzes.FriendQuizAttempt;
import models.quizzes.QuizReview;
import models.user.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.anyString;
import static org.mockito.Mockito.when;

public class UsersTests {

    @Mock
    private Statement statement;

    @Mock
    private ResultSet resultSet;

    @InjectMocks
    private DatabaseManager dbManager;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testCheckUserCredentials_ValidUser() throws SQLException {
        String username = "testUser";
        String hashedPassword = "hashedPassword";

        when(statement.executeQuery(anyString())).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(true);
        when(resultSet.getInt("id")).thenReturn(1);

        Optional<Integer> userId = dbManager.checkUserCredentials(username, hashedPassword);

        assertTrue(userId.isPresent());
        assertEquals(1, userId.get());
    }

    @Test
    public void testCheckUserCredentials_InvalidUser() throws SQLException {
        String username = "testUser";
        String hashedPassword = "hashedPassword";

        when(statement.executeQuery(anyString())).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(false);

        Optional<Integer> userId = dbManager.checkUserCredentials(username, hashedPassword);

        assertFalse(userId.isPresent());
    }

    @Test
    public void testSaveUser_Success() throws SQLException {
        String username = "testUser";
        String email = "test@example.com";
        String hashedPassword = "hashedPassword";

        when(statement.executeUpdate(anyString())).thenReturn(1);

        boolean result = dbManager.saveUser(username, email, hashedPassword);

        assertTrue(result);
    }

    @Test
    public void testSaveUser_Failure() throws SQLException {
        String username = "testUser";
        String email = "test@example.com";
        String hashedPassword = "hashedPassword";

        when(statement.executeUpdate(anyString())).thenReturn(0);

        boolean result = dbManager.saveUser(username, email, hashedPassword);

        assertFalse(result);
    }

    @Test
    public void testGetUserId_Exists() throws SQLException {
        String username = "testUser";

        when(statement.executeQuery(anyString())).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(true);
        when(resultSet.getInt("id")).thenReturn(1);

        Integer userId = dbManager.getUserId(username);

        assertNotNull(userId);
        assertEquals(1, userId);
    }

    @Test
    public void testGetUserId_NotExists() throws SQLException {
        String username = "testUser";

        when(statement.executeQuery(anyString())).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(false);

        Integer userId = dbManager.getUserId(username);

        assertNull(userId);
    }

    @Test
    public void testSearchUsers() throws SQLException {
        String prompt = "test";
        String currentUser = "currentUser";

        when(statement.executeQuery(anyString())).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(true, true, false);
        when(resultSet.getInt("id")).thenReturn(1, 2);
        when(resultSet.getString("username")).thenReturn("user1", "user2");
        when(resultSet.getString("email")).thenReturn("user1@example.com", "user2@example.com");

        ArrayList<User> users = dbManager.searchUsers(prompt, currentUser);

        assertEquals(2, users.size());
        assertEquals("user1", users.get(0).getUsername());
        assertEquals("user2", users.get(1).getUsername());
    }

    @Test
    public void testFetchFriendsQuizAttempts() throws SQLException {
        int quizId = 1;
        int id = 1;

        when(statement.executeQuery(anyString())).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(true, true, false);
        when(resultSet.getInt("userId")).thenReturn(1, 2);
        when(resultSet.getString("username")).thenReturn("user1", "user2");
        when(resultSet.getString("email")).thenReturn("user1@example.com", "user2@example.com");
        when(resultSet.getInt("score")).thenReturn(90, 85);
        when(resultSet.getInt("time_taken")).thenReturn(120, 110);
        when(resultSet.getTimestamp("attempt_time")).thenReturn(new Timestamp(System.currentTimeMillis()));

        List<FriendQuizAttempt> friendQuizAttempts = dbManager.fetchFriendsQuizAttempts(quizId, id);

        assertEquals(2, friendQuizAttempts.size());
        assertEquals("user1", friendQuizAttempts.get(0).getUsername());
        assertEquals("user2", friendQuizAttempts.get(1).getUsername());
    }

    @Test
    public void testSaveRating_Success() throws SQLException {
        int id = 1;
        int userId = 1;
        int rating = 5;
        String review = "Great quiz!";

        when(statement.executeUpdate(anyString())).thenReturn(1);

        boolean result = dbManager.saveRating(id, userId, rating, review);

        assertTrue(result);
    }

    @Test
    public void testSaveRating_Failure() throws SQLException {
        int id = 1;
        int userId = 1;
        int rating = 5;
        String review = "Great quiz!";

        when(statement.executeUpdate(anyString())).thenReturn(0);

        boolean result = dbManager.saveRating(id, userId, rating, review);

        assertFalse(result);
    }

    @Test
    public void testGetQuizReviews() throws SQLException {
        int quizId = 1;

        when(statement.executeQuery(anyString())).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(true, true, false);
        when(resultSet.getString("review")).thenReturn("Great quiz!", "Good quiz.");
        when(resultSet.getInt("stars")).thenReturn(5, 4);
        when(resultSet.getString("username")).thenReturn("user1", "user2");

        ArrayList<QuizReview> quizReviews = dbManager.getQuizReviews(quizId);

        assertEquals(2, quizReviews.size());
        assertEquals("Great quiz!", quizReviews.get(0).review);
        assertEquals(5, quizReviews.get(0).stars);
        assertEquals("user1", quizReviews.get(0).userName);
    }
}