###
  simulator.coffee

  a demo webworker for two-body simulation:
###
define [
    'exports',
    'cs!/wahlque/ode/euler',
    'cs!/wahlque/nbody/bodies3pr'
], (exports, solver, b3) ->
    handle = 0
    start = (e) ->
        [m1, m2, x1, y1, vx1, vy1, x2, y2, vx2, vy2, x3, y3, vx3, vy3] = e.data
        derivative = b3.derivative(m1, m2)
        phase = [x1, y1, vx1, vy1, x2, y2, vx2, vy2, x3, y3, vx3, vy3]
        evolve = ->
            phase = solver.step(phase, derivative, 0.1)
            self.postMessage({msg: phase.join(', ')})
            self.postMessage(phase)
        handle = setInterval(evolve, 100)

    self.onmessage = (e) ->
        if handle
            clearInterval(handle)
        start(e)
        true

    exports

