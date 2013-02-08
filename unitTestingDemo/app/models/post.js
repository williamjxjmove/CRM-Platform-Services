module.exports = function (compound, Post) {
  // define Post here
  
  // title
  Post.validatesLengthOf('title', { min: 5, allowNull: false });
  
  // content
  Post.validatesLengthOf('content', { min: 20, allowNull: false });
  
  // createdAt
  Post.validatesPresenceOf('createdAt');
  Post.validate('createdAt', function(err) {
  	// Check to see that it is a Date
  	if (!(this.createdAt instanceof Date))
  		err();
  	// Check to see that the date is older than now.
  	if (this.createdAt >= new Date())
  		err();
  });
};