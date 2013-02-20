module.exports = 
  { "development":
    { "driver":   "mongodb", "url": "mongodb://localhost/tests"
    }
  , "test":
    { "driver":   "memory"
    }
  , "production":
    { "driver":   "memory"
    }
  };
