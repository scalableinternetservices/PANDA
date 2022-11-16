import requests



local_url = 'http://localhost:3000'
aws_url = 'http://zephyrz.eba-gaci4fx8.us-west-2.elasticbeanstalk.com'

# for i in range(100):
#     name = open("name.txt", "r").readlines()[i]
#     myobj = {'user[name]': name, 
#             'user[password]': 'test', 
#             'user[email]': str(i) + 'user@hotmail.com', 
#             'user[points]': '100', 
#             'commit': 'Create User'}

    # x = requests.post(aws_url + '/users', data = myobj)
    # print(x.status_code)

for i in range(10):
    name = open("location.txt", "r").readlines()[i]
    myobj = {'name': name, 
             'description': 'test'
            }
    x = requests.post(local_url + '/tags', data = myobj)
    print(x.status_code)

print('exit')
