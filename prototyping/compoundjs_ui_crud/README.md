# UI for Goal Setting TPOUser data CRUD

## CompoundJS + JugglingDB + MongoDB version

$ cd __HERE__

$ npm install -l

$ node server.js

This will start a server listening in 3000 for MongoDB's CRUD.

The Database name/Collection name: tests/Test

## DB Structure (Test Collection):

name: String
info {
 first_name: String
 last_name: String
 phone: String
 e_mail: String
}
count {
 contacts: Number
 prospects: Number
 closings: Number
 listings: Number
}
createdAt: Date
active: Boolean

$$
$$
$$
