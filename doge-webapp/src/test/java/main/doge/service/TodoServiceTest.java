package main.doge.service;

import main.doge.service.domain.Todo;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.web.client.RestTemplate;

import java.util.List;

import static org.hamcrest.Matchers.containsInAnyOrder;
import static org.hamcrest.Matchers.is;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

@RunWith(SpringRunner.class)
@SpringBootTest
public class TodoServiceTest {

    private static final String EXPECTED_URI = "http://this-is-a-uri:4567";
    private RestTemplate template;
    private TodoService subject;

    @Before
    public void setUp() {
        template = mock(RestTemplate.class);
        subject = new TodoService(template, EXPECTED_URI);
    }

    @Test
    public void getAllTodos() {
        Todo[] expectedTodos = new Todo[] {
            new Todo(1, "Hello", false),
            new Todo(2, "World", true),
            new Todo(2, "World", true)
        };
        when(template.getForObject(EXPECTED_URI + "/todos", Todo[].class)).thenReturn(expectedTodos);

        List<Todo> actualTodos = subject.getTodos();

        Assert.assertThat(actualTodos, is(new Todo[] {}));
    }

    @Test
    public void getSingleTodo() {
        Todo expectedTodo = new Todo(11, "Single Todo", false);
        when(template.getForObject(EXPECTED_URI + "/todo/11", Todo.class))
                .thenReturn(expectedTodo);

        Todo actualTodo = subject.getSingleTodo(11);

        Assert.assertThat(actualTodo, is(expectedTodo));
    }
}
