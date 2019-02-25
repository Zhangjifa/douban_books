# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html

import redis
import json


class BookdbPipeline(object):
    def __init__(self,host,port):
        #连接redis数据库
        self.db = redis.Redis(host=host, port=port, decode_responses=True)

    @classmethod
    def from_crawler(cls,crawler):
        '''注入实例化对象（传入参数）'''
        return cls(
            host = crawler.settings.get("REDIS_HOST"),
            port = crawler.settings.get("REDIS_PORT"),
        )

    def process_item(self, item, spider):
        if item:
            print(item)
            detail = dict(item)
            self.db.lpush("bookslave0:detail", json.dumps(detail))