###
  temperature.coffee

  view for temperature simulation
###
define [
  'exports'
], (temperature) ->

    canvas = document.getElementById("temperature")
    context = canvas.getContext("2d")
    canvas.width = 64
    canvas.height = 512

    pos = (t) -> Math.round((t - 200) / 200 * 64)
    temperature.paint = (data) ->
        context.clearRect(0, 0, 64, 512)
        for i in [0...512]
            context.fillStyle = "#ffff00"
            context.fillRect(pos(273), i, 1, 1)
            context.fillStyle = "#ff0000"
            context.fillRect(pos(373), i, 1, 1);
            value = pos(data[i])
            context.fillStyle = "#000000"
            context.fillRect(value, i, 1, 1)

    temperature
