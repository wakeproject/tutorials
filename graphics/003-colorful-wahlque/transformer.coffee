###
  transformer.coffee

  transformer
###
define [
  'exports'
  'cs!/wahlque/math/geometry/vector3'
  'cs!/wahlque/universe/wahlque/planet/planet'
], (transformer, vec3, planet) ->

    transformer.target = (frame, lights, time) ->
        (lng, lat) ->
            [axisx, axisy, axisz] = frame
            [light1, light2] = lights
            z = planet.zenith(lng, lat, time)
            return [-1, -1] if vec3.inner(z, axisz) < 0

            l1 = vec3.inner(z, light1)
            l2 = vec3.inner(z, light2)
            l1 = 0 if l1 < 0
            l2 = 0 if l2 < 0
            l = l1 + l2
            l = 1 if l > 1
            return [[vec3.inner(z, axisx), vec3.inner(z, axisy)], l]

    transformer
