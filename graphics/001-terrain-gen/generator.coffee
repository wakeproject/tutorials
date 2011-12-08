###
  generator.coffee

  a demo generator for terrain forming
###
define [
  'exports'
  'cs!/wahlque/universe/planet/terrain'
], (exports, terrain) ->
    handle = 0
    start = () ->
        seeds = terrain.seeds()
        evolve = ->
            seeds = terrain.gen(seeds)
            #if seeds[0] == 4096
            #    self.postMessage({msg: 'done!'})
            #    clearInterval(handle)
            #else
            #    self.postMessage({trn: seeds})
            self.postMessage({trn: seeds})
        handle = setInterval(evolve, 5000)

    self.onmessage = (e) ->
        start()
        true

    exports

