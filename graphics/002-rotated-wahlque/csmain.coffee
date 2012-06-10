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

        changeframe = (e) ->
            canvas = $('#canvas').get(0)
            width = canvas.width
            height = canvas.height

            x = y = 0
            if e.pageX || e.pageY
              x = e.pageX
              y = e.pageY
            else
              x = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft
              y = e.clientY + document.body.scrollTop + document.documentElement.scrollTop
            x -= canvas.offsetLeft
            y -= canvas.offsetTop
            x = x - width / 2
            y = y - height / 2

            if x > 0
                frame = rotater.left(frame, x / width * 2)
            else
                frame = rotater.right(frame, - x / width * 2)

            if y > 0
                frame = rotater.up(frame, y / height * 2)
            else
                frame = rotater.down(frame, - y / height * 2)

        bean.add(
            $('#btnStart').get(0), 'click', (-> invoke())
        )
        bean.add(
            $('#canvas').get(0), 'click', changeframe
        )

        time = 0
        evolve = ->
            return if map == null
            viewer.paint(transformer.target(frame, time), map)
            time += (1 / 30)
        handle = setInterval(evolve, 1000)

       true
