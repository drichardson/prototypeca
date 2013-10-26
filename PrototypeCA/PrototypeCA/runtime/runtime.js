// runtime.js - JavaScript implemented portion of the runtime.
// This runs after the native implementation is setup. Convenience
// objects live in this file.

console.log("runtime.js running");

console.log("point is " + point);

point.makePointXY = function(var x, y) {
    var p = new point();
    p.x = x;
    p.y = y;
    return p;
}

point.howdy = function() {
    console.log("howdy called");
}

point.howdy();


console.log("runtime.js loaded");
