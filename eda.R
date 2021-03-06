library(tidyverse)
library(ggplot2)
library(scales)
library(reshape2)

fig_path <- file.path("figures")
plot_resolution <- 192

#plot daily enwiki pageviews from US by facebook referer
daily_pageviews_fb <- rbind(readr::read_rds("data/daily_pageviews_fb_v2.rds")) %>%
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


#Plot of daily pageviews broken down by some popular US news sources that include article context feature.
daily_pageviews_bynews <- rbind(readr::read_rds("data/daily_pageviews_bynews_v3.rds")) %>%
  mutate(date = lubridate::ymd(date))

#simplify url names
daily_pageviews_bynews$url <- sub(".*(The_Washington_Post).*", "The Washington Post", daily_pageviews_bynews$url)
daily_pageviews_bynews$url <- sub(".*(The_Wall_Street_Journal).*", "The Wall Street Journal", daily_pageviews_bynews$url)
daily_pageviews_bynews$url <- sub(".*(New_York_Post).*", "New York Post", daily_pageviews_bynews$url)
daily_pageviews_bynews$url <- sub(".*(The_New_York_Times).*", "The New York Times", daily_pageviews_bynews$url)
daily_pageviews_bynews$url <- sub(".*(The_Guardian).*", "The Guardian", daily_pageviews_bynews$url)
daily_pageviews_bynews$url <- sub(".*(The_Daily_Wire).*", "The Daily Wire", daily_pageviews_bynews$url)
daily_pageviews_bynews$url <- sub(".*(Breitbart_News).*", "Breitbart News", daily_pageviews_bynews$url)
daily_pageviews_bynews$url <- sub(".*(Vox).*", "Vox (website)", daily_pageviews_bynews$url)
daily_pageviews_bynews$url <- sub(".*(Fox_News).*", "Fox News", daily_pageviews_bynews$url)


#calculate daily total
daily_total_pageviews <- daily_pageviews_bynews %>%
  group_by(date) %>%
  summarise(total_pageviews = sum(requests))

p <- ggplot() +
  geom_bar(data = daily_pageviews_bynews, aes(x=date, y= requests, fill = url), stat = "identity") +
  geom_line(data = daily_total_pageviews, aes(x=date, y = total_pageviews), size = 1) +
  geom_vline(xintercept = as.numeric(as.Date("2018-04-03")),
             linetype = "dashed", color = "blue") +
  geom_text(aes(x=as.Date('2018-04-03'), y=3000, label="Facebook Article Context Feature Launch Date"), size=3, vjust = -1.2, angle = 90, color = "black") +
  scale_y_continuous("pageviews (bots excluded)", labels = polloi::compress) +
  scale_x_date(labels = date_format("%d-%b-%y"), date_breaks = "1 day") +
  scale_fill_brewer("News media page", palette = "Set3") +
  ggthemes::theme_tufte(base_size = 12, base_family = "Gill Sans") +
  theme(axis.text.x=element_text(angle = 45, hjust = 1),
        panel.grid = element_line("gray70")) +
  labs(title = "English Wikipedia Pageviews in US with a referrer from Facebook by news media page") 


ggsave("daily_pageviews_bynews.png", p, path = fig_path, units = "in", dpi = plot_resolution, height = 6, width = 10, limitsize = FALSE)
rm(p)

#Find avg pageviews before and after broken down by popular news sources
pv_avg_prior <- daily_pageviews_bynews %>%
  filter(date >= '2018-03-26' & date <= '2018-04-02') %>%
  summarise(avg_views = mean(requests))

pv_avg_week_after <- daily_pageviews_bynews %>%
  filter(date >= '2018-04-11' & date <= '2018-04-18') %>%
  summarise(avg_views = mean(requests))

#Top English Wikipedia pages with a facebook referrer 

##Top 30 Pages Viewed on April 4th (Peak Day of Views)

top30_fromfb_Apr4 <- read.delim("data/top30_fromfb_Apr4.txt")
knitr::kable(top30_fromfb_Apr4)

##Top pages (urls) a week before and after rollout date on April 4th.

#top 30 pages before article context rollout
top_n_fromfb_prior <- rbind(readr::read_rds("data/top_n_fromfb_prior.rds")) %>%
  group_by(url) %>%
  summarise(pageviews = sum(requests)) %>%
  top_n(30, pageviews) %>%
  arrange(desc(pageviews))

#add row ID number to see ranking
top_n_fromfb_prior$No. <- seq.int(nrow(top_n_fromfb_prior))
top_n_fromfb_prior<- top_n_fromfb_prior[c(3,1,2)]
knitr::kable(top_n_fromfb_prior)

#top 50 pages after article context rollout
top_n_fromfb_after <- rbind(readr::read_rds("data/top_n_fromfb_after.rds")) %>%
  group_by(url) %>%
  summarise(pageviews = sum(requests)) %>%
  top_n(30, pageviews) %>%
  arrange(desc(pageviews))

top_n_fromfb_after$No. <- seq.int(nrow(top_n_fromfb_after))
top_n_fromfb_after<- top_n_fromfb_after[c(3,1,2)]
knitr::kable(top_n_fromfb_after)
