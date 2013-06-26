"use strict";

define(['hypercube/matrix', 'hypercube/hypercube'], function(Matrix, hypercube) {
    var run = function () {
        module("Hypercube tests");
        test("Matrix can be created", function() {
            ok(new Matrix());
        });
    };
    return {run: run};
});
