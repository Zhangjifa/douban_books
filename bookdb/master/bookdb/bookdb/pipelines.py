# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html

import redis
import re


class BookdbPipeline(object):
    def __init__(self,host,port):
        # connect redis database
        self.db = redis.Redis(host=host, port=port, decode_responses=True)
 
    @classmethod
    def from_crawler(cls,crawler):
        return cls(
            host = crawler.settings.get("REDIS_HOST"),
            port = crawler.settings.get("REDIS_PORT"),
        )

    def process_item(self, item, spider):
        bookid = re.findall("book.douban.com/subject/([0-9]+)/",item['url'])
        if bookid:
            # deduplicate according to id
            if self.db.sadd("books:id", bookid[0]):
                print(item["url"])
                self.db.lpush("bookspider:start_urls", item["url"])
        else:
            self.db.lpush("bookspider:no_urls", item['url'])
