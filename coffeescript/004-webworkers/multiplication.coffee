###
  multiplication.coffee

  a demo webworker for mutiplication:
###
define [
  'underscore',
  'cs!/wahlque/geometry/vector',
  'cs!/wahlque/units/au',
  'cs!/wahlque/ode/euler',
  'cs!/wahlque/nbody/bodies2'
], (_, v, au, eu, b2) ->
    self.postMessage('before binding')
    self.onmessage = (e) ->
        self.postMessage('hello from worker!')
        result = _.reduce(e.data, ((memo, elem) -> memo * elem), 1)
        self.postMessage('1:' + result)
        self.postMessage('2:' + v.norm([1,1,1,1]))
        self.postMessage('3:' + v.norm(v.expand([1,1,1,1], 2)))
        self.postMessage('4:' + au.G)
        self.postMessage('5:' + v.norm(eu.step([1,0,1,0,-1,0,-1,0], ((x)->x), 1)))
        self.postMessage('6:' + v.norm(b2.derivative([1,1])([1,0,1,0,-1,0,-1,0])))
        self.postMessage('7:' + v.norm(eu.step([1,0,1,0,-1,0,-1,0], b2.derivative([1,1]), 1)))
        true
    self.postMessage('after binding')
    true

