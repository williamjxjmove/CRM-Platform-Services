load('application');

before(loadTest, {
    only: ['show', 'edit', 'update', 'destroy']
    });

action('new', function () {
    this.title = 'New test';
    this.test = new Test;

    render();
});

action(function create() {
    Test.create(req.body.Test, function (err, test) {
        respondTo(function (format) {
            format.json(function () {
                if (err) {
                    send({code: 500, error: test && test.errors || err});
                } else {
                    send({code: 200, data: test.toObject()});
                }
            });
            format.html(function () {
                if (err) {
                    flash('error', 'Test can not be created');
                    render('new', {
                        test: test,
                        title: 'New test'
                    });
                } else {
                    flash('info', 'Test created');
                    redirect(path_to.tests);
                }
            });
        });
    });
});

action(function index() {
    this.title = 'Tests index';
    Test.all(function (err, tests) {
        switch (params.format) {
            case "json":
                send({code: 200, data: tests});
                break;
            default:
                render({
                    tests: tests
                });
        }
    });
});

action(function show() {
    this.title = 'Test show';
    switch(params.format) {
        case "json":
            send({code: 200, data: this.test});
            break;
        default:
            render();
    }
});

action(function edit() {
    var test = this.test;
    console.log(params);
    console.log('bbbbbbbbbbbb');
    this.title = 'Test edit';
    //params.format = 'json'; correct.
    switch(params.format) {
        case "json":
            console.log(this.test);
            send(this.test);
            break;
        default:
            //console.log(test);
            console.log('ccccccccccccc');
            render({
                'test': test
            });
    }
});

action(function update() {
    var test = this.test;
    this.title = 'Edit test details';
    this.test.updateAttributes(body.Test, function (err) {
        respondTo(function (format) {
            format.json(function () {
                if (err) {
                    send({code: 500, error: test && test.errors || err});
                } else {
                    send({code: 200, data: test});
                }
            });
            format.html(function () {
                if (!err) {
                    flash('info', 'Test updated');
                    redirect(path_to.test(test));
                } else {
                    flash('error', 'Test can not be updated');
                    render('edit');
                }
            });
        });
    });
});

action(function destroy() {
    this.test.destroy(function (error) {
        respondTo(function (format) {
            format.json(function () {
                if (error) {
                    send({code: 500, error: error});
                } else {
                    send({code: 200});
                }
            });
            format.html(function () {
                if (error) {
                    flash('error', 'Can not destroy test');
                } else {
                    flash('info', 'Test successfully removed');
                }
                send("'" + path_to.tests + "'");
            });
        });
    });
});

function loadTest() {
    Test.find(params.id, function (err, test) {
        if (err || !test) {
            if (!err && !test && params.format === 'json') {
                return send({code: 404, error: 'Not found'});
            }
            redirect(path_to.tests);
        } else {
            this.test = test;
            next();
        }
    }.bind(this));
}
