#Impact of Facebook About Article Feature on EnWiki Pageviews. 

#Daily number of enwiki pageviews in the US with a referrer from Facebook"
#Remotely from Stat005

start_date <- as.Date("2018-03-20")
end_date <- as.Date("2018-04-08")

daily_pageviews_fb<- do.call(rbind, lapply(seq(start_date, end_date, "day"), function(date) {
  cat("Fetching webrequest data from ", as.character(date), "\n")
  clause_data <- wmf::date_clause(date)
  
query <- paste("
SELECT '", date, "' AS date, COUNT(1) as requests
FROM wmf.webrequest",
clause_data$date_clause,
" AND referer LIKE '%facebook.com%'
AND is_pageview = TRUE
--all referers from facebook should by classified as external
AND referer_class = 'external'
AND http_status IN ('200', '304')
--remove bots and spiders
AND agent_type = 'user'
-- only look at English Wikipedia pageviews in the US
AND normalized_host.project = 'en'  
AND normalized_host.project_class = 'wikipedia'
AND geocoded_data['country'] = 'United States'
;") 

results <- wmf::query_hive(query)
return(results)
}))

readr::write_rds(daily_pageviews_fb, "daily_pageviews_fb.rds", "gz")

#LOCAL
system("scp mneisler@stat5:/home/mneisler/daily_pageviews_fb.rds daily_pageviews_fb.rds")


#Look at pageviews with facebook referrer broken down by access method 

#Remotely from Stat005

start_date <- as.Date("2018-03-20")
end_date <- as.Date("2018-04-08")

daily_pageviews_fb_bymethod<- do.call(rbind, lapply(seq(start_date, end_date, "day"), function(date) {
  cat("Fetching webrequest data from ", as.character(date), "\n")
  clause_data <- wmf::date_clause(date)
  
  query <- paste("
                 SELECT '", date, "' AS date, COUNT(1) as web_requests, access_method
                 FROM wmf.webrequest",
                 clause_data$date_clause,
                 " AND referer LIKE '%facebook.com%'
                 AND is_pageview = TRUE
                 AND referer_class = 'external'
                 AND http_status IN ('200', '304')
                 AND agent_type = 'user'
                 AND normalized_host.project = 'en'  
                 AND normalized_host.project_class = 'wikipedia'
                 AND geocoded_data['country'] = 'United States'
                GROUP BY access_method
                 ;") 
  
  results <- wmf::query_hive(query)
  return(results)
}))

readr::write_rds(daily_pageviews_fb_bymethod, "daily_pageviews_fb_bymethod.rds", "gz")

#LOCAL
system("scp mneisler@stat5:/home/mneisler/daily_pageviews_fb_bymethod.rds daily_pageviews_fb_bymethod.rds")


#Look at some popular facebook daily US newspapers to see pageview impacts on those pages.
#Remotely from Stat005

start_date <- as.Date("2018-03-20")
end_date <- as.Date("2018-04-08")

daily_pageviews_bynews<- do.call(rbind, lapply(seq(start_date, end_date, "day"), function(date) {
  cat("Fetching webrequest data from ", as.character(date), "\n")
  clause_data <- wmf::date_clause(date)
  
  
query <- paste("
SELECT '", date, "' AS date, CONCAT('https://',uri_host,uri_path,uri_query) AS url, SUM(1) AS requests
FROM wmf.webrequest",
clause_data$date_clause,
" AND is_pageview = TRUE
AND referer LIKE '%facebook.com%' 
AND referer_class = 'external'
AND http_status IN ('200', '304')
AND agent_type = 'user'
AND (uri_path LIKE '%/The_Washington_Post%' 
     OR uri_path LIKE '%/The_Wall_Street_Journal'
     OR uri_path LIKE '%/New_York_Post' 
     OR uri_path LIKE '%/The_New_York_Times'
     OR uri_path LIKE '%/The_Guardian'
      OR uri_path LIKE '%/BBC_News'
)
AND normalized_host.project = 'en'  
AND normalized_host.project_class = 'wikipedia'
AND geocoded_data['country'] = 'United States'
GROUP BY uri_host, uri_path, uri_query
;") 

results <- wmf::query_hive(query)
return(results)
}))

readr::write_rds(daily_pageviews_bynews, "daily_pageviews_bynews.rds", "gz")

#LOCAL
system("scp mneisler@stat5:/home/mneisler/daily_pageviews_bynews.rds daily_pageviews_bynews.rds")



