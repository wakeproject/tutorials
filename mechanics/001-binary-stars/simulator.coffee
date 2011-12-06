###
  simulator.coffee

  a demo webworker for two-body simulation:
###
define [
    'exports',
    'cs!/wahlque/ode/euler',
    'cs!/wahlque/nbody/bodies2',
    'cs!/wahlque/units/au'
], (exports, solver, b2, au) ->
    handle = 0
    time = 0
    start = (e) ->
        [m1, m2, x1, y1, vx1, vy1, x2, y2, vx2, vy2] = e.data
        derivative = b2.derivative(au, m1, m2)
        step = solver.solve(derivative)
        phase = [x1, y1, vx1, vy1, x2, y2, vx2, vy2]
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

