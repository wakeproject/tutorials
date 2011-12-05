###
  orbit.coffee

  view for simulation
###
define [
  'underscore',
  'exports'
], (_, orbit) ->

    canvas = document.getElementById("canvas")
    context = canvas.getContext("2d")
    canvas.width = 512
    canvas.height = 512

    s = (x) -> 256 + 40 * x

    circle = (centerX, centerY, radius, color) ->
        context.beginPath()
        context.arc(centerX, centerY, radius, 0, 2 * Math.PI, false)
        context.fillStyle = color
        context.fill()
        context.closePath()

    orbit.paint = (data) ->
        [x1, y1, vx1, vy1, x2, y2, vx2, vy2, x3, y3, vx3, vy3] = data
        context.clearRect(0, 0, 512, 512)
        circle(s(x1), s(y1), 6, "blue")
        circle(s(x2), s(y2), 4, "yellow")
        circle(s(x3), s(y3), 2, "gray")

    orbit