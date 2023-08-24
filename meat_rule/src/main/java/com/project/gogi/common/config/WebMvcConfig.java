package com.project.gogi.common.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

import com.project.gogi.common.Interceptor.ViewNameInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer{
	
	 
	 @Override
	 public void addInterceptors(InterceptorRegistry registry) {
		 
	        registry.addInterceptor(new ViewNameInterceptor());
	    }
	 @Bean
		public TilesConfigurer tilesConfigurer() {
			final TilesConfigurer configurer = new TilesConfigurer();
			configurer.setDefinitions(new String[] {
					"/WEB-INF/spring/tiles/tiles-define.xml"
			});
			configurer.setCheckRefresh(true);
			return configurer;
		}
		
		@Bean
		public TilesViewResolver tilesViewResolver() {
			final TilesViewResolver tilesViewResolver = new TilesViewResolver();
			tilesViewResolver.setViewClass(TilesView.class);
			tilesViewResolver.setOrder(1);
			return tilesViewResolver;
		}
		
		 
}
