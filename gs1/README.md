
<h1>Restful web-service for Goal Settings:</h1>

<h2>Restify-MongoJS web service for Goal Settings</h2>

- Input:
	GET retrieving keyword
- Output:
	REST JSON data 

- Usage:

$ cd $HOME; mkdir gs1 && cd gs1

$ npm install

 Which includes:
  - install mongojs
  - install mongodb //otherwise ObjectID doesn't work 
  - install restify

$ node app.js

- Then:
1. in command line:

$ curl http://localhost:8088/user/tester
$ curl http://localhost:8088/email/v@bc.com
$ curl http://localhost:8088/id/511d5a2d7674417d22000002
$ curl http://localhost:8088/

2. or in browser:

http://localhost:8088/user/tester
http://localhost:8088/email/v@bc.com
http://localhost:8088/id/511d5a2d7674417d22000002
http://localhost:8088/


All JSON data,  within a javascript object {}.
