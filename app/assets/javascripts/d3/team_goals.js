var dataset = gon.team_goals;
var svgWidth = 500;
var svgHeight = 400;
var barPadding = 1;

var svg = d3.select(".team-goals")
            .append("svg")
            .attr("width", svgWidth)
            .attr("height", svgHeight);

svg.selectAll("rect")
    .data(dataset)
    .enter()
    .append("rect")
    .attr("class","bar")
    .attr("data-team", function(d) {return d[0];})
    .attr("data-team-image", function(d) {return d[1];})
    .attr("data-goals-for", function(d) {return d[3];})
    .attr("x", function(d, i) {
      return i * (svgWidth / dataset.length);
    })
    .attr("width", svgWidth / dataset.length - barPadding)
    .attr("height", function(d) {
      return (d[2] * 30) + 30;
    })
    .attr("y", function(d){
      return svgHeight - (d[2] * 30) - 10;
    });

svg.selectAll("text")
    .data(dataset)
    .enter()
    .append("text")
    .text(function(d) {
      return d[2];
    })
    .attr("x", function(d, i) {
      return (i * (svgWidth / dataset.length)) + (svgWidth / dataset.length - barPadding) / 2;
    })
    .attr("y", function(d) {
      return svgHeight - (d[2] * 3);
    })
    .attr("class","bar-text")
    .attr("text-anchor", "middle");

$('.bar').hover(function(){
  var currentBar = this
  // console.log(currentBar)
  $('img#team').attr("src", currentBar.getAttribute("data-team-image"))
  $('p.team').text(currentBar.getAttribute("data-team") + "(" + currentBar.getAttribute("data-goals-for") + " goals/game)")
})