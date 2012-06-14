###
  transformer.coffee

  transformer
###
define [
  'exports'
  'cs!/wahlque/math/geometry/vector3'
  'cs!/wahlque/universe/wahlque/planet/planet'
], (transformer, vec3, planet) ->

    transformer.target = (frame, time) ->
        (lng, lat) ->
            [axisx, axisy, axisz] = frame
            z = planet.zenith(lng, lat, time)
            return [-1, -1] if vec3.inner(z, axisz) < 0

            return [vec3.inner(z, axisx), vec3.inner(z, axisy)]

    transformer
