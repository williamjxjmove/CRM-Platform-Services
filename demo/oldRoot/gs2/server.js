var restify = require('restify');

var http = require('http')
    , MongoClient = require('mongodb').MongoClient
    , format = require('util').format;

var url = format("mongodb://localhost/goals")

function get_user(req, res, next) {
  return MongoClient.connect(url, function(err, db) {
	  var collection = db.collection('Goal');
	  collection.findOne({'username':req.params.username}, function(err, item) {
		if(item) {
			console.log(item);
			//res.contentType('application/json');
			res.send(item);
			res.end();
		}
		else {
			console.log('No Record Matched: ' + req.params.username);
			res.send('No Record Matched: ' + req.params.username);
			res.end();
		}
	  });
  });
}

function get_email(req, res, next) {
  return MongoClient.connect(url, function(err, db) {

	var collection = db.collection('Goal');
	collection.findOne({'email':req.params.email}, function(err, item) {

		if(item) {
			console.log(item);
			res.send(item);
			res.end();
		}
		else {
			console.log('No Record Matched: ' + req.params.email);
			res.send('No Record Matched: ' + req.params.email);
			res.end();
		}
	  });
  });
}

function get_id(req, res, next) {

  var ObjectID = require('mongodb').ObjectID;
  var idString = req.params.id;
  //console.log(idString);

  return MongoClient.connect(url, function(err, db) {
	  var collection = db.collection('Goal');
	  collection.findOne({_id: new ObjectID(idString)}, function(err, item) {
		if(item) {
			console.log(item);
			res.send(item);
			res.end();
		}
		else {
			console.log('No Record Matched: ' + req.params.id);
			res.send('No Record Matched: ' + req.params.id);
			res.end();
		}

	  });
  });
}



function get_all(req, res, next) {
  return MongoClient.connect(url, function(err, db) {
	var collection = db.collection('Goal');
	collection.find({}, {limit:10}).toArray(function(err, item) {
		if(item) {
			console.dir(item);
			res.send(item);
			res.end();
		}
		else {
			console.log('No Record.');
			res.send('No Record in MongoDB');
			res.end();
		}
        });
  });
}

///////////////////////////////////////

var server = restify.createServer();

// 1. username:
server.get('/user/:username', get_user, function(req, res) {
  res.send("The Goal Setting User Information: ");
  res.send("\\n");
  res.write("");
  res.end();
});

// 2. id:
server.get('/id/:id', get_id);

// 3. email:
server.get('/email/:email', get_email);

// 4. all/others:
server.get('/', get_all);


server.listen(8080, function() {
  console.log('%s listening at %s', server.name, server.url);
});


