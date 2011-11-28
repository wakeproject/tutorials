importScripts('/require.js');

var worker = require({
    paths: {
        cs: '/cs',
        underscore: '/underscore'
    }
}, ['cs!multiplication']);

onmessage = function(e) {
    worker.onmessage(e);
};
