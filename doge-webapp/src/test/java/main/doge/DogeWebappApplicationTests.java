package main.doge;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.web.context.WebApplicationContext;

import javax.annotation.Resource;

@RunWith(SpringRunner.class)
@SpringBootTest
public class DogeWebappApplicationTests {

    @Autowired
    private WebApplicationContext webApplicationContext;

    @Test
    public void contextLoads() {
        Assert.assertNotNull(webApplicationContext);
    }

}
