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
  'cs!/wahlque/units/au',
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
        b = a * Math.sqrt(1 - e * e)
        M = m1 + m2
        y1 = m2 / M * b
        y2 = - m1 / M * b

        v  = Math.sqrt(au.G * M / a * (1 + e) / (1 - e))
        v1 = 2 * v / M * m2
        v2 = - 2 * v / M * m1

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
                0, y1, 0, v1,
                0, y2, 0, v2
        ]
        invoke = ->
            worker.postMessage(vals)
            true

        bean.add(
            $('#btn').get(0), 'click', (-> invoke())
        )

       true
