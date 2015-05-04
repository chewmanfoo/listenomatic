// *********************************************************************************************
// this is essential - it takes data out of the query string i.e. qs["uuid"] == params[:uuid]
// *********************************************************************************************

var qs = (function(a) {
    if (a == "") return {};
    var b = {};
    for (var i = 0; i < a.length; ++i)
    {
        var p=a[i].split('=', 2);
        if (p.length == 1)
            b[p[0]] = "";
        else
            b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
    }
    return b;
})(window.location.search.substr(1).split('&'));

// *********************************************************************************************
// one time action: go get dpoint_graph#data
// json returned: http://104.131.176.82:3000/dpoint_graph/data?uuid=7e39ce0e-19e5-4e5b-923b-b193f11ee266
// *********************************************************************************************

$.ajax({
           type: "GET",
           contentType: "application/json; charset=utf-8",
           url: 'data',
           data: {"uuid":qs["uuid"]},
           dataType: 'json',
           success: function (data) {
               draw(data);
           },
           error: function (result) {
               error();
           }
       });
 

// *********************************************************************************************
// main function for drawing graphs
// *********************************************************************************************

function draw(data) {

  var w = 2000;
  var h = 300;
  var padding = 20;
  var border = 1;
  var bordercolor = "black";
  var ytop = 75;
  var ybot = 90;
  var lines = [];
  var sx = 0;
  var sy = 0;

  //Make an SVG Container
  var svg = d3.select("body").append("svg")
                                      .attr("width", w)
                                      .attr("height", h)
                                      .attr("border",border);

  count=0;

  var borderPath = svg.append("rect")
       			.attr("x", 0)
       			.attr("y", 0)
       			.attr("height", h)
       			.attr("width", w)
       			.style("stroke", bordercolor)
       			.style("fill", "none")
       			.style("stroke-width", border);

  //Create scale functions
  var xScale = d3.scale.linear()
              .domain([d3.min(data, function(d) { return d.uuid_elapsed; }), d3.max(data, function(d) { return d.uuid_elapsed; })])
              .range([padding, w - padding * 2]);

  var yScale = (function(d) {
    x = xScale(d.uuid_elapsed);

    if (phase == d.sabre_phase) {
      // don't change the y coordinate - return the same y coordinate
      rval=varyy;
    } else {
      // record lines startx, starty
      // we know the old phase (phase), we need to find it in lines
      // and store the values sx, sy, the last x,y for a line
      if ( lines.length != 0 ) {
          for (var i=0;i<lines.length;i++) {
            var theHash = lines[i];
            if (theHash.phase == phase) {
              console.info("found theHash where phase = " + phase + " so we record " + sx + " and " + sy );
              theHash['sx'] = sx;
              theHash['sy'] = sy;
              console.info("storing [sx = " + theHash.sx + ", sy = " + theHash.sy + " where phase = " + theHash.phase + "]" );
            }
          }
          //lines is an array of hashes - each has is ["phase" : "ph1", "x": x, "y": y]
          //phase is the current phase (the phase of the last dot painted)
          //find the hash in lines with the "phase" == phase
          //add sx, sy to that hash 
      }
      // change the y coordinate - return a new y coordinate
      if (varyy == ytop) {
        varyy = ybot;
      } else {
        varyy = ytop;
      }

      rval=varyy;

      phase = d.sabre_phase;

      var h = {};
      h['x'] = x;
      h['y'] = rval;
      // save x and y
      h['phase'] = phase;
      console.info("pushing [x = " + h.x + ", y = " + h.y + ", phase = " + h.phase + "]" );
      lines.push(h);
    }

    sx = x;
    sy = rval;

    return rval;
  });

  //Draw the Circles
  varyy = 0;
  ccolor="black";
  phase="";

  //Add div for mouseover
  var div = d3.select("body").append("div")   
    .attr("class", "tip")              
    .style("opacity", 0);

  svg.selectAll("dot")    
        .data(data)         
        .enter().append("circle")                               
        .attr("r", 5)       
        .attr("cx", function(d) { return xScale(d.uuid_elapsed); })       
        .attr("cy", function(d) { return yScale(d); })     
        .on("mouseover", function(d) {      
            div.transition()        
                .duration(200)      
                .style("opacity", .9);      
            div .html("<b>Elapsed:</b>" + d.uuid_elapsed + "<br />" + "<b>Phase:</b>" + d.sabre_phase + "<br />" + "<b>Task:</b>" + d.task + "<br />" + "<b>Timestamp:</b>" + d.timestamp)  
                .style("left", (d3.event.pageX) + "px")     
                .style("top", (d3.event.pageY - 28) + "px");    
            })                  
        .on("mouseout", function(d) {       
            div.transition()        
                .duration(500)      
                .style("opacity", 0);   
        });

  if ( lines.length != 0 ) {
          for (var i=0;i<lines.length;i++) {
            var theHash = lines[i];
            if (theHash.phase == phase) {
              console.info("found theHash where phase = " + phase + " so we record " + sx + " and " + sy );
              theHash['sx'] = sx;
              theHash['sy'] = sy;
              console.info("storing [sx = " + theHash.sx + ", sy = " + theHash.sy + " where phase = " + theHash.phase + "]" );
            }
          }
  }

//console.info("lines: " + lines.length);

        for (var i=0;i<lines.length;i++) {
          var myHash = lines[i];
          var pad = 7;
          var startx = myHash.x - pad;
          var starty = myHash.y - pad;
          var endx = myHash.sx + pad;
          var endy = myHash.sy - pad ;
          var hph = myHash.phase;
          var box_height = 14;
          var hashy = 100;
          var hashlength = 20;

//Draw the Rectangles
// boxes are from startx, starty to endx, (starty - box_height)
 
          var lineData = [ { "x": startx, "y": starty}, { "x": startx, "y": (starty + box_height)},
                           { "x": endx, "y": (endy + box_height)}, { "x": endx, "y": starty},
                           { "x": startx, "y": starty} ];

//console.info("drawing " + lineData + " where phase is " + hph);
          var lineFunction = d3.svg.line()
                               .x(function(d) { return d.x; })
                               .y(function(d) { return d.y; })
                               .interpolate("linear");
          var lineGraph = svg.append("path")
                              .attr("d", lineFunction(lineData))
                              .attr("stroke", "blue")
                              .attr("stroke-width", 1)
                              .attr("fill", "none");
          
          var hashData = [ { "x": startx, "y": hashy }, { "x": startx, "y": (hashy + hashlength) }];

          var lineGraph = svg.append("path")
                              .attr("d", lineFunction(hashData))
                              .attr("stroke", "black")
                              .attr("stroke-width", 1)
                              .attr("fill", "none");

          var hashData = [ { "x": endx, "y": hashy }, { "x": endx, "y": (hashy + hashlength) }];

          var lineGraph = svg.append("path")
                              .attr("d", lineFunction(hashData))
                              .attr("stroke", "black")
                              .attr("stroke-width", 1)
                              .attr("fill", "none");
 
//        break;
        }
}
 
function error() {
    console.log("error")
}
