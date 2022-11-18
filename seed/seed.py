import requests
import random

local_url = 'http://localhost:3000'
aws_url = 'http://PANDA.eba-gaci4fx8.us-west-2.elasticbeanstalk.com'

def add_user(url):
    for i in range(100):
        name = open("name.txt", "r").readlines()[i]
        myobj = {'user[name]': name,
                'user[password]': 'test',
                'user[email]': str(i) + 'user@hotmail.com',
                'user[points]': '100',
                'commit': 'Create User'}

        x = requests.post(url + '/users', data = myobj)
        print('add user' + str(i) + ': ' + str(x.status_code))

def add_tag(url):
    for i in range(10):
        name = open("location.txt", "r").readlines()[i]
        myobj = {'name': name,
                'description': 'test',
                'user_id': random.randint(0, 99),
                }
        x = requests.post(url + '/tags', data = myobj)
        print('add tag' + str(i) + ': ' + str(x.status_code))

def add_post(url):
    for i in range(1, 100):
        tag_id = random.randint(1, 10)
        myobj = {'post[title]': "test comment title" + str(i),
                'post[body]': 'test for sample post',
                'post[points2view]': 10,
                'post[tag_id]' : tag_id,
                'post[user_id]' : i,
        }
        x = requests.post(url + '/posts', data = myobj)
        print('add post' + str(i) + ': ' + str(x.status_code))

def add_comment(url):
    for i in range(1, 100):
        user_id = random.randint(1, 100)
        myobj = {
                'comment[body]': 'test comment body' + str(i),
                'comment[user_id]' : user_id,
        }
        x = requests.post(url + '/posts/' + str(i) + '/comments', data = myobj)
        print('add comment' + str(i) + ': ' + str(x.status_code))

#choose which server to seed(local or aws)
my_url = aws_url

#chosse which data to see. comment out if you don't want to seed
add_user(my_url)
add_tag(my_url)
add_post(my_url)
add_comment(my_url)

print('exit')
