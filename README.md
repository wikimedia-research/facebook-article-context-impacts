# Estimate the impact of Facebook's article context feature on English Wikipedia Pageviews
Ticket: [T191429](https://phabricator.wikimedia.org/T191429)

## Overview

Facebook completed a full rollout of their article context feature on April 3, 2018, which allows users to view context about an article including the publisher’s Wikipedia entry. This feature was available to all of its users in the United States.

We're interested in evaluating the impact of this changes on English Wikipedia Pagveiews. To investigate, we will:

1. Calculate the daily number of enwiki pageviews in the US with a referrer from Facebook, before and after the begin of the feature's full rollout on April 3, 2018
2. Estimate the number of additional daily pageviews resulting from the feature
3. Publish a list of the top N pages receiving the most referrers, for some timespans before and after the rollout



## Daily English Wikipedia Pageview with a referrer from Facebook

There does not appear to be any significant changes in daily pageviews to English Wikipedia from Facebook immediately following the full rollout of the article context feature on April 3, 2018. There's an increase in pageviews with a facebook referrer prior to the rollout between March 31 and April 2nd. This may be due to higher facebook traffic over the Easter holiday weekend. Further review of pageviews over the coming weeks will help determine if there are any sustained overall increases in daily pageviews with a facebook referrer.

Note the data collected currently includes all English Wikipedia pageviews with a Facebook referrer; not just users directed to English Wikipedia from the article context feature. 


![](figures/daily_pageviews_fb.png)


![](figures/daily_pageviews_fb_bymethod.png)

A breakdown by access method shows a slight increase in English Wikipedia pageviews on desktop following the release date while mobile desktop views decline. 

![](figures/daily_pageviews_bynews.png)

Pending a complete list of articles where this features is deployed, I reviewed a breakdown of pageviews for some popular US new sources that were confirmed to have the facebook article context feature. There is sharp increase of pageviews to these pages from Facebook on April 3rd, with a maximum of 425 pagesviews to the English Wikipedia Washington Post page on April 4th. Pageviews appear to start to decrease again.

It would be useful to have a full list of articles on which the feature is deployed or way to specifically isolate referrers from that feature to determine direct impacts.




