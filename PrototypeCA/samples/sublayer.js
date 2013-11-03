console.log("Creating 1 sublayer of rootLayer");
rootLayer.backgroundColor = rgb(1,0,0);

var l = Layer();
l.backgroundColor = rgb(0,0,1);
l.frame = rectangle(20,20,100,100);

console.log("Adding sublayer " + l);
rootLayer.addSublayer(l);
