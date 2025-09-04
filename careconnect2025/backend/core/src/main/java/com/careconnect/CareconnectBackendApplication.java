package com.careconnect;


import org.springframework.boot.SpringApplication;
import org.springframework.boot.WebApplicationType;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.websocket.servlet.WebSocketServletAutoConfiguration;
import org.springframework.scheduling.annotation.EnableScheduling;


@SpringBootApplication(exclude = {WebSocketServletAutoConfiguration.class})
@EnableScheduling
public class CareconnectBackendApplication {

	public static void main(String[] args) {
		SpringApplication app = new SpringApplication(CareconnectBackendApplication.class);
		app.setWebApplicationType(WebApplicationType.SERVLET);
		app.run(args);
	}
}
