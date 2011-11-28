###
  multiplication.coffee

  a demo webworker for mutiplication:
###
define [
  'underscore'
  'exports'
], (_, multi) ->

    multi.onmessage = (e) ->
        result = _.reduce(_.values(e.data), (memo, elem) -> memo * elem, 1)
        postMessage(result)
