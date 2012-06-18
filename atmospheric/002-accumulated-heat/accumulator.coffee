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
    lng = (i) -> 2 * Math.PI / 128 * i
    lat = (j) -> Math.asin((128 - 2 * j + 1) / 128)
    dS = 2 * Math.PI * radius * 2 * radius / 128 / 128

    cut = (val) ->
        if val > 0
            val
        else
            0

    data = []
    for i in [0...128]
        for j in [0...128]
            data.push 0
    avg = []
    for i in [0...128]
        for j in [0...128]
            avg.push 0

    input = (lng, lat, time, light1, light2) ->
        ltime = time / p.period
        zenith = p.zenith(lng, lat, ltime)
        in1 = cut(vec3.inner(zenith, light1))
        in2 = cut(vec3.inner(zenith, light2))
        in1 + in2

    exports.avg = avg
    exports.data = data
    exports.accumulate = (tao, time, light1, light2) ->
        for i in [0...128]
            for j in [0...128]
                cur = 128 * i + j
                energyIn = sc * input(lng(i), lat(j), time, light1, light2) * tao
                data[cur] = data[cur] + energyIn
                avg[cur] = data[cur] / time

        [128, 128 * 128, avg]


    exports

