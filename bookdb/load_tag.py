import requests
from pyquery import PyQuery
import redis


def main():
    # crawler douban book all tag url and save in redis database
    url = "https://book.douban.com/tag/?view=type&icn=index-sorttags-all"
    res = requests.get(url)
    if res.status_code == 200:
        html = res.content.decode("utf-8")
        # use PyQuery format html code
        doc = PyQuery(html)
        # conntect redis database
        db = redis.StrictRedis(host="127.0.0.1", port=6379, db=0)
        items = doc("table.tagCol tr td a")
        for item in items.items():
            tag = item.attr.href
            db.lpush("bookstag:tag_urls", tag)
        print("total of tag:", len(items))


if __name__ == '__main__':
    main()
