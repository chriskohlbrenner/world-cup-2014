var dataset = gon.player_goals;
var svgWidth = 500;
var svgHeight = 400;
var barPadding = 1;

var svg = d3.select(".player-goals")
            .append("svg")
            .attr("width", svgWidth)
            .attr("height", svgHeight);

svg.selectAll("rect")
    .data(dataset)
    .enter()
    .append("rect")
    .attr("class","bar")
    .attr("data-player-team", function(d) {return d[0];})
    .attr("data-player-image", function(d) {return d[1];})
    .attr("x", function(d, i) {
      return i * (svgWidth / dataset.length);
    })
    .attr("width", svgWidth / dataset.length - barPadding)
    .attr("height", function(d) {
      return (d[2] * 75) + 30;
    })
    .attr("y", function(d){
      return svgHeight - (d[2] * 75);
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
  $('img#player').attr("src", currentBar.getAttribute("data-player-image"));
  $('p#player-p').text(currentBar.getAttribute("data-player-team"))
})