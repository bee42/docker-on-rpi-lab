var http    = require("http"),
    os      = require("os"),
    moment  = require("moment"),
    chance  = require("chance"),
    winston = require("winston"),    
    util    = require("util");

// Default port is 8080, overridden by PORT env variable if provided
var port = process.env.PORT || 8080;

http.createServer(function(request, response) {
    winston.log("info", util.format("[%s] -> new request", moment().toISOString()));
    response.writeHead(200, { 'Content-Type': 'application/json' });
    response.end(JSON.stringify({ message: util.format("%s suggests to visit %s", os.hostname(), chance().city())}));
}).listen(port);

winston.log("info", util.format("waiting for request on port %s", port));