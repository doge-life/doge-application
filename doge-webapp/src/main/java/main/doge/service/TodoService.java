package main.doge.service;

import main.doge.service.domain.Todo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.List;

@Service
public class TodoService {

    @Autowired
    private RestTemplate restTemplate;

    public List<Todo> getTodos() {
        Todo[] todosFromService = restTemplate.getForObject("/todos", Todo[].class);
        return Arrays.asList(todosFromService);
    }
}
