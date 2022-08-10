dashboardPage(
    
    skin = "red",
    
    # ------ HEADER
    dashboardHeader(
        title = "Youtube Analysis"
    ),
    
    
    # ------ SIDEBAR
    dashboardSidebar(
        
        sidebarMenu(
            menuItem("Overview", tabName = "page1", icon = icon("video")),
            menuItem("Channel Analysis", tabName = "page2", icon = icon("youtube")),
            menuItem("Dataset", tabName = "page3", icon = icon("server"))
        )
    ),
    
    
    # ------ BODY
    dashboardBody(
        
        tabItems(
            # ----- PAGE 1 -----
            tabItem(tabName = "page1",
                    
                    ## --- ROW 1: INFO BOX
                    fluidRow(
                        infoBox(width = 6,
                                color = "red",
                                title = "Total Video Count",
                                icon = icon("youtube"),
                                value = nrow(vids_clean)),
                        infoBox(width = 6,
                                color = "black",
                                title = "Total Trending Channel",
                                icon = icon("headset"),
                                value = length(unique(vids_clean$channel_title)))
                    ),
                    
                    ## --- ROW 2: PLOT 1
                    fluidRow(
                        box(width = 12,
                            plotlyOutput(outputId = "plot1_category"))
                    )
                
            ),
            
            # ----- PAGE 2 -----
            tabItem(tabName = "page2",
                    
                    ## --- ROW 1: INPUT
                    fluidRow(
                        box(width = 12,
                            selectInput(inputId = "input_category",
                                        label = "Choose Video Category",
                                        selected = "Entertainment",
                                        choices = unique(vids_clean$category_id))
                            )
                    ),
                    
                    ## --- ROW2: PLOT
                    fluidRow(
                        ## PLOT 2: Lolipop plot
                        box(width = 6,
                            plotlyOutput(outputId = "plot2_channel")
                            ),
                        ## PLOT 3: Line plot
                        box(width = 6,
                            plotlyOutput(outputId = "plot3_activity")
                            )
                    )
            ),
            
            # ----- PAGE 3 -----
            tabItem(tabName = "page3",
                    fluidRow(
                        box(width = 12,
                            title = "Data US Youtube Trending 2017",
                            DT::dataTableOutput(outputId = "dataset_table"))
                    )
                
            )
        )
        
    )
)