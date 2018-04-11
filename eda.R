library(tidyverse)
library(ggplot2)
library(scales)
library(reshape2)

fig_path <- file.path("figures")
plot_resolution <- 192

#plot daily enwiki pageviews from US by facebook referer
daily_pageviews_fb <- rbind(readr::read_rds("data/daily_pageviews_fb.rds")) %>%
  mutate(date = lubridate::ymd(date)) 

p <- ggplot(daily_pageviews_fb, aes(x = date, y = requests)) +
  geom_line(size = 1.5) +
  geom_vline(xintercept = as.numeric(as.Date("2018-04-03")),
             linetype = "dashed", color = "blue") +
  geom_text(aes(x=as.Date('2018-04-03'), y=200000, label="Facebook Article Context Feature Launch Date"), size=3, vjust = -1.2, angle = 90, color = "black") +
  scale_y_continuous("pageviews (excludes bots)", labels = polloi::compress) +
  scale_x_date(labels = date_format("%Y-%m-%d"), date_breaks = "2 days")  +
  labs(title = "English Wikipedia Pageviews in the US with a referrer from Facebook") +  
  ggthemes::theme_tufte(base_size = 12, base_family = "Gill Sans") +
  theme(axis.text.x=element_text(angle = 45, hjust = 1),
        panel.grid = element_line("gray70"))
  
ggsave("daily_pageviews_fb.png", p, path = fig_path, units = "in", dpi = plot_resolution, height = 6, width = 10, limitsize = FALSE)
rm(p)

#plot daily enwiki pageviews from US by facebook referer broken down by access method (mobile web, desktop)
daily_pageviews_fb_bymethod <- rbind(readr::read_rds("data/daily_pageviews_fb_bymethod.rds")) %>%
  mutate(date = lubridate::ymd(date)) 

p <- ggplot(daily_pageviews_fb_bymethod, aes(x = date, y = web_requests, color = access_method)) +
  geom_line(size = 1.5) +
  geom_vline(xintercept = as.numeric(as.Date("2018-04-03")),
             linetype = "dashed", color = "blue") +
  geom_text(aes(x=as.Date('2018-04-03'), y=50000, label="Facebook Article Context Feature Launch Date"), size=3, vjust = -1.2, angle = 90, color = "black") +
  scale_y_log10(breaks = c(25E3, 50E3, 100E3, 150E3, 200E3),"pageviews (excludes bots)", labels = polloi::compress) +
  scale_x_date(labels = date_format("%Y-%m-%d"), date_breaks = "1 day") +
  scale_color_discrete(name = "Access method") +
  ggthemes::theme_tufte(base_size = 12, base_family = "Gill Sans") +
  theme(axis.text.x=element_text(angle = 45, hjust = 1),
        panel.grid = element_line("gray70")) +
  labs(title = "English Wikipedia Pageviews in the US with a referrer from Facebook by access method") 

ggsave("daily_pageviews_fb_bymethod.png", p, path = fig_path, units = "in", dpi = plot_resolution, height = 6, width = 10, limitsize = FALSE)
rm(p)

#Plot of daily pageviews broken down by some popular US news source.
daily_pageviews_bynews <- rbind(readr::read_rds("data/daily_pageviews_bynews.rds")) %>%
  mutate(date = lubridate::ymd(date))

#simplify url names
daily_pageviews_bynews$url <- sub(".*(The_Washington_Post).*", "The Washington Post", daily_pageviews_bynews$url)
daily_pageviews_bynews$url <- sub(".*(The_Wall_Street_Journal).*", "The Wall Street Journal", daily_pageviews_bynews$url)
daily_pageviews_bynews$url <- sub(".*(New_York_Post).*", "New York Post", daily_pageviews_bynews$url)
daily_pageviews_bynews$url <- sub(".*(The_New_York_Times).*", "The New York Times", daily_pageviews_bynews$url)
daily_pageviews_bynews$url <- sub(".*(The_Guardian).*", "The Guardian", daily_pageviews_bynews$url)


p <- ggplot(daily_pageviews_bynews, aes(x = date, y = requests, fill = url)) +
  geom_col() +
  geom_vline(xintercept = as.numeric(as.Date("2018-04-03")),
             linetype = "dashed", color = "blue") +
  geom_text(aes(x=as.Date('2018-04-03'), y=1000, label="Facebook Article Context Feature Launch Date"), size=3, vjust = -1.2, angle = 90, color = "black") +
  scale_y_continuous("pageviews (bots excluded)", labels = polloi::compress) +
  scale_x_date(labels = date_format("%d-%b-%y"), date_breaks = "1 day") +
  scale_fill_brewer("News Source", palette = "Set2") +
  ggthemes::theme_tufte(base_size = 12, base_family = "Gill Sans") +
  theme(axis.text.x=element_text(angle = 45, hjust = 1),
        panel.grid = element_line("gray70")) +
  labs(title = "English Wikipedia Pageviews in US with a referrer from Facebook by news source") 

ggsave("daily_pageviews_bynews.png", p, path = fig_path, units = "in", dpi = plot_resolution, height = 6, width = 10, limitsize = FALSE)
rm(p)

