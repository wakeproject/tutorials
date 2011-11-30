###
  multiplication.coffee

  a demo webworker for mutiplication:
###
define [
  'underscore'
], (_) ->
    self.onmessage = (e) ->
        self.postMessage('hello from worker!')
        result = _.reduce(_.values(e.data), ((memo, elem) -> memo * elem), 1)
        self.postMessage(result)
        false
    self.postMessage('after binding')
    false

