require('../models_test_helper.js')();
var assert = require('assert');

// Set correct values for only the attrs in the list.
function setCorrectValues(post, attrs) {
	for (var index in attrs) {
		if (attrs[index] == 'title') {
			post.title = '12345';
		} else if (attrs[index] == 'content') {
			post.content = '12345678901234567890';
		} else if (attrs[index] == 'createdAt') {
			post.createdAt = new Date();
			post.createdAt.setFullYear(post.createdAt.getFullYear() -1);
		}
	}
}
l
describe('Post Model', function() {
	describe('Miscellaneous', function() {
		it ('should create a new empty Post', function(done) {
			var post = new Post();
			assert(post instanceof Post, 'The post was not created correctly.');
			done();
		});
	});
	
	describe('Validation', function() {
		describe('of Title', function() {
			it('should be valid when the title is correctly set', function(done) {
				var post = new Post();
				setCorrectValues(post, ['title', 'content', 'createdAt']);
				assert.equal(post.isValid(), true);
				done();
			});
			
			it('should be invalid when the title is not set', function(done) {
				var post = new Post();
				setCorrectValues(post, ['content', 'createdAt']);
				assert.equal(post.isValid(), false);
				done();
			});
			
			it('should be invalid when the title is not at least 5 characters', function(done) {
				var post = new Post();
				setCorrectValues(post, ['content', 'createdAt']);
				post.title = '1234';
				assert.equal(post.isValid(), false);
				done();
			});
		});
		
		describe('of Content', function() {
			it('should be valid when the content is correctly set', function(done) {
				var post = new Post();
				setCorrectValues(post, ['title', 'content', 'createdAt']);
				assert.equal(post.isValid(), true);
				done();
			});
			
			it('should be invalid when the content is not set', function(done) {
				var post = new Post();
				setCorrectValues(post, ['title', 'createdAt']);
				assert.equal(post.isValid(), false);
				done();
			});
			
			it('should be invalid when the content is not at least 20 characters', function(done) {
				var post = new Post();
				setCorrectValues(post, ['title', 'createdAt']);
				post.content = '1234567890123456789';
				assert.equal(post.isValid(), false);
				done();
			});
		});
		
		describe('of CreatedAt', function() {
			it('should be valid when createdAt is correctly set', function(done) {
				var post = new Post();
				setCorrectValues(post, ['title', 'content', 'createdAt']);
				assert.equal(post.isValid(), true);
				done();
			});
			
			it('should be invalid when createdAt is not set', function(done) {
				var post = new Post();
				setCorrectValues(post, ['title', 'content']);
				assert.equal(post.isValid(), false);
				done();
			});
			
			it('should be invalid when createdAt is not a date', function(done) {
				var post = new Post();
				setCorrectValues(post, ['title', 'content']);
				post.createdAt = '1,2,3,4,5';
				assert.equal(post.isValid(), false);
				done();
			});
			
			it('should be invalid when createdAt is later than today\'s date', function(done) {
				var post = new Post();
				setCorrectValues(post, ['title', 'content']);
				var today = new Date();
				var testDate = today.setFullYear(today.getFullYear + 1);
				post.createdAt = testDate;
				assert.equal(post.isValid(), false);
				done();
			});
		});
	});
});