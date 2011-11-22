###
  csmain.coffee

  link for this section:
  http://playground.wahlque.org/tutorials/mechanics/001-binary-star
###
define [
  'underscore',
  'domReady',
  'qwery',
  'bonzo',
  'bean',
  'cs!/wahlque/util/url'
], (_, domReady, qwery, bonzo, bean, url) ->
  $ = (selector) -> bonzo(qwery(selector))

  domReady( ->
      ps = url.params()
      ctx =
          keys: _.keys(ps) or []
          vals: ps
      list = _.template(
        "<ul><% _.each(keys, function(key) { %> <li><%= key %>: <%= vals[key] %></li> <% }); %></ul>",
        ctx
      )
      $("#params").html(list)
  )
