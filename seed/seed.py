import requests

local_url = 'http://localhost:3000'
aws_url = 'http://zephyrz.eba-gaci4fx8.us-west-2.elasticbeanstalk.com'

def add_user(url):
    for i in range(100):
        name = open("name.txt", "r").readlines()[i]
        myobj = {'user[name]': name,
                'user[password]': 'test',
                'user[email]': str(i) + 'user@hotmail.com',
                'user[points]': '100',
                'commit': 'Create User'}

        x = requests.post(url + '/users', data = myobj)
        print(x.status_code)

def add_tag(url):
    for i in range(10):
        name = open("location.txt", "r").readlines()[i]
        myobj = {'name': name,
                'description': 'test'
                }
        x = requests.post(url + '/tags', data = myobj)
        print(x.status_code)

#choose which server to seed(local or aws)
my_url = local_url

#chosse which data to see. comment out if you don't want to seed
add_user(my_url)
add_tag(my_url)

print('exit')
