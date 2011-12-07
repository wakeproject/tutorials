###
  luminosity.coffee

  view for luminosity simulation
###
define [
  'exports'
], (luminosity) ->

    canvas = document.getElementById("luminosity")
    context = canvas.getContext("2d")
    canvas.width = 1052
    canvas.height = 80

    ls = 0 for i in [0...10520]

    luminosity.paint = (data) ->
        ls.shift()
        ls.push(data)

        context.clearRect(0, 0, 1052, 80)
        for i in [0...1052]
            context.fillStyle = "#ffff00"
            context.fillRect(i, 79, 1, 1)
            context.fillStyle = "#0000ff"
            context.fillRect(i, 40, 1, 1)
            context.fillStyle = "#ff0000"
            context.fillRect(i, 1, 1, 1);

            measure = 0
            cnt = 0
            for k in [0...10]
                l = ls[10 * i + k]
                if (l)
                    measure += ls[10 * i + k]
                    cnt++
            cnt = 1 if (cnt == 0)
            value = 80 - Math.floor(measure / cnt / 2 * 80)

            context.fillStyle = "#000000"
            context.fillRect(i, value, 2, 2)

    luminosity