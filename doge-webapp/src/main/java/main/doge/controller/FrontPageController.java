package main.doge.controller;

import main.doge.service.TodoService;
import main.doge.service.domain.Todo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
public class FrontPageController {

    @Autowired
    private TodoService todoService;

    @RequestMapping("/")
    public ModelAndView getFrontPage() {
        List<Todo> todos = todoService.getTodos();
        return new ModelAndView("front", "todos", todos);
    }
}
