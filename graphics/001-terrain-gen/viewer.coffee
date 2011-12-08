###
  viewer.coffee

  view for generation
###
define [
  'underscore',
  'exports'
], (_, viewer) ->

    canvas = document.getElementById("canvas")
    context = canvas.getContext("2d")
    canvas.width = 3072
    canvas.height = 2048

    color = (height) ->
        r = 128
        b = 192
        r = Math.floor(height / 64) if height > 8192
        b = Math.floor(320 - height / 64) if height < 8192
        g = Math.floor((r + b) / 1.5)
        g = 255 if g > 255

        hexR = Math.round(r).toString(16)
        hexR = '0' + hexR if hexR.length == 1
        hexB = Math.round(b).toString(16)
        hexB = '0' + hexB if hexB.length == 1
        hexG = Math.round(g).toString(16)
        hexG = '0' + hexG if hexG.length == 1

        "#" + hexR + hexG + hexB

    viewer.paint = (data) ->
        context.clearRect(0, 0, 3072, 2048)

        [num, len, heights] = data
        width = 1024 / num
        for row in [0..num]
            for col in [0..num]
                pos = row * num + row + col
                height = heights[pos] / 64
                context.fillStyle = color(height)
                context.fillRect(3 * width * col, 2 * width * row, 3 * width, 2 * width)

    viewer