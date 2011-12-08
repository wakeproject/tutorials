###
  generator.coffee

  a demo generator for terrain forming
###
define [
  'exports'
  'cs!/wahlque/universe/planet/terrain'
], (exports, terrian) ->
    handle = 0
    start = () ->
        seeds = terrain.seeds()
        evolve = ->
            seeds = terrain.gen(seeds)
            data = terrain.resovle(seeds)
            if data[0] = 512
                self.postMessage({msg: 'done!'})
                clearInterval(handle)
            else
                self.postMessage({trn: data})
        handle = setInterval(evolve, 3000)

    self.onmessage = (e) ->
        start()
        true

    exports

