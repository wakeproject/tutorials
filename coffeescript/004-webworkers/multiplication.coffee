###
  multiplication.coffee

  a demo webworker for mutiplication:
###

global = this

define [
  'underscore'
], (_) ->
    postMessage('before binding')
    global.onmessage = (e) ->
        result = _.reduce(_.values(e.data), ((memo, elem) -> memo * elem), 1)
        postMessage(result)
        false

