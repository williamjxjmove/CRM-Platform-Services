var user = require('./controllers/userController')

module.exports = function (app) {
    app.get('/users', user.index);
    app.get('/users/:id', user.show);
    app.get('/users/lastName/:lastName', user.byLastName);
};