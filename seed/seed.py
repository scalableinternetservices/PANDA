import requests

local_url = 'http://localhost:3000/users'
aws_url = 'http://xinlei.eba-gaci4fx8.us-west-2.elasticbeanstalk.com/users'
for i in range(100):
    name = open("name.txt", "r").readlines()[i]
    myobj = {'user[name]': name, 
            'user[password]': 'test', 
            'user[email]': str(i) + 'user@hotmail.com', 
            'user[points]': '100', 
            'commit': 'Create User'}

    x = requests.post(aws_url, data = myobj)
    print(x.status_code)


print('exit')
