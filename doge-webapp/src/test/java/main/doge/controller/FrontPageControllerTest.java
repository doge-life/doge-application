package main.doge.controller;

import main.doge.service.TodoService;
import main.doge.service.domain.Todo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.web.servlet.ModelAndView;

import java.util.Arrays;
import java.util.List;

import static org.hamcrest.Matchers.is;
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.when;

@RunWith(SpringRunner.class)
@SpringBootTest
public class FrontPageControllerTest {

    @InjectMocks
    private FrontPageController subject;

    @Mock
    private TodoService todoService;

    @Test
    public void getFrontPage_GetsDataFromService() {
        List<Todo> expectedTodos = Arrays.asList(
            new Todo(11, "Good-bye", false),
            new Todo(12, "Chalon", true)
        );
        when(todoService.getTodos()).thenReturn(expectedTodos);

        ModelAndView modelAndView = subject.getFrontPage();

        assertThat(modelAndView.getViewName(), is("doge"));
        assertThat(modelAndView.getModel().get("todos"), is(expectedTodos));
    }
}
