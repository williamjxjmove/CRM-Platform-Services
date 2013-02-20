/*
 db/schema.js contains database schema description for application models
 by default (when using jugglingdb as ORM) this file uses database connection
 described in config/database.json. But it's possible to use another database
 connections and multiple different schemas, docs available at

 http://railwayjs.com/orm.html

 Example of model definition:

 define('User', function () {
     property('email', String, { index: true });
     property('password', String);
     property('activated', Boolean, {default: false});
 });

 Example of schema configured without config/database.json (heroku redistogo addon):
 schema('redis', {url: process.env.REDISTOGO_URL}, function () {
     // model definitions here
 });


var Test = describe('Test', function () {
    property('name', String);
    property('first_name', String);
    property('last_name', String);
    property('phone', String);
    property('e_mail', String);
    property('contacts', Number);
    property('prospects', Number);
    property('closings', Number);
    property('listings', Number);
    property('createdAt', Date);
    property('active', Boolean);
    set('restPath', pathTo.tests);
});
*/

var Info = describe('info', function() {
    property('first_name', String);
    property('last_name', String);
    property('phone', String);
    property('e_mail', String);
});

var Count = describe('count', function() {
    property('contacts', Number);
    property('prospects', Number);
    property('closings', Number);
    property('listings', Number);
});

var Test = describe('Test', function() {
    property('count', Count);
    property('info', Info);
    property('name', String);
    property('createdAt', Date);
    property('active', Boolean);
});
