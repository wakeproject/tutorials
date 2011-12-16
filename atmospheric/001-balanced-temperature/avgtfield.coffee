###
  avgtland.coffee

  average temperature filed along latitude
###
define [
    'exports'
    'cs!/wahlque/universe/planet/planet'
], (avgt, p) ->

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

    shtAbsorb = (t) ->
        if t > 263.15
            0.7
        else
            0.3
    shtAbsorbLand = 150 / 342
    shtAbsorbAir  =  50 / 342
    lngAbsorbAir  =  370 / 390
    landOutputRatio = (390 + 24 + 78) / 390

    dS = 2 * Math.PI * p.radius * 2 * p.radius / 256
    dV = (d) -> dS * d

    lat = (j) -> Math.PI / 256 * (128 - j)
    avgt.init = (243.15 + 40 * Math.cos(lat(i)) for i in [0...256])

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

            ainput = shrtAirInput + (lngAbsorbAir + 1 - 1 / landOutputRatio) * loutput

            atmpUpr = air[i] - 20
            aoutputBtm = 5.6696e-8 * air[i] * air[i] * air[i] * air[i] * dS
            aoutputUpr = 5.6696e-8 * atmpUpr * atmpUpr * atmpUpr * atmpUpr * dS

            linput = shrLandInput + aoutputBtm

            aoutput = aoutputBtm + aoutputUpr

            ltransfer = 0.1 * (land[i] - gland) * 2 * p.radius * Math.PI * 10 * Math.cos(lat(i))
            atransfer = 0.03 * (air[i] - gair) * 2 * p.radius * Math.PI * 5000 * Math.cos(lat(i))

            lradius = linput - loutput - ltransfer
            aradius = ainput - aoutput - atransfer

            nland[i] = land[i] + lradius / lcapacity(land[i]) / dV(10) / 1000 * p.period
            nair[i] = air[i] + aradius / acapacity(air[i]) / dV(5000) / 1 * p.period
        [gland, nland, gair, nair]

    avgt
