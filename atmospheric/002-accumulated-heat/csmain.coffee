###
  csmain.coffee

  link for this section:
  http://playground.wahlque.org/tutorials/graphics/001-terrain-gen
###
define [
  'underscore'
  'domReady'
  'qwery'
  'bonzo'
  'bean'
  'cs!accumulator'
  'cs!transformer'
  'cs!starlight'
  'cs!viewer'
  'cs!/wahlque/physics/units/au'
  'cs!/wahlque/universe/wahlque/planet/planet'
], (_, domReady, qwery, bonzo, bean, accumulator, transformer, starlight, viewer, au, planet) ->
    $ = (selector) -> bonzo(qwery(selector))

    domReady ->
        map = null
        frame = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]

        worker = new Worker './worker.js'
        worker.onmessage = (event) ->
            data = event.data
            if data.msg
                $("#msg").html(data.msg)
            else if data.trn
                map = data.trn

        invoke = ->
            worker.postMessage('start')
            $("#msg").html('Initializting the terrain data')
            true

        bean.add(
            $('#btnStart').get(0), 'click', (-> invoke())
        )

        time = 0
        evolve = ->
            return if map == null
            tao = planet.period / 30 #SI
            lights = starlight.evolve(au.fromSI_T(tao))
            data = accumulator.accumulate(tao, time, lights[0], lights[1])

            viewer.paint(transformer.target(frame, (time / planet.period)), map, data)
            time += tao
        handle = setInterval(evolve, 1000)

       true
