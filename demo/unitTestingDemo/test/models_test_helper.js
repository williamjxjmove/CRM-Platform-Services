module.exports = function() {
	global.app = app = require('compound').createServer();
	global.railway = app.compound;
	for (var i in railway.models) {
		global[i] = railway.models[i];
	}
};