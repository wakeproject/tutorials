###
  avgtfield.coffee

  average temperature filed along latitude
###
define [
    'exports'
], (avgt) ->

    ratio = 0.5 * Math.cos(lat(j)) for j in [0...512]

    lat = (j) -> Math.PI / 256 * (128 - j)
    absorb = (t) -> t > 263.15 ? 0.7 : 0.4

    avgt.init = (273.15 - 60 * (1 - Math.cos(lat(i)))) for i in [0...512]

    avgt.evolve =  (data, energyIn) ->
        [global, field] = data

        input = energyIn[i] * absorb(field[i]) for i in [0...512]
        output = 204 + 2.17 * field[i] for i in [0...512]
        transfer = 3.81 * (field[i] - global) for i in [0...512]
        radius = input[i] - output[i] - transfer[i] for i in [0...512]

        newfield[i] = field[i] + radius[i] / 4200000 * 3600 * 30 for i in [0...512]

        total = 0
        for i in [0...512]
            total += newfield[i] * ratio[i]
        global = total / 512

        [global, newfield]

