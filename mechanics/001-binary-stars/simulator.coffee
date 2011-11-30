###
  simulator.coffee

  a demo webworker for two-body simulation:
###
define [
  'underscore'
  'cs!/wahlque/ode/euler'
  'cs!/wahlque/nbody/bodies2'
], (_, solver, b2) ->
   handle = 0
   start = ->
       [m1, m2, x1, y1, vx1, vy1, x2, y2, vx2, vy2] = e.data
       derivative = b2.derivative(m1, m2)
       phase = [x1, y1, vx1, vy1, x2, y2, vx2, vy2]
       evolve = ->
           phase = solver.step(phase, derivative, 1)
           self.postMessage(phase)
       handle = setInterval(evolve, 100)

   self.onmessage = (e) ->
       if handle
           clearInterval(handle)
       start()
       true

   true

