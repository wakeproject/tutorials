###
  rotater.coffee

  rotate a vector in 3D space
###
define [
  'exports'
  'cs!/wahlque/math/geometry/vector3'
], (rotater, vec3) ->

    rotater.up = (frame, step) ->
        [axisx, axisy, axisz] = frame
        phi = Math.PI / 24 * step
        cos = Math.cos(phi)
        sin = Math.sin(phi)
        # by Rodrigues' rotation formula
        rotated = vec3.add(vec3.expand(axisz, cos), vec3.expand(vec3.cross(axisx, axisz), sin))
        axisy = vec3.cross(rotated, axisx)
        [axisx, axisy, rotated]

    rotater.down = (frame, step) ->
        [axisx, axisy, axisz] = frame
        phi = - Math.PI / 24 * step
        cos = Math.cos(phi)
        sin = Math.sin(phi)
        # by Rodrigues' rotation formula
        rotated = vec3.add(vec3.expand(axisz, cos), vec3.expand(vec3.cross(axisx, axisz), sin))
        axisy = vec3.cross(rotated, axisx)
        [axisx, axisy, rotated]

    rotater.left = (frame, step) ->
        [axisx, axisy, axisz] = frame
        phi = Math.PI / 24 * step
        cos = Math.cos(phi)
        sin = Math.sin(phi)
        # by Rodrigues' rotation formula
        rotated = vec3.add(vec3.expand(axisz, cos), vec3.expand(vec3.cross(axisy, axisz), sin))
        axisx = vec3.cross(rotated, axisy)
        [axisx, axisy, rotated]

    rotater.right = (frame, step) ->
        [axisx, axisy, axisz] = frame
        phi = - Math.PI / 24 * step
        cos = Math.cos(phi)
        sin = Math.sin(phi)
        # by Rodrigues' rotation formula
        rotated = vec3.add(vec3.expand(axisz, cos), vec3.expand(vec3.cross(axisy, axisz), sin))
        axisx = vec3.cross(rotated, axisy)
        [axisx, axisy, rotated]

    rotater
