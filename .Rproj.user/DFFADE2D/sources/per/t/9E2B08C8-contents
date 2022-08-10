library(shiny)
library(shinydashboard)

# load library
library(tidyverse)
library(scales)
library(glue)
library(plotly)
library(lubridate)

# Read data
vids <- read.csv("data_input/youtubetrends.csv", stringsAsFactors = T)

# Cleansing data
vids_clean <- vids %>% 
  # deselect kolom
  select(-c(comments_disabled, ratings_disabled, video_error_or_removed)) %>% 
  mutate(
    # mengubah tipe data
    trending_date = ymd(trending_date),
    publish_time = ymd_hms(publish_time),
    title = as.character(title),
    channel_title = as.character(channel_title),
    
    # menambahkan kolom baru
    likesp = likes/views,
    dislikep = dislikes/views,
    commentp = comment_count/views
  )