
# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://doc.scrapy.org/en/latest/topics/items.html

import scrapy
from scrapy import Field


class BookdbItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    # define content name
    id = Field()
    name = Field()
    author = Field()
    publish = Field()
    original = Field()
    translator = Field()
    year = Field()
    page = Field()
    price = Field()
    binding = Field()
    series = Field()
    isbn = Field()
    score = Field()
    number = Field()
