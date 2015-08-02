// REQUIRE angular
// REQUIRE underscore
// REQUIRE ../dodecahedron/cal.coffee

var app = angular.module('calendar', []);

app.controller('CalendarController', function() {
    this.year = (new Date()).getFullYear();
    this.range = _.range;

    this.get_month = function(n) {
        return cal.text(this.year, n);
    };
});
