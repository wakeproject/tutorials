###
  starlight.coffee

  star light
###
define [
  'exports'
  'cs!/wahlque/math/geometry/vector3'
  'cs!/wahlque/universe/wahlque/system'
], (starlight, vec3, system) ->

    starlight.evolve = (tao) ->
        system.step(tao)
        [vec3.expand(system.u1, system.lum1), vec3.expand(system.u2, system.lum2)]

    starlight
