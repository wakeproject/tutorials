define [
  'underscore',
  'domReady',
  'qwery',
  'bonzo',
  'bean',
  'cs!/wahlque/util/url'
], (_, domReady, qwery, bonzo, bean, url) ->
  domReady( ->
      ps = url.params()
      ps['qwery'] = !!qwery
      ps['bonzo'] = !!bonzo
      ps['bean'] = !!bean

      ctx =
          keys: _.keys(ps) or []
          vals: ps
      list = _.template(
        "<ul><% _.each(keys, function(key) { %> <li><%= key %>: <%= vals[key] %></li> <% }); %></ul>",
        ctx
      )
      document.getElementById("params").innerHTML = list
  )
