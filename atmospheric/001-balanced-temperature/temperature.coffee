###
  temperature.coffee

  view for temperature simulation
###
define [
  'exports'
], (temperature) ->

    canvas = document.getElementById("temperature")
    context = canvas.getContext("2d")
    canvas.width = 256
    canvas.height = 512

    pos = (t) -> Math.round((t - 200) / 200 * 256)
    temperature.paint = (data) ->
        context.clearRect(0, 0, 256, 512)
        for i in [0...256]
            context.fillStyle = "#ffff00"
            context.fillRect(pos(263.15), 2 * i, 2, 2)
            context.fillStyle = "#ff0000"
            context.fillRect(pos(373.15), 2 * i, 2, 2);
            context.fillStyle = "#ffffff"
            context.fillRect(pos(data[i]), 2 * i, 2, 2)

    temperature
