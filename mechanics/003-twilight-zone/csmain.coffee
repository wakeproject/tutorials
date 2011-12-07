###
  csmain.coffee

  link for this section:
  http://playground.wahlque.org/tutorials/mechanics/001-binary-stars
###
define [
  'underscore',
  'domReady',
  'qwery',
  'bonzo',
  'bean',
  'cs!/wahlque/physics/units/au',
  'cs!/wahlque/util/url',
  'cs!orbit',
  'cs!twilight',
  'cs!luminosity'
], (_, domReady, qwery, bonzo, bean, au, url, orbit, twilight, luminosity) ->
    $ = (selector) -> bonzo(qwery(selector))

    domReady ->
        worker = new Worker './worker.js'
        worker.onmessage = (event) ->
            data = event.data
            if data.orb
                orbit.paint(data.orb)
            else if data.twlt
                twilight.paint(data.twlt)
            else if data.lum
                luminosity.paint(data.lum)

        invoke = ->
            worker.postMessage('start')
            true

        bean.add(
            $('#btn').get(0), 'click', (-> invoke())
        )

       true
