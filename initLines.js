
var fs = require('fs')

var numLines = 22; // number of lines to generate
var padding = 150;
var width = padding+1024-padding; // canvas width
var height = padding+768-padding; // canvas height

var _lines = []

for (var i = 0; i < numLines; i++) {
  _lines.push({
    x1: Math.floor(Math.random()*width),
    y1: Math.floor(Math.random()*height),
    x2: Math.floor(Math.random()*width),
    y2: Math.floor(Math.random()*height),
  })
}

var lines = { lines: _lines }
fs.writeFileSync('./data/lines.json', JSON.stringify(lines, null, 2))
