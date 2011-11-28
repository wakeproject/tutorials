###
  multiplication.coffee

  a demo webworker for mutiplication:
###

global = this

define [
  'underscore'
  'exports'
], (_, multi) ->
    console.info('binding: onmessage');
    global.onmessage = (e) ->
        console.info('input:' + e.data);
        result = _.reduce(_.values(e.data), ((memo, elem) -> memo * elem), 1)
        console.info('results:' + result);
        postMessage(result)
