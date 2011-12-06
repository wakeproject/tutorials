###
  simulator.coffee

  a demo webworker for two-body simulation:
###
define [
    'exports',
    'cs!/wahlque/math/ode/verlet',
    'cs!/wahlque/physics/nbody/bodies3pr',
    'cs!/wahlque/physics/units/au'
], (exports, solver, b3, au) ->
    handle = 0
    time = 0
    start = (e) ->
        [m1, m2, x1, y1, vx1, vy1, x2, y2, vx2, vy2, x3, y3, vx3, vy3] = e.data
        acceleration = b3.acceleration(au, m1, m2)
        step = solver.solve(acceleration)
        x = [x1, y1, x2, y2, x3, y3]
        v = [vx1, vy1, vx2, vy2, vx3, vy3]
        evolve = ->
            [time, x, v] = step(time, x, v, 1)
            [x1, y1, x2, y2, x3, y3] = x
            [vx1, vy1, vx2, vy2, vx3, vy3] = v
            phase = [x1, y1, vx1, vy1, x2, y2, vx2, vy2, x3, y3, vx3, vy3]
            self.postMessage({msg: phase.join(', ')})
            self.postMessage(phase)
        handle = setInterval(evolve, 100)

    self.onmessage = (e) ->
        if handle
            clearInterval(handle)
        start(e)
        true

    exports

