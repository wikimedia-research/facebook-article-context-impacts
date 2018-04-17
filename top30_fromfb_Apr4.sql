--Top 30 Pages on April 4th (day after rollout where it looks like there was a peak in pageviews)
--Remotely from Stat005

SELECT CONCAT('https://',uri_host,uri_path,uri_query) AS url, SUM(1) AS requests
FROM wmf.webrequest 
WHERE year = 2018 AND month = 4 AND day =4
AND is_pageview
AND referer LIKE '%facebook.com%' 
AND referer_class = 'external'
AND http_status IN ('200', '304')
AND agent_type = 'user'
AND normalized_host.project = 'en'  
AND normalized_host.project_family = 'wikipedia'
AND geocoded_data['country'] = 'United States'
GROUP BY uri_host, uri_path, uri_query
ORDER BY requests DESC LIMIT 30


