###
  csmain.coffee

  link for this section:
  http://playground.wahlque.org/tutorials/coffeescript/002-using-modules
###
define [
  'underscore',
  'domReady',
  'cs!/wahlque/util/url'
], (_, domReady, url) ->
  domReady( ->
      ps = url.params()
      ctx =
          keys: _.keys(ps) or []
          vals: ps
      list = _.template(
        "<ul><% _.each(keys, function(key) { %> <li><%= key %>: <%= vals[key] %></li> <% }); %></ul>",
        ctx
      )
      document.getElementById("params").innerHTML = list
  )
