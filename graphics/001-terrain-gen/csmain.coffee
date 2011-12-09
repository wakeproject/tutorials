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
  'cs!viewer'
], (_, domReady, qwery, bonzo, bean, viewer) ->
    $ = (selector) -> bonzo(qwery(selector))

    domReady ->
        worker = new Worker './worker.js'
        worker.onmessage = (event) ->
            data = event.data
            if data.msg
                $("#msg").html(data.msg)
            else if data.trn
                viewer.paint(data.trn)

        invoke = ->
            worker.postMessage('start')
            true

        bean.add(
            $('#btnGen').get(0), 'click', (-> invoke())
        )
        bean.add(
            $('#btnCon').get(0), 'click', (-> viewer.convertImage(); true)
        )

       true
