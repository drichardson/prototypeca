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
