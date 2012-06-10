###
  rotater.coffee

  rotate a vector in 3D space
###
define [
  'exports'
  'cs!/wahlque/math/geometry/vector3'
], (rotater, vec3) ->

    rotater.up = (frame) ->
        [axisx, axisy, axisz] = frame
        phi = 2 * Math.PI * time / 60
        cos = Math.cos(phi)
        sin = Math.sin(phi)
        # by Rodrigues' rotation formula
        rotated = vec3.add(vec3.expand(axisz, cos), vec3.expand(vec3.cross(axisx, axisz), sin))
        axisy = vec3.cross(axisx, rotated)
        [axisx, axisy, rotated]

    rotater.down = (axisx, axisy) ->
        [axisx, axisy, axisz] = frame
        phi = - 2 * Math.PI * time / 60
        cos = Math.cos(phi)
        sin = Math.sin(phi)
        # by Rodrigues' rotation formula
        rotated = vec3.add(vec3.expand(axisz, cos), vec3.expand(vec3.cross(axisx, axisz), sin))
        axisy = vec3.cross(axisx, rotated)
        [axisx, axisy, rotated]

    rotater.left = (frame) ->
        [axisx, axisy, axisz] = frame
        phi = - 2 * Math.PI * time / 60
        cos = Math.cos(phi)
        sin = Math.sin(phi)
        # by Rodrigues' rotation formula
        rotated = vec3.add(vec3.expand(axisz, cos), vec3.expand(vec3.cross(axisy, axisz), sin))
        axisx = vec3.cross(axisy, rotated)
        [axisx, axisy, rotated]

    rotater.right = (frame) ->
        [axisx, axisy, axisz] = frame
        phi = 2 * Math.PI * time / 60
        cos = Math.cos(phi)
        sin = Math.sin(phi)
        # by Rodrigues' rotation formula
        rotated = vec3.add(vec3.expand(axisz, cos), vec3.expand(vec3.cross(axisy, axisz), sin))
        axisx = vec3.cross(axisy, rotated)
        [axisx, axisy, rotated]

    rotater
