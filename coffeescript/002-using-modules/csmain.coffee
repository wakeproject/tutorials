define [
  '/underscore.js',
  '/domReady.js',
  'cs!/wahlque/util/url'
], (_, domReady, url) ->
  domReady( ->
      ps = url.params()
      ctx =
          keys: _.keys(ps) ? []
          vals: ps
      list = _.template(
        "<ul><% _.each(keys, function(key) { %> <li><%= vals[key] %></li> <% }); %></ul>",
        ctx
      )
      document.getElementById("params").innerHTML = list
  )
