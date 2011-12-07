###
  simulator.coffee

  a demo webworker for two-body simulation:
###
define [
    'exports'
    'cs!/wahlque/math/ode/verlet'
    'cs!/wahlque/math/geometry/vector3'
    'cs!/wahlque/physics/nbody/bodies3pr'
    'cs!/wahlque/physics/units/au'
    'cs!/wahlque/universe/starA'
    'cs!/wahlque/universe/starB'
    'cs!/wahlque/universe/planet'
], (exports, solver, vec3, b3, au, a, b, p) ->
    handle = 0
    time = 0
    start = () ->
        m1 = a.mass
        m2 = b.mass
        acceleration = b3.acceleration(au, m1, m2)
        step = solver.solve(acceleration)

        [x1, y1] = a.initPosition
        [vx1, vy1] = a.initVelocity
        [x2, y2] = b.initPosition
        [vx2, vy2] = b.initVelocity
        [x3, y3] = p.initPosition
        [vx3, vy3] = p.initVelocity
        x = [x1, y1, x2, y2, x3, y3]
        v = [vx1, vy1, vx2, vy2, vx3, vy3]

        l1 = a.luminosity
        l2 = b.luminosity

        lng = (i) -> 2 * Math.PI / 256 * i
        lat = (j) -> Math.PI / 256 * (128 - j)
        cut = (val) -> val > 0 ? val : 0
        evolve = ->
            [time, x, v] = step(time, x, v, 0.1)
            [x1, y1, x2, y2, x3, y3] = x
            [vx1, vy1, vx2, vy2, vx3, vy3] = v
            phase = [x1, y1, vx1, vy1, x2, y2, vx2, vy2, x3, y3, vx3, vy3]
            self.postMessage({orb: phase})

            lum1 = l1 / ((x1 - x3) * (x1 - x3) + (y1 - y3) * (y1 - y3))
            lum2 = l2 / ((x2 - x3) * (x2 - x3) + (y2 - y3) * (y2 - y3))
            luminosity = lum1 + lum2
            self.postMessage({lum: luminosity})

            if time - Math.floor(time) < 0.1
                u1 = vec3.unify([x1 - x3, y1 - y3, 0])
                u2 = vec3.unify([x2 - x3, y2 - y3, 0])
                twilight = (
                    (
                        [
                           lum1 * cut(vec3.inner(p.zenith(lng(i), lat(j), time), u1))
                           lum2 * cut(vec3.inner(p.zenith(lng(i), lat(j), time), u2))
                        ] for j in [0...256]
                    ) for i in [0...256]
                )
                self.postMessage({twlt: twilight})

        handle = setInterval(evolve, 100)

    self.onmessage = (e) ->
        if handle
            clearInterval(handle)
        start()
        true

    exports

