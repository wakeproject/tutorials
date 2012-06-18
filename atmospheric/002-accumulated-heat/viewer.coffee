###
  viewer.coffee

  view for generation
###
define [
  'cs!/wahlque/physics/units/si'
  'exports'
], (si, viewer) ->

    canvas = document.getElementById("canvas")
    context = canvas.getContext("2d")
    canvas.width = 512
    canvas.height = 512
    sc = si.solarConst

    colorGeo = (height) ->
        r = 128
        b = 192
        r = Math.floor(height / 48) if height > 8192
        r = 255 if r > 255
        b = Math.floor(320 - height / 64) if height < 8192
        b = 255 if b > 255
        g = Math.floor((r + b) / 1.5)
        g = 255 if g > 255

        hexR = Math.round(r).toString(16)
        hexR = '0' + hexR if hexR.length == 1
        hexB = Math.round(b).toString(16)
        hexB = '0' + hexB if hexB.length == 1
        hexG = Math.round(g).toString(16)
        hexG = '0' + hexG if hexG.length == 1

        "#" + hexR + hexG + hexB

    colorHeat = (idx) ->
        r = 128 / 128 * idx
        b = 0
        g = 0

        hexR = Math.round(r).toString(16)
        hexR = '0' + hexR if hexR.length == 1
        hexB = Math.round(b).toString(16)
        hexB = '0' + hexB if hexB.length == 1
        hexG = Math.round(g).toString(16)
        hexG = '0' + hexG if hexG.length == 1

        "#" + hexR + hexG + hexB

    azimuthal = (positioning, geodata) ->
        [num, len, heights] = geodata
        for row in [0...num]
            for col in [0...num]
                lng = 2 * Math.PI * col / num
                lat = Math.PI * (0.5 - row / num)
                [x, y] = positioning(lng, lat)
                if x != -1 && y != -1
                    pos = row * num + row + col
                    height = heights[pos] / 64

                    context.fillStyle = colorGeo(height)
                    context.fillRect(Math.floor(128 + 250 * x), Math.floor(128 + 250 * y), 5, 5)

    lng = (col) -> 2 * Math.PI * col / 128
    lat = (row) -> Math.PI * (0.5 - row / 128)
    find = (array, src, trgt, value) ->
        points = []
        idx = src
        while (idx < trgt)
            d1 = array[idx] - value
            d2 = array[idx + 1] - value
            if d1 * d2 <= 0
                if Math.abs(d1) < Math.abs(d2)
                    point = idx - src
                else
                    point = idx + 1 - src
                points.push(point)
            idx++
        points
    contour = (positioning, heatdata) ->
        [num, len, heats] = heatdata
        for row in [0...num]
            cur = num * row
            for idx in [1...num]
                value = sc / num * idx
                points = find(heatdata, cur, cur + num - 1, value)
                for col in points
                    [x, y] = positioning(lng(col), lat(row))
                    if x != -1 && y != -1
                        context.fillStyle = colorHeat(idx)
                        context.fillRect(Math.floor(256 + 250 * x), Math.floor(256 + 250 * y), 4, 4)

    viewer.paint = (positioning, geodata, heatdata) ->
        context.clearRect(0, 0, 512, 512)
        azimuthal(positioning, geodata)
        contour(positioning, heatdata)

    viewer