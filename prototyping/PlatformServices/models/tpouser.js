var mongoose = require('mongoose');
var connectionUrl = 'mongodb://localhost/test';

var Schema = mongoose.Schema;
var ObjectId = Schema.ObjectId;

// Schema
var TpoUserSchema = Schema({
    count: {
        contacts: Number
        , prospects: Number
        , closings: Number
        , listings: Number
    }
    , info: {
        first_name: String
        , last_name: String
        , phone: String
        , e_mail: String
    }
    , user: String
});
var TpoUser = mongoose.model('user', TpoUserSchema, 'tpouser');

// Functions
exports.all = function (callback) {
    mongoose.connection.once('open', function () {
        console.log('Connection opened');
        TpoUser.find(function (err, tpoUsers) {
            if (err) {
                callback(err, null);
                return;
            }
            mongoose.disconnect(function () {
                console.log('Connection closed');
            });
            callback(null, tpoUsers);
        });
    });

    mongoose.connect(connectionUrl);
};

exports.findById = function (id, callback) {
    mongoose.connection.once('open', function () {
        console.log('Connection opened');
        TpoUser.findById(id, function (err, tpoUser) {
            if (err) {
                callback(err, null);
                return;
            }
            mongoose.disconnect(function () {
                console.log('Connection closed');
            });
            callback(null, tpoUser);
        });
    });

    mongoose.connect(connectionUrl);
};

exports.findByLastName = function (lastName, callback) {
    mongoose.connection.once('open', function () {
        console.log('Connection opened');
        TpoUser.find({ 'info.last_name': lastName }, function (err, tpoUsers) {
            if (err) {
                callback(err, null);
                return;
            }
            mongoose.disconnect(function () {
                console.log('Connection closed');
            });
            callback(null, tpoUsers);
        });
    });

    mongoose.connect(connectionUrl);
};
