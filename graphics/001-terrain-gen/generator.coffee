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
            seeds = terrain.gen(seeds)
            counter = counter + 1
            #if seeds[0] == 4096
            #    self.postMessage({msg: 'done!'})
            #    clearInterval(handle)
            #else
            #    self.postMessage({trn: seeds})
            self.postMessage({msg: counter})
            self.postMessage({trn: seeds})
        handle = setInterval(evolve, 5000)

    self.onmessage = (e) ->
        start()
        true

    exports

