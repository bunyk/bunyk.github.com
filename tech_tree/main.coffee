# REQUIRE d3
# REQUIRE jquery

$ = jQuery

$(() ->
    $('.widget_block').show()

    svg = d3.select('.widget_block')
            .append('svg')
            .attr("width", 300)
            .attr("height", 300)

    svg.append('circle')
        .attr('cx', 150) # x coord of center
        .attr('cy', 150) # y coord of center
        .attr('r', 50) # radius
)
() -> (
diameter = 900

tree = d3.layout.tree()
    .size([360, diameter / 2 - 120])
    .separation (a, b) ->
        (if (a.parent == b.parent) then 1 else 2) / a.depth

diagonal = d3.svg.diagonal.radial()
    .projection (d) ->
        [d.y, d.x / 180 * Math.PI]

svg = d3.select(".widget_block").append("svg")
    .attr("width", diameter)
    .attr("height", diameter - 150)
    .append("g")
    .attr("transform", "translate(#{diameter / 2}, #{diameter / 2})")

draw_tree = (root) ->
  nodes = tree.nodes(root)
  links = tree.links(nodes)

  link = svg.selectAll(".link")
      .data(links)
      .enter().append("path")
      .attr("class", "link")
      .attr("d", diagonal)

  node = svg.selectAll(".node")
      .data(nodes)
      .enter().append("g")
      .attr("class", "node")
      .attr("transform", (d) -> "rotate( #{d.x - 90})translate(#{d.y})")

  node.append("circle")
      .attr("r", 4.5)

  node.append("text")
      .attr("dy", ".31em")
      .attr("text-anchor", (d) -> if d.x < 180 then "start" else "end")
      .attr("transform", (d) -> if d.x < 180 then "translate(8)" else "rotate(180)translate(-8)")
      .text((d) -> d.name)

d3.select(self.frameElement).style("height", diameter - 150 + "px")

draw_tree {
 "name": "flare",
 "children": [
  { "name": "analytics" },
  { "name": "asdasf" },
  { "name": "asdfsd11111;", children: [
      { "name": "1" },
      { "name": "2" },
      { "name": "3" },
  ]},
  { "name": "taras" },
 ]
}

)
