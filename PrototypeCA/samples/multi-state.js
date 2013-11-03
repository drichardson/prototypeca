console.log("Multi state loading");


var state1 = function() {
    console.log("Multi state loading 1");
    rootLayer.backgroundColor = rgb(1,0,0);
}

var state2 = function() {
    console.log("Multi state loading 2");
    rootLayer.backgroundColor = rgb(0,1,0);
}

var state3 = function() {
    console.log("Multi state loading 3");
    rootLayer.backgroundColor = rgb(0,0,1);
}

var nextState = 0;
var states = [ state1, state2, state3 ];

var processNextState = function() {
    var state = states[nextState];
    nextState = (nextState+1) % states.length;
    state();
}

processNextState();

eventHandler = function(e) {
    if (e.direction == "down") {
        console.log("key code is " + e.keyCode);
        if (e.keyCode == 124) { // arrow right
            processNextState();
        } else if (e.keyCode == 123) { // arrow left
            console.log("unimplemented");
        }
    }
}

