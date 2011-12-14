importScripts('/javascripts/require.js');

require({
    paths: {
        cs: '/javascripts/cs',
        underscore: '/javascripts/underscore',
        baseUrl: '/tutorials/mechanics/003-twilight-zone/'
    }
}, ['cs!simulator']);
