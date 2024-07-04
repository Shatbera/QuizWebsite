package servlets;

import config.QuizzesDatabase;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class QuizzesListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent event) {
        event.getServletContext().setAttribute("quizzesDatabase", new QuizzesDatabase());
    }
}
