###
  simulatorad.coffee

  a demo webworker for two-body simulation:
###
define [
    'exports'
    'cs!/wahlque/math/ode/verlet'
    'cs!/wahlque/math/geometry/vector3'
    'cs!/wahlque/physics/nbody/bodies3pr'
    'cs!/wahlque/physics/units/au'
    'cs!/wahlque/universe/wahlque/starA'
    'cs!/wahlque/universe/wahlque/starB'
    'cs!/wahlque/universe/wahlque/planet/planet'
    'cs!/wahlque/universe/wahlque/planet/radiation'
    'cs!/wahlque/universe/solar/sun'
    'cs!/wahlque/universe/solar/jupiter'
    'cs!/wahlque/universe/solar/earth'
    'cs!/wahlque/universe/solar/radiation'
    'cs!avgtfield'
], (exports, solver, vec3, b3, au, a, b, p, wr, sun, jupiter, earth, sr, avgt) ->
    handle = 0
    time = 0

    main = a
    compinion = b
    planet = p
    rad = wr

    #main = sun
    #compinion = jupiter
    #planet = earth
    #rad = sr

    start = () ->
        m1 = main.mass
        m2 = compinion.mass
        acceleration = b3.acceleration(au, m1, m2)
        step = solver.solve(acceleration)

        [x1, y1] = main.initPosition
        [vx1, vy1] = main.initVelocity
        [x2, y2] = compinion.initPosition
        [vx2, vy2] = compinion.initVelocity
        [x3, y3] = planet.initPosition
        [vx3, vy3] = planet.initVelocity
        x = [x1, y1, x2, y2, x3, y3]
        v = [vx1, vy1, vx2, vy2, vx3, vy3]

        l1 = main.luminosity
        l2 = compinion.luminosity

        lng = (i) -> 2 * Math.PI / 256 * i
        lat = (j) -> Math.PI / 256 * (128 - j)
        cut = (val) -> val > 0 ? val : 0

        global = 303.15
        land = avgt.init
        air = avgt.init
        evolve = ->
            [time, x, v] = step(time, x, v, au.fromSI_T(planet.period))
            [x1, y1, x2, y2, x3, y3] = x
            [vx1, vy1, vx2, vy2, vx3, vy3] = v
            phase = [x1, y1, vx1, vy1, x2, y2, vx2, vy2, x3, y3, vx3, vy3]
            self.postMessage({orb: phase})

            lumTotal = rad.total(time, x)
            self.postMessage({lum: lumTotal})

            lumA = rad.a(time, x)
            lumB = rad.b(time, x)
            twilight = (
                (
                    [
                       lumA(lng(i), lat(j))
                       lumB(lng(i), lat(j))
                    ] for j in [0...256]
                ) for i in [0...256]
            )
            self.postMessage({twlt: twilight})

            data = [global, land, global, air]
            [gland, land, gair, air] = avgt.evolve(data, rad.averageIn(time, x))
            self.postMessage({tmp: [gland, land, gair, air]})
            self.postMessage({msg:
                '<ul>' +
                    '<li>average land temperature:' + gland + '</li>' +
                    '<li>average air temperature:' + gair + '</li>' +
                '</ul>'
            })

        handle = setInterval(evolve, 100)

    self.onmessage = (e) ->
        if handle
            clearInterval(handle)
        start()
        true

    exports

