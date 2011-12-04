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

        m1 = ps['m1']
        m2 = ps['m2']
        a = ps['a']
        e = ps['e']
        M = m1 + m2
        x1 = m2 / M * a
        x2 = - m1 / M * a

        ps['x1'] = x1 if not ps['x1']
        ps['y1'] = 0 if not ps['y1']
        ps['x2'] = x2 if not ps['x2']
        ps['y2'] = 0 if not ps['y2']

        v  = Math.sqrt(au.G * M / a * (1 + e) / (1 - e))
        v1 = v / M * m2
        v2 = - v / M * m1

        ps['vx1'] = 0 if not ps['vx1']
        ps['vy1'] = v1 if not ps['vy1']
        ps['vx2'] = 0 if not ps['vx2']
        ps['vy2'] = v2 if not ps['vy2']

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
                ps['m1'], ps['m2'],
                ps['x1'], ps['y1'], ps['vx1'], ps['vy1'],
                ps['x2'], ps['y2'], ps['vx2'], ps['vy2']
        ]
        invoke = ->
            worker.postMessage(vals)
            true

        bean.add(
            $('#btn').get(0), 'click', (-> invoke())
        )

       true
