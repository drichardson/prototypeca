// runtime.js
// This is the part of the PrototypeCA JavaScript runtime that
// is written in JavaScript. This script is evaluated after the
// native PrototypeCA JavaScript runtime is initialized.

/// Create a color object from red, green, blue, and alpha components. Each
/// components should be between 0 and 1.
var rgba = function(red, green, blue, alpha) {
    return { "red" : red, "green" : green, "blue" : blue, "alpha" : alpha};
}

/// Create a color object from red, green, and blue components. Each
/// components should be between 0 and 1.
var rgb = function(red, green, blue) {
    return rgba(red, green, blue, 1);
}

/// Create a 2 dimentional point object from an x and y coordinate.
var point = function(x, y) {
    return { "x" : x, "y" : y };
}

/// Create a size object from a width and height.
var size = function(width, height) {
    return { "width" : width, "height" : height };
}

/// Create a rectangle object with origin at (x,y) with the given width and height.
var rectangle = function(x, y, width, height) {
    return { "x" : x, "y" : y, "width" : width, "height" : height }
}

/// Log an object, enumerating it's fields.
var describe = function(object) {
    console.log("describe called");
    for(var propertyName in object) {
        console.log(propertyName + ': ' + object[propertyName]);
    }
    console.log("describe ending");
}
