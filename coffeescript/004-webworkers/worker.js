importScripts('/javascripts/require.js');

var worker = require({
    paths: {
        cs: '/javascripts/cs',
        underscore: '/javascripts/underscore',
        baseUrl: '/tutorials/coffeescript/004-webworkers/'
    }
}, ['cs!multiplication']);

