###
  avgtfield.coffee

  average temperature filed along latitude
###
define [
    'exports'
], (avgt) ->

    lat = (j) -> Math.PI / 256 * (128 - j)
    absorb = (t) -> (t > 263.15) ? 0.7 : 0.3
    rau = (t) ->
        if t < 263.15
            21060000
        else if t < 273.15
            334000000
        else if t < 373.15
            42180000
        else if t < 383.15
            2250000000

    da = 2 * Math.PI / 256 / 2
    dC = (lat) ->
        if Math.abs(Math.PI / 2 - Math.abs(lat)) < da
            da * da * 256 / 2
        else
            (Math.cos(lat - da) + Math.cos(lat + da)) * da * da * 256 / 2
    circle = (dC(lat(j)) for j in [0...256])
    S = 0
    for val in circle
        S += val
    ratio = (val/S for val in circle)

    avgt.init = (283.15 - 30 * (1 - Math.cos(lat(i))) for i in [0...256])

    avgt.evolve =  (data, energyIn) ->
        [global, field] = data

        total = 0
        for i in [0...256]
            total += (field[i] * ratio[i])
        global = total

        newfield = []
        for i in [0...256]
            input = energyIn[i] * absorb(field[i])
            output = 5.6696e-8 * field[i] * field[i] * field[i] * field[i] * 2
            transfer = 10 * (field[i] - global)
            radius = input - output - transfer
            newfield[i] = field[i] + radius / rau(field[i]) * 3600 * 23

        [global, newfield]

    avgt
