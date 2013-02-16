
<h1>Restful web-service for Goal Settings:</h1>

<h2>Restify-MongoDB version</h2>

<h3> Input:</h3>
	GET retrieving keyword
<h3> Output:</h3>
	REST JSON data 

<h3>Usage</h3>

$ cd $HOME; mkdir gs2 && cd gs2

$ npm install

 Which includes:
  - install mongojs
  - install mongodb //otherwise ObjectID doesn't work 
  - install restify

$ node server.js

- Then:

1. in command line:

$ curl http://localhost:8080/user/tester

$ curl http://localhost:8080/email/v@bc.com

$ curl http://localhost:8080/id/511d5a2d7674417d22000002

$ curl http://localhost:8080/

2. or in browser:

http://localhost:8080/user/tester

http://localhost:8080/email/v@bc.com

http://localhost:8080/id/511d5a2d7674417d22000002

http://localhost:8080/


All JSON data,  within a javascript object {}.
