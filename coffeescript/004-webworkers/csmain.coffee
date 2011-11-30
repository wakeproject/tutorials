###
  csmain.coffee

  link for this section:
  http://playground.wahlque.org/tutorials/coffeescript/004-webworkers/
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
        ps['a'] = 5 if not ps['a']
        ps['b'] = 10 if not ps['b']

        ctx =
          keys: _.keys(ps)
          vals: ps
        list = _.template(
            "<ul>
               <form action='/tutorials/coffeescript/004-webworkers/' method='get'>
               <% _.each(keys, function(key) { %>
                 <li><%= key %>: <input type='text' name='<%= key %>' value='<%= vals[key] %>'></li>
               <% }); %>
               <input type='submit' value='Submit' />
               </form>
             </ul>",
            ctx
        )
        $("#params").html(list)

        worker = new Worker 'worker.js'
        worker.onmessage = (e) ->
            data = 'result: ' + e.data
            $('#result').append("<li>#{data}</li>")
            true
        invoke = ->
            console.info('start of calling from page')
            worker.postMessage( _.values(ps))
            console.info('end of calling from page')
            true

        bean.add(
            $("#btn"), 'click', (-> invoke())
        )

        true
    )
