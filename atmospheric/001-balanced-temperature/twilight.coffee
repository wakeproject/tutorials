###
  twilight.coffee

  view for twilight simulation
###
define [
  'exports'
], (twilight) ->

    canvas = document.getElementById("twilight")
    context = canvas.getContext("2d")
    canvas.width = 512
    canvas.height = 512

    twilight.paint = (data) ->
        context.clearRect(0, 0, 512, 512)
        for i in [0...256]
            for j in [0...256]
                [blue, yellow] = data[i][j]

                blue = 256 * blue
                blue = 255 if blue > 255
                hexB = Math.round(blue).toString(16)
                hexB = '0' + hexB if hexB.length == 1

                yellow = 256 * yellow
                yellow = 255 if yellow > 255
                hexY = Math.round(yellow).toString(16)
                hexY = '0' + hexY if hexY.length == 1

                fill = "#" + hexY + hexY + hexB
                context.fillStyle = fill
                context.fillRect(2 * i, 2 * j, 2, 2)

    twilight