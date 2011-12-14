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
  'cs!temperature'
], (_, domReady, qwery, bonzo, bean, au, url, orbit, twilight, luminosity, temperature) ->
    $ = (selector) -> bonzo(qwery(selector))

    domReady ->
        worker = new Worker './worker.js'
        worker.onmessage = (event) ->
            data = event.data
            if data.msg
                $('#msg').html(data.msg)
            else if data.orb
                orbit.paint(data.orb)
            else if data.twlt
                twilight.paint(data.twlt)
            else if data.lum
                luminosity.paint(data.lum)
            else if data.tmp
                temperature.paint(data.tmp)

        invoke = ->
            worker.postMessage('start')
            true

        bean.add(
            $('#btn').get(0), 'click', (-> invoke())
        )

       true
