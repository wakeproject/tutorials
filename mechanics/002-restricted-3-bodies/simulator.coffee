###
  simulator.coffee

  a demo webworker for two-body simulation:
###
define [
    'exports',
    'cs!/wahlque/ode/euler',
    'cs!/wahlque/nbody/bodies3pr',
    'cs!/wahlque/units/au'
], (exports, solver, b3, au) ->
    handle = 0
    time = 0
    start = (e) ->
        [m1, m2, x1, y1, vx1, vy1, x2, y2, vx2, vy2, x3, y3, vx3, vy3] = e.data
        derivative = b3.derivative(au, m1, m2)
        step = solver.solve(derivative)
        phase = [x1, y1, vx1, vy1, x2, y2, vx2, vy2, x3, y3, vx3, vy3]
        evolve = ->
            [time, phase] = step(time, phase, 1)
            self.postMessage({msg: phase.join(', ')})
            self.postMessage(phase)
        handle = setInterval(evolve, 100)

    self.onmessage = (e) ->
        if handle
            clearInterval(handle)
        start(e)
        true

    exports

