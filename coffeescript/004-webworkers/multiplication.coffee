###
  multiplication.coffee

  a demo webworker for mutiplication:
###
( ->

    global = this

    define [
      'underscore'
    ], (_) ->
        global.onmessage = (e) ->
            global.postMessage('hello from worker!')
            result = _.reduce(_.values(e.data), ((memo, elem) -> memo * elem), 1)
            global.postMessage(result)
            false
        global.postMessage('after binding')
        false
)()

