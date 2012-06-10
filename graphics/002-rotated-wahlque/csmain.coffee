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
  'cs!rotater'
  'cs!transformer'
  'cs!viewer'
], (_, domReady, qwery, bonzo, bean, rotater, transformer, viewer) ->
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

        keypressed = (e) ->
            if e.keyIdentifier == 'Up'
                frame = rotater.up(frame)
            else if e.keyIdentifier == 'Down'
                frame = rotater.down(frame)
            else if e.keyIdentifier == 'Left'
                frame = rotater.left(frame)
            else if e.keyIdentifier == 'Right'
                frame = rotater.right(frame)

        bean.add(
            $('#btnStart').get(0), 'click', (-> invoke())
        )
        bean.add(
            $('#main').get(0), 'keypress', keypressed
        )

        time = 0
        evolve = ->
            return if map == null
            viewer.paint(transformer.target(frame, time), map)
            time += (1 / 20 / 30)
        handle = setInterval(evolve, 50)

       true
