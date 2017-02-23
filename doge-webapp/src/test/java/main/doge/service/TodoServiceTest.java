package main.doge.service;

import main.doge.service.domain.Todo;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.web.client.RestTemplate;

import java.util.List;

import static org.hamcrest.Matchers.containsInAnyOrder;
import static org.mockito.Mockito.when;

@RunWith(SpringRunner.class)
@SpringBootTest
public class TodoServiceTest {

    @InjectMocks
    private TodoService subject;

    @Mock
    private RestTemplate template;

    @Test
    public void getAllTodos() {
        Todo[] expectedTodos = new Todo[] {
            new Todo(1, "Hello", false),
            new Todo(2, "World", true)
        };
        when(template.getForObject("/todos", Todo[].class)).thenReturn(expectedTodos);

        List<Todo> actualTodos = subject.getTodos();

        Assert.assertThat(actualTodos, containsInAnyOrder(expectedTodos));
    }

}