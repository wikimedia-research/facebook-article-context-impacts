# Estimate the impact of Facebook's article context feature on English Wikipedia Pageviews
Ticket: [T191429](https://phabricator.wikimedia.org/T191429)

## Overview

Facebook completed a full rollout of their article context feature on April 3, 2018, which allows users to view context about an article including the publisher’s Wikipedia entry.

We're interested in evaluating the impact of this changes on English Wikipedia Pagviews in the United States. To investigate, we will:

1. Calculate the daily number of enwiki pageviews in the US with a referrer from Facebook, before and after the begin of the feature's full rollout on April 3, 2018
2. Estimate the number of additional daily pageviews resulting from the feature
3. Publish a list of the top N pages receiving the most referrers, for some timespans before and after the rollout


## Daily English Wikipedia Pageview with a referrer from Facebook

There does not appear to be any signficant changes in daily pageviews to English Wikipedia from Facebook immediately following the full rollout of the article context feature on April 3, 2018. There's an increase in pageviews with a facebook referrer prior to the rollout between March 31 and April 2nd. This may be due to higher facebook traffic over the Easter holiday weekend. Further review of pageviews over the coming weeks will help determine if there are any sustained overall increases in daily pageviews.

Note that the data collected currently includes all English Wikipedia pageviews with a Facebook referrer; not just users directed to English Wikipedia from the article context feature.


![](figures/daily_pageviews_fb.png)


![](figures/daily_pageviews_fb_bymethod.png)

A breakdown by access method shows a small increase in English Wikipedia pageviews on desktop following the release date while mobile desktop views decline. 

![](figures/daily_pageviews_bynews.png)

A plot of daily pageviews in the US to English Wikipedia pages on some popular US news sources helps highlight some of the impacts of the new Facebook feature. There is sharp increase of pageviews to these pages from Facebook on April 3rd. Daily pageviews increase from a total of 17 pageviews on April 2nd to a peak of 1431 pageviews on April 4th. After April 4th, the pageviews appear to start to decrease again to arouund 500.  

Further review of these trends in the coming weeks will be useful to identify if the rollout resulted in any sustained changes. 
