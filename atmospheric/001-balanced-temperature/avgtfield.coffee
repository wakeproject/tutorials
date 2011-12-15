###
  avgtland.coffee

  average temperature filed along latitude
###
define [
    'exports'
    'cs!/wahlque/universe/planet/planet'
], (avgt, p) ->

    lat = (j) -> Math.PI / 256 * (128 - j)
    lcapacity = (t) ->
        if t < 263.15
            2106
        else if t < 273.15
            33400
        else if t < 373.15
            4218
        else if t < 383.15
            225000
    acapacity = (t) -> 1005

    shtAbsorb = (t) -> (t > 263.15) ? 0.7 : 0.3
    shtAbsorbLand = 150 / 342
    shtAbsorbAir  =  50 / 342
    lngAbsorbAir  =  370 / 390
    landOutputRatio = (390 + 24 + 78) / 390

    da = 2 * Math.PI / 256 / 2
    dC = (lat) ->
        if Math.abs(Math.PI / 2 - Math.abs(lat)) < da
            Math.PI * da * da * 256 * p.radius * p.radius
        else
           2 * Math.PI * (Math.cos(lat - da) + Math.cos(lat + da)) * da * da * 256 * p.radius * p.radius
    circle = (dC(lat(j)) for j in [0...256])
    S = 0
    for val in circle
        S += val
    ratio = (val/S for val in circle)

    avgt.init = (303.15 - 10 * Math.sin(6 * lat(i)) for i in [0...256])

    avgt.evolve =  (data, energyIn) ->
        [gland, land, gair, air] = data

        total = 0
        for i in [0...256]
            total += (land[i] * ratio[i])
        gland = total

        total = 0
        for i in [0...256]
            total += (air[i] * ratio[i])
        gair = total

        nland = []
        nair = []
        for i in [0...256]
            shrLandInput = energyIn[i] * shtAbsorbLand * shtAbsorb(land[i])
            shrtAirInput = energyIn[i] * shtAbsorbAir

            loutput = 5.6696e-8 * land[i] * land[i] * land[i] * land[i] * landOutputRatio * circle[i] / 16 * 1.2

            ainput = shrtAirInput + (lngAbsorbAir + 1 - 1 / landOutputRatio) * loutput

            atmpUpr = air[i] - 20
            aoutputBtm = 5.6696e-8 * air[i] * air[i] * air[i] * air[i] * circle[i] / 16 * 1.2
            aoutputUpr = 5.6696e-8 * atmpUpr * atmpUpr * atmpUpr * atmpUpr * circle[i] / 16 * 1.2

            linput = shrLandInput + aoutputBtm

            aoutput = aoutputBtm + aoutputUpr

            ltransfer = 10 * (land[i] - gland) * circle[i] / 16
            atransfer = 3 * (air[i] - gair) * circle[i] / 16

            lradius = linput - loutput - ltransfer
            aradius = ainput - aoutput - atransfer

            nland[i] = land[i] + lradius / lcapacity(land[i]) / circle[i] / 10 / 1000 * 3600 * 23
            nair[i] = air[i] + aradius / acapacity(air[i]) / circle[i] / 5000 / 1 * 3600 * 23

        [gland, nland, gair, nair]

    avgt
