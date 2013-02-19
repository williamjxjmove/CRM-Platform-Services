// for Tests.Test
// William on Feb 18, 2013.
//
var restify = require('restify');

var mongojs = require('mongojs');
var db = mongojs('mongodb://localhost/tests', ['Test']);
var goal = db.collection('Test');
//db.Goal.find().forEach(function(err, item) { console.log(item); });


function get_user(req, res, next) 
{
	// res.send('hello ' + req.params.username);
	goal.findOne({'user':req.params.username}, function(err, item) {
                if(item) {
                        console.log(item); res.send(item); res.end();
		}
                else {
			console.log('No Record Matched: ' + req.params.username);
                        res.send('No Record Matched: ' + req.params.username);
                        res.end();
		}
	});
}

function get_email(req, res, next) 
{
	goal.findOne({'email':req.params.email}, function(err, item) {
                if(item) {
                        console.log(item); res.send(item); res.end();
                }
                else {
                        console.log('No Record Matched: ' + req.params.email);
                        res.send('No Record Matched: ' + req.params.email);
                        res.end();
                }
	});
}

function get_id(req, res, next) 
{
	var ObjectID = require('mongodb').ObjectID;
	var idString = req.params.id;
	console.log(idString);

	goal.findOne({_id: new ObjectID(idString)}, function(err, item) {
                if(item) {
                        console.log(item); res.send(item); res.end();
                }
                else {
                        console.log('No Record Matched: ' + req.params.id);
                        res.send('No Record Matched: ' + req.params.id);
                        res.end();
                }
	});
}

function get_all(req, res, next) 
{
	goal.find({}, {limit:10}).toArray(function(err, item) {
                if(item) {
                        console.dir(item); res.send(item); res.end();
                }
                else {
                        console.log('No Record.');
                        res.send('No Record in MongoDB');
                        res.end();
                }
        });
}



var server = restify.createServer();

server.get('/name/:username', get_user);

server.get('/user/:username', get_user);
//server.head('/user/:username', get_user);


server.get('/email/:email', get_email);

server.get('/id/:id', get_id);

server.get('/', get_all);

server.get('/', function(req,res, next) {
  console.dir(req.params);
});


server.get(/^\/([a-zA-Z0-9_\.~-]+)\/(.*)/, function(req, res, next) {
  console.log(req.params[0]);
  console.log(req.params[1]);
  res.send(200);
  return next();
});



server.listen(8086, function() {
  console.log('%s listening at %s', server.name, server.url);
});



