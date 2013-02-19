var tpoUser = require('../models/tpouser');

/*
 * GET users listing.
 */

exports.index = function (req, res) {
    tpoUser.all(function (err, tpoUsers) {
        res.send(tpoUsers);
    });
};

/*
 * GET users listing by ID.
 */

exports.show = function (req, res) {
    tpoUser.findById(req.params.id, function (err, tpoUser) {
        res.send(tpoUser);
    });
};

/*
 * GET users listing by Last Name.
 */

exports.byLastName = function (req, res) {
    tpoUser.findByLastName(req.params.lastName, function (err, tpoUsers) {
        res.send(tpoUsers);
    });
};