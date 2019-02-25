# -*- coding: utf-8 -*-
import scrapy
from bookdb.items import BookdbItem
from scrapy_redis.spiders import RedisSpider
import redis
import re


class BookdetailSpider(RedisSpider):
    name = 'bookdetail'
    # allowed_domains = ['book.douban.com']
    # start_urls = ['http://book.douban.com/']
    redis_key = "bookspider:start_urls"

    def __init__(self, *args, **kwargs):
        domain = kwargs.pop("domain", "")
        self.allowed_domains = filter(None, domain.split(','))
        super(BookdetailSpider, self).__init__(*args, **kwargs)
        self.db = redis.Redis(host="127.0.0.1", port=6379, decode_responses=True)

    def parse(self, response):
        if response.status == 200:
            try:
                item = BookdbItem()
                # get destination content block
                details = response.selector.css("#wrapper")
                item['id'] = details.re_first('id="collect_form_([0-9]+)"')
                item['name'] = details.css('h1 span::text').extract_first()

                info = details.css('#info').extract_first()
                authors = re.search('<span.*?作者*?</span>(.*?)<br>', info,re.S)
                if authors:
                    author = " ".join(re.findall('<a.*?>(.*?)</a>', authors.group(1), re.S))
                    item['author'] = author
                else:
                    item['author'] = 'Unknown'
                publish = re.findall("<span.*?出版社:*?</span>(.*?)<br>", info)
                if publish:
                    item['publish'] = publish[0].strip()
                else:
                    item['publish'] = 'Unknown'
                original = re.findall('<span.*?原作名:</span>\s*(.*?)<br>',info)
                if original:
                    item['original'] = original[0]
                else:
                    item['original'] = 'None'
                translator = re.search('<span.*?译者.*?</span>(.*?)<br>',info,re.S)
                if translator:
                    item['translator'] = " ".join(re.findall('<a.*?>(.*?)</a>', translator.group(1), re.S))
                else:
                    item['translator'] = 'None'
                item['year'] = re.findall("<span.*?出版年:*?</span>(.*?)<br>", info)[0].strip()
                item['page'] = re.findall("<span.*?页数:*?</span>(.*?)<br>", info)[0]
                item['price'] = re.findall("<span.*?定价:*?</span>(.*?)<br>", info)[0]
                binding = re.findall("<span.*?装帧:*?</span>(.*?)<br>", info)
                if binding:
                    item['binding'] = binding[0]
                else:
                    item['binding'] = 'Unknown'
                series = re.findall('<span.*?丛书:</span>.*?<a .*?>(.*?)</a><br>', info, re.S)
                if series:
                    item['series'] = series[0]
                else:
                    item['series'] = 'Unknown'
                item['isbn'] = re.findall("<span.*?ISBN:*?</span>(.*?)<br>", info)[0]
                score = details.css("strong.ll.rating_num::text").extract_first()
                if score.isspace():
                    item['score'] = 0.0
                else:
                    item['score'] = score.strip()

                number = details.css('a.rating_people span::text').extract_first()
                if number:
                    item['number'] = number
                else:
                    item['number'] = 0

                # print(item)
                # print(type(item))
                yield item
            except Exception as e:
                print(e)