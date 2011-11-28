###
  multiplication.coffee

  a demo webworker for mutiplication:
###

global = this

define [
  'underscore'
  'exports'
], (_, multi) ->
    global.onmessage = (e) ->
        result = _.reduce(_.values(e.data), ((memo, elem) -> memo * elem), 1)
        postMessage(result)
        false

