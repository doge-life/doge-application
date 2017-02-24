package main.doge.service;

import main.doge.service.domain.Todo;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.web.client.RestTemplate;

import java.util.List;

import static org.hamcrest.Matchers.containsInAnyOrder;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

@RunWith(SpringRunner.class)
@SpringBootTest
public class TodoServiceTest {

    @Test
    public void getAllTodos() {
        RestTemplate template = mock(RestTemplate.class);
        String expectedUri = "this-is-a-uri:4567";
        TodoService subject = new TodoService(template, expectedUri);

        Todo[] expectedTodos = new Todo[] {
            new Todo(1, "Hello", false),
            new Todo(2, "World", true)
        };
        when(template.getForObject(expectedUri + "/todos", Todo[].class)).thenReturn(expectedTodos);

        List<Todo> actualTodos = subject.getTodos();

        Assert.assertThat(actualTodos, containsInAnyOrder(expectedTodos));
    }

}