 var raio = 30;
var space = 30;
var heightSpace = -150;
var startY = 15;
var timeTransiction = 600;
var baseLeaveLink = "";
var basePickLink = "";
var stage = d3.select("#chart")
  .append("svg")
  .attr("width", 1360)
  .attr("height", 700);
stage.append("svg:defs")
  .append("svg:marker")
  .attr("id", "arrow")
  .attr("refX", 2)
  .attr("refY", 6)
  .attr("markerWidth", 13)
  .attr("markerHeight", 13)
  .attr("orient", "auto")
  .append("svg:path")
  .attr("d", "M2,2 L2,11 L10,6 L2,2");;
var line = d3.svg.line()
                 .x( function(point) { return point.lx; })
                 .y( function(point) { return point.ly; });

var tip = d3.tip()
  .attr('class', 'd3-tip')
  .offset([0, 0])
  .html(function(d) {
    return "<strong>Title:</strong> <span style='color:red'>" + d.title + "</span>";
  });
stage.call(tip);
function lineData(d){
    var points = [
        {lx: d.source.x, ly: d.source.y},
        {lx: d.target.x, ly: d.target.y}
    ];
    return line(points);
}
function translateAlong(path) {
  var l = path.getTotalLength();
    var ps = path.getPointAtLength(0);
    var pe = path.getPointAtLength(l);
    var angl = Math.atan2(pe.y - ps.y, pe.x - ps.x) * (180 / Math.PI) - 90;
    var rot_tran = "rotate(" + angl + ")";
    return function(d, i, a) {
      return function(t) {
        var p = path.getPointAtLength(t * l);
        return "translate(" + p.x + "," + p.y + ") " + rot_tran;
      };
  };
}

function createLines(rootNode, level) {
  var children;
  rootNode.each(function(d,i) {
    children = d3.selectAll(this.childNodes);
  });
  var circle;
  var groups = [];
  children.each(function() {
    switch (this.tagName.toLowerCase()) {
      case "circle":
        circle = this;
        break;
      case "g" :
        groups.push(this);
        break;
    }
  });
  var source = {x: circle.cx.baseVal.value, y: circle.cy.baseVal.value - circle.r.baseVal.value};
  var targetX = 0
  for (var i = 0; i < groups.length; i++) {
    targetX += groups[i].getBoundingClientRect().width / 2;
    var target = { x: targetX, y: heightSpace + (raio * 2)}
    var path = rootNode.append("path")
      .data([{source: source, target: target}])
      .attr("class", "line")
      .style("display", "none")
      .attr("d", lineData);
    var arrow = rootNode.append("svg:path")
      .style("display", "none")
      .attr("d", d3.svg.symbol().type("triangle-down")(10,1));
    arrow.transition()
      .delay(level *  timeTransiction + timeTransiction)
      .style("display", "inline")
      .duration(timeTransiction)
      .ease("cubic-out")
      .attrTween("transform", translateAlong(path.node()));
    var totalLength = path.node().getTotalLength();
    path.attr("stroke-dasharray", totalLength + " " + totalLength)
      .attr("stroke-dashoffset", totalLength)
      .transition()
      .delay(level * timeTransiction + timeTransiction)
      .style("display", "inline")
      .duration(timeTransiction)
      .ease("cubic-out")
      .attr("stroke-dashoffset", 0);
    targetX += groups[i].getBoundingClientRect().width / 2 + space;
  }
}

function createNode(obj) {
  var node = stage.append("circle")
    .attr("r", raio);
}

function printSpace(level) {
  var spaces = level * 4;
  var result = "";
  for (var i = 0; i < spaces; i++) {
    result += " ";
  }
  return result;
}
function setBaseLinks() {
  if (baseLeaveLink === "") {
    baseLeaveLink = $("#taskModal #modal-leave").attr("href");
    baseLeaveLink = baseLeaveLink.substr(0, baseLeaveLink.lastIndexOf("/") + 1);
  }
  if (basePickLink === "") {
    basePickLink = $("#taskModal #modal-pick").attr("href");
    basePickLink = basePickLink.substr(0, basePickLink.lastIndexOf("=") + 1);
  }
}
function createCircle(baseGroup, obj, level) {
  var data = [];
  data.push(obj);
  return baseGroup.selectAll("circle")
    .data(data)
    .enter()
    .append("circle")
    .style('opacity', 0)
    .attr("r", raio)
    .attr("cx", raio)
    .attr("cy", raio)
    .on("click", function(d) {
      var users = "";
      for (var i = 0; i < d.users.length; i++) {
        if (users !== "")
          users += ", ";
        users += d.users[i].name;
      }
      var description = d.description;
      if (users !== "")
        description += "<div>" + users + "</div>";
      setBaseLinks();
      $("#taskModal .modal-title").html(d.title)
      $("#taskModal .modal-body").html(description)
      $("#taskModal #modal-leave").attr("href", baseLeaveLink + d.id + "?source=tree");
      $("#taskModal #modal-pick").attr("href", basePickLink + d.id + "&source=tree");
      $("#taskModal #modal-complete").attr("href", "/tasks/complete?id=" + d.id);
      if (d.aasm_state !== "complete") {
        if (d.on_task) {
          $("#taskModal #modal-leave").show();
          $("#taskModal #modal-pick").hide();
          $("#taskModal #modal-complete").show();
        } else {
          $("#taskModal #modal-leave").hide();
          $("#taskModal #modal-pick").show();
          $("#taskModal #modal-complete").show();
        }

      } else {
        $("#taskModal #modal-leave").hide();
        $("#taskModal #modal-pick").hide();
        $("#taskModal #modal-complete").hide();
      }
      $("#taskModal").modal("show");
    })
    .on('mouseover', tip.show)
    .on('mouseout', tip.hide)
    .classed(obj.aasm_state, true);
}

function buidTree(obj, baseGroup, level) {
  if (obj === undefined) return;
  var x = 0;
  var y = heightSpace;
  for (var i = 0; i < obj.length; i++) {
    var group = baseGroup.append("g");
    var circle = createCircle(group, obj[i], level);
    //console.log(printSpace(level) + obj[i].title);
    buidTree(obj[i].children, group, level + 1);
    var circles = group.select("circles");
    group.attr("transform", "translate("+x+","+y+")");
    x += space + group.node().getBoundingClientRect().width;
    circle.attr("cx", group.node().getBoundingClientRect().width/2);
    circle.transition()
      .style('opacity', 1)
      .delay(level * timeTransiction)
      .duration(timeTransiction);
    createLines(group, level);
  }
}

function startBuildTree(obj) {
  console.log(obj.title);
  var group = stage.append("g");
  var circle = createCircle(group, obj, 0);
  buidTree(obj.children, group, 1);
  var x = (1360 - group.node().getBoundingClientRect().width) / 2;
  var y = 700 - (raio * 2);
  group.attr("transform", "translate("+x+","+y+")");
  circle.attr("cx", group.node().getBoundingClientRect().width/2);
  circle.transition()
    .style('opacity', 1)
    .duration(timeTransiction);

  createLines(group, 0);
}

var sprintId = $("#sprint-id").html()

$.ajax({
  url: "/sprints/" + sprintId + "/tasks.json",
  method: "GET",
  success: function(data){
    startBuildTree(data.root);
  },
  error: function(){
    console.log("Error happened!");
  }
});
