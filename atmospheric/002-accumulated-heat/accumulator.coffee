###
  accumulator.coffee

  accumulator
###
define [
  'exports'
  'cs!/wahlque/physics/units/si'
  'cs!/wahlque/physics/units/wau'
  'cs!/wahlque/math/geometry/vector3'
  'cs!/wahlque/universe/wahlque/planet/planet'
  'cs!/wahlque/universe/wahlque/planet/radiation'
], (exports, si, wau, vec3, p, r) ->

    sc = si.solarConst
    radius = p.radius
    lng = (i) -> 2 * Math.PI / 256 * i
    lat = (j) -> Math.asin((256 - 2 * j + 1) / 256)
    dS = 2 * Math.PI * radius * 2 * radius / 256 / 256

    cut = (val) ->
        if val > 0
            val
        else
            0

    total = 0
    totalA = 0
    totalB = 0
    data = []
    for i in [0..256]
        arr = []
        for j in [0..256]
            arr.push 0
        data.push arr

    input = (lng, lat, time, light1, light2) ->
        ltime = wau.fromAU_T(time)
        zenith = p.zenith(lng, lat, ltime)
        in1 = cut(vec3.inner(zenith, light1))
        in2 = cut(vec3.inner(zenith, light2))
        in1 + in2

    exports.accumulate = (tao, time, light1, light2) ->
        lday = time / p.period
        for i in [0..256]
            for j in [0..256]
                energyIn = sc * input(lng(i), lat(j), time, light1, light2) * tao
                data[i][j] = data[i][j] + energyIn
        avg = []
        for i in [0..256]
            arr = (data[i][j] / lday for j in [0..256])
            avg.push arr

        avg

    exports

