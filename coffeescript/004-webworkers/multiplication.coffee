###
  multiplication.coffee

  a demo webworker for mutiplication:
###
define [
  'underscore',
  'cs!/wahlque/geometry/vector',
  'cs!/wahlque/nbody/bodies2',
  'cs!/wahlque/units/au'
], (_, v, b2, au) ->
    self.postMessage('before binding')
    self.onmessage = (e) ->
        self.postMessage('hello from worker!')
        result = _.reduce(e.data, ((memo, elem) -> memo * elem), 1)
        self.postMessage(result)
        self.postMessage(v.norm([1,1,1,1]))
        self.postMessage(au.G)
        self.postMessage(v.norm(b2.derivative([1,1])([1,0,1,0,-1,0,-1,0])))
        true
    self.postMessage('after binding')
    true

