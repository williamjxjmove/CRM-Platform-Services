var request = require('request');


describe('Posts Controller', function() {
	it('playing', function(done) {
		for (var m in request) {
			console.log(m);
		};
		done();
	});
});
