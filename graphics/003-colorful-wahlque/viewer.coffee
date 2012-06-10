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
    canvas.width = 512
    canvas.height = 512

    color = (height, factor) ->
        r = 128
        b = 192
        r = Math.floor(height / 48 ) if height > 8192
        r = 255 if r > 255
        b = Math.floor(320 - height / 64) if height < 8192
        b = 255 if b > 255
        g = Math.floor((r + b) / 1.5)
        g = 255 if g > 255

        factor = Math.sqrt(factor)
        factor = Math.sqrt(factor)
        r = Math.floor(r * factor)
        g = Math.floor(g * factor)
        b = Math.floor(b * factor)

        hexR = Math.round(r).toString(16)
        hexR = '0' + hexR if hexR.length == 1
        hexB = Math.round(b).toString(16)
        hexB = '0' + hexB if hexB.length == 1
        hexG = Math.round(g).toString(16)
        hexG = '0' + hexG if hexG.length == 1

        "#" + hexR + hexG + hexB

    viewer.paint = (params, data) ->
        context.clearRect(0, 0, 512, 512)
        [num, len, heights] = data
        for row in [0...num]
            for col in [0...num]
                lng = 2 * Math.PI * col / num
                lat = Math.PI * (0.5 - row / num)
                [position, factor] = params(lng, lat)
                [x, y] = position
                if x != -1 && y != -1
                    pos = row * num + row + col
                    height = heights[pos] / 64

                    context.fillStyle = color(height, factor)
                    context.fillRect(Math.floor(256 + 250 * x), Math.floor(256 + 250 * y), 5, 5)

    viewer