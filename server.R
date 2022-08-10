shinyServer(function(input, output) {

    ## ---- PLOT 1
    output$plot1_category <- renderPlotly({
        
        vids_count <- vids_clean %>% 
            group_by(category_id) %>% 
            summarise(count= n()) %>% 
            ungroup() %>% 
            arrange(-count)
        
        vids_count2 <- vids_count %>% 
            mutate(
                label = glue(
                    "Category: {category_id}
                    Video count: {count}"
                )
            )
        
        plot1 <- ggplot(data = vids_count2, aes(x = count, 
                                                y = reorder(category_id, count),# reorder(A, berdasarkan B)
                                                text = label)) + # untuk informasi tooltip
            geom_col(aes(fill = count)) +
            scale_fill_gradient(low="red", high="black") +
            labs(title = "Trending Categories of YouTube US 2017",
                 x = "Video Count",
                 y = NULL) +
            theme_minimal() +
            theme(legend.position = "none") 
        
        ggplotly(plot1, tooltip = "text")
        
    })
    
    ## ---- PLOT 2
    output$plot2_channel <- renderPlotly({
        
        vids_10 <- vids_clean %>% 
            filter(category_id == input$input_category) %>% 
            group_by(channel_title) %>% 
            summarise(mean_viewers = mean(views)) %>% 
            ungroup() %>% 
            arrange(-mean_viewers) %>% 
            head(10)
        
        vids_10 <- vids_10 %>% 
            mutate(
                label = glue(
                    "Channel: {channel_title}
                    Average Views: {comma(round(mean_viewers, 2))}"
                ) 
            )
        
        plot2 <- ggplot(vids_10, aes(x = reorder(channel_title, mean_viewers), 
                                     y = mean_viewers,
                                     text = label)) +
            geom_segment(aes(x=reorder(channel_title, mean_viewers), xend=reorder(channel_title, mean_viewers), y=0,yend=mean_viewers), color="red") +
            geom_point(color="black") +
            coord_flip() +
            labs(title = glue("Top 10 Channel on {input$input_category}"),
                 x = NULL,
                 y = "Average View") +
            scale_y_continuous(labels = comma) +
            theme_minimal()
        
        ggplotly(plot2, tooltip = "text")
        
    })
    
    ## ---- PLOT 3
    output$plot3_activity <- renderPlotly({
        
        vids_trend <- vids_clean %>% 
            filter(category_id == input$input_category) %>% 
            group_by(publish_hour) %>% 
            summarise(avg_views = mean(views)) %>% 
            ungroup() %>% 
            mutate(label2 = glue(
                "Publish Hour: {publish_hour}
                Average Views: {comma(round(avg_views, 2))}"
            ))
        
        plot3 <- ggplot(vids_trend, aes(x=publish_hour, y= avg_views))+
            geom_line(col="red") +
            geom_point(aes(text=label2), col="black") +
            labs(
                title = glue("Viewers Activity of {input$input_category} Videos"),
                x = "Publish Hours",
                y = "Average Views"
            ) +
            scale_y_continuous(labels = comma) +
            scale_x_continuous(breaks = seq(0,23,1)) +
            theme_minimal()
        
        ggplotly(plot3, tooltip = "text")
        
    })
    
    
    ## ---- DATASET
    output$dataset_table <- DT::renderDataTable(vids_clean,
                                                options = list(scrollX=T,
                                                               scrollY=T))
    

})
