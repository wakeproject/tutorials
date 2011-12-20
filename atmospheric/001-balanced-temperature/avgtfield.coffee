###
  avgtland.coffee

  average temperature filed along latitude
###
define [
    'exports'
    'cs!/wahlque/universe/wahlque/planet/planet'
], (avgt, p) ->

    lcapacity = (t) ->
        if t < 263.15
            2106
        else if t < (263.15 + 2)
            335000 / 2
        else if t < 373.15
            4218
        else if t < (383.15 - 2)
            2250000 / 2
    acapacity = (t) -> 1005

    shtAbsorb = (t) ->
        if t > 263.15
            0.7
        else
            0.3
    shtAbsorbLand = 168 / 342
    shtAbsorbAir  =  50 / 342
    landAbsorbAir =  (350 + 24 + 78) / (390 + 24 + 78)
    landOutputRatio = (390 + 24 + 78) / 390

    radius = p.radius
    period = p.period
    dS = 2 * Math.PI * radius * 2 * radius / 256
    dA = (a, h) -> 2 * radius * Math.PI * Math.cos(a) * h
    dV = (d) -> dS * d

    transfer = (array, i) ->
        if i == 0
            (array[i + 1] - array[i]) / 2 / radius * 256
        else if i == 255
            (array[i - 1] - array[i]) / 2 / radius * 256
        else
            (array[i + 1] + array[i - 1] - 2 * array[i]) / 2 / radius * 256

    lat = (j) -> Math.PI / 256 * (128 - j)

    rand = -> 1 + 2 * (Math.random() - 0.5) / 100

    avgt.init = (273.15 for i in [0...256])
    #avgt.init = (263.15 + 20 * Math.cos(lat(i)) for i in [0...256])
    #avgt.init = (303.15 for i in [0...256])

    avgt.evolve =  (data, energyIn) ->
        [gland, land, gair, air] = data

        total = 0
        for i in [0...256]
            total += (land[i] / 256)
        gland = total

        total = 0
        for i in [0...256]
            total += (air[i] / 256)
        gair = total

        nland = []
        nair = []
        for i in [0...256]
            shrLandInput = energyIn[i] * shtAbsorb(land[i])
            shrtAirInput = energyIn[i] * shtAbsorbAir

            loutput = 5.6696e-8 * land[i] * land[i] * land[i] * land[i] * landOutputRatio * dS

            ainput = shrtAirInput + landAbsorbAir * loutput

            atmpUpr = air[i] - 56
            aoutputBtm = 5.6696e-8 * air[i] * air[i] * air[i] * air[i] * dS
            aoutputUpr = 5.6696e-8 * atmpUpr * atmpUpr * atmpUpr * atmpUpr * dS

            linput = shrLandInput + aoutputBtm

            aoutput = aoutputBtm + aoutputUpr

            ltransfer = 1000 * lcapacity(1) * 0.3 * transfer(land, i) * dA(lat(i), 7) * 10
            atransfer = 1 * lcapacity(1) * 1 * transfer(air, i) * dA(lat(i), 4000) * 10

            lradius = (linput - loutput + ltransfer) * rand()
            aradius = (ainput - aoutput + atransfer) * rand()

            nland[i] = land[i] + lradius / lcapacity(land[i]) / dV(7) / 1000 * period
            nair[i] = air[i] + aradius / acapacity(air[i]) / dV(4000) / 1 * period
        [gland, nland, gair, nair]

    avgt
