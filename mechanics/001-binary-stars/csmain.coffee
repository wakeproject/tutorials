###
  csmain.coffee

  link for this section:
  http://playground.wahlque.org/tutorials/mechanics/001-binary-stars
###
define [
  'underscore',
  'domReady',
  'qwery',
  'bonzo',
  'bean',
  'cs!/wahlque/physics/units/au',
  'cs!/wahlque/util/url',
  'cs!orbit'
], (_, domReady, qwery, bonzo, bean, au, url, orbit) ->
    $ = (selector) -> bonzo(qwery(selector))

    domReady ->
        ps = url.params()
        ps['m1'] = 1 if not ps['m1']
        ps['m2'] = 1 if not ps['m2']
        ps['a'] = 4 if not ps['a']
        ps['e'] = 0 if not ps['e']

        m1 = parseFloat(ps['m1'])
        m2 = parseFloat(ps['m2'])
        a = parseFloat(ps['a'])
        e = parseFloat(ps['e'])
        M = m1 + m2
        x1 = m2 / M * a * 2
        x2 = - m1 / M * a * 2

        v  = Math.sqrt(au.G * M / (2 * a) * (1 - e) / (1 + e))
        v1 = v / M * m2
        v2 = - v / M * m1

        ctx =
            keys: _.keys(ps)
            vals: ps
        list = _.template(
            "<ul>
              <form action='/tutorials/mechanics/001-binary-stars/' method='get'>
              <% _.each(keys, function(key) { %> <li><%= key %>: <input type='text' name='<%= key %>' value='<%= vals[key] %>'></li> <% }); %>
              <input type='submit' value='Submit' />
              </form>
            </ul>",
            ctx
        )
        $("#params").html(list)

        worker = new Worker './worker.js'
        worker.onmessage = (event) ->
            data = event.data;
            if data.msg
                $("#msg").html(data.msg);
            else
                orbit.paint(data);

        vals = [
                m1, m2,
                x1, 0, 0, v1,
                x2, 0, 0, v2
        ]
        invoke = ->
            worker.postMessage(vals)
            true

        bean.add(
            $('#btn').get(0), 'click', (-> invoke())
        )

       true
