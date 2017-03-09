package main.doge.service;

import main.doge.service.domain.Todo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class TodoService {

    private final RestTemplate restTemplate;
    private final String uri;

    @Autowired
    public TodoService(RestTemplate restTemplate, @Value("${doge.service.uri}") String uri) {
        this.restTemplate = restTemplate;
        this.uri = uri;
    }

    public List<Todo> getTodos() {
        return Arrays.stream(callService(uri + "/todos", Todo[].class)).collect(Collectors.toList());
    }

    public Todo getSingleTodo(int todoId) {
        return callService(uri + "/todo/" + Integer.toString(todoId), Todo.class);
    }

    private <T> T callService(String uri, Class<T> type) {
        return restTemplate.getForObject(uri, type);
    }
}
