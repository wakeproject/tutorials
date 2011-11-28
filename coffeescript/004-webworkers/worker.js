importScripts('/require.js');

var worker = require({
    paths: {
        cs: '/cs',
        underscore: '/underscore',
        baseUrl: '/tutorials/coffeescript/004-webworkers/'
    }
}, ['cs!multiplication']);

