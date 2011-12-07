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
        for i in [0...511]
            for j in [0...511]
                [blue, yellow] = data[i][j]

                blue = blue * 2048
                blue = blue > 255 ? 255 : blue
                hexB = Math.round(blue).toString(16)
                hexB = '0' + hexB if hexB.length == 1

                yellow = yellow * 8192;
                yellow = yellow > 255 ? 255 : yellow
                hexY = Math.round(yellow).toString(16)
                hexY = '0' + hexY if hexY.length == 1

                fill = "#" + hexY + hexY + hexB
                context.fillStyle = fill
                context.fillRect(i, j, 1, 1)

    twilight