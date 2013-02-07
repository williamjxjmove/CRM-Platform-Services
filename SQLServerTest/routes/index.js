var Connection = require('tedious').Connection;
var Request = require('tedious').Request;

function executeStatement(connection, res) {
    var records = [];

    var request = new Request('select * from customers', function (err, rowCount) {
        console.log('--- Entered request');
        if (err) {
            console.log(err);
        } else {
            console.log(rowCount + ' rows');
        }
        console.log('--- request ended');

        res.render('index', { title: 'Customers', records: records });
    });

    request.on('row', function (columns) {
        console.log('--- Row event');
        columns.forEach(function (column) {
            console.log(column.value);
        });

        var record = {
            customer_id: columns['customer_id'].value,
            firstName: columns['firstName'].value,
            lastName: columns['lastName'].value
        };
        records.push(record);

        console.log('--- Row event complete');
    });

    console.log('--- Before execSql');
    connection.execSql(request);
    console.log('--- After execSql');
};

/*
 * GET home page.
 */
exports.index = function (req, res) {
    var config = {
        userName: 'nodeuser',
        password: 'P@ssw0rd',
        server: '10.1.1.148',
        options: {
            port: 1433,
            database: 'nodetest'
        }
    };
    console.log('--- Creating connection');
    var connection = new Connection(config);
    console.log('--- Connection created');
    connection.on('connect', function (err) {
        if (err) {
            console.log(err);
        } else {
            console.log('--- Connected to SQL Server');
        }

        executeStatement(connection, res);
    });
};
