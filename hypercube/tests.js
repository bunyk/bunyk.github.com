stop(); // QUnit wait till code for testing is loaded;
require(['matrix', 'hypercube'], function(Matrix, hypercube) {
    start();
    test("Matrix", function() {
        ok(new Matrix());
    });
});
