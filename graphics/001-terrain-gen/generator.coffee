###
  generator.coffee

  a demo generator for terrain forming
###
define [
  'exports'
  'cs!/wahlque/universe/planet/terrain'
], (exports, terrain) ->
    handle = 0
    counter = 0
    start = () ->
        seeds = terrain.seeds()
        evolve = ->
            if counter < 8
                seeds = terrain.gen(seeds)
                counter = counter + 1
                self.postMessage({trn: seeds})
            else
                self.postMessage({msg: 'done!'})
                clearInterval(handle)
        handle = setInterval(evolve, 5000)

    self.onmessage = (e) ->
        start()
        true

    exports

