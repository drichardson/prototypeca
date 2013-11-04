console.log("displayLink.js loading");

// Use DisplayLink if you want to draw at the same rate the screen is updated, but no more than that.
var displayLink = DisplayLink();
displayLink.callback = function() {
    console.log("displayLink callback called");
}
displayLink.start();

