import pymysql
import redis
import json
import time


def main():
    redis_db = redis.StrictRedis(host='localhost', port=6379, db=0)
    mysql_db = pymysql.connect(host='localhost', user='root', password='12345678', db='bookdb')
    cursor = mysql_db.cursor()

    while True:
        source, data = redis_db.blpop(['bookslave0:detail'])
        try:
            content = json.loads(data)
            data = dict(content)
            keys = ",".join(data.keys())
            values = ','.join(['%s'] * len(data))
            sql = "insert into books(%s) values(%s)" % (keys, values)
            cursor.execute(sql, tuple(data.values()))
            mysql_db.commit()
            print("write to mysql is success !!")
            time.sleep(3)
        except Exception as e:
            mysql_db.rollback()
            print(e)


if __name__ == '__main__':
    main()