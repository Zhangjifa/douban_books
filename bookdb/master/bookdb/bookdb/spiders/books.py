# -*- coding: utf-8 -*-
import scrapy
from bookdb.items import BookdbItem
from scrapy import Request
from urllib.parse import quote
import redis


class BooksSpider(scrapy.Spider):
    name = 'books'
    allowed_domains = ['book.douban.com']
    # start_urls = ['http://book.douban.com/']
    base_url = "https://book.douban.com"

    def start_requests(self):
        # connect redis database
        db = redis.Redis(host=self.settings.get("REDIS_HOST"), port=self.settings.get("REDIS_PORT"), decode_responses=True)
        # get tag url address from redis
        while db.llen("bookstag:tag_urls"):
            tag = db.lpop("bookstag:tag_urls")
            url = self.base_url + quote(tag)
            yield Request(url=url, callback=self.parse, dont_filter=True)

    def parse(self, response):
        # get all book url address
        book_list = response.selector.css("li.subject-item div.pic a.nbg::attr(href)").extract()
        # print(book_list)
        if book_list:
            for book_url in book_list:
                item = BookdbItem()
                item['url'] = book_url
                yield item

        # get next page url address
        next_url = response.selector.css("span.next a::attr(href)").extract_first()
        # print(next_url)
        if next_url:
            url = response.urljoin(next_url)
            yield Request(url=url, callback=self.parse)
