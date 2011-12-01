###
  multiplication.coffee

  a demo webworker for mutiplication:
###
define [
  'underscore',
  'cs!/wahlque/geometry/vector',
  'cs!/wahlque/units/au'
], (_, v, au) ->
    self.postMessage('before binding')
    self.onmessage = (e) ->
        self.postMessage('hello from worker!')
        result = _.reduce(e.data, ((memo, elem) -> memo * elem), 1)
        self.postMessage(result)
        self.postMessage(v.norm([1,1,1,1]))
        self.postMessage(au.G)
        true
    self.postMessage('after binding')
    true

