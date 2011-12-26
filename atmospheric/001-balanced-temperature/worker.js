importScripts('/javascripts/require.js');

require({
    paths: {
        cs: '/javascripts/cs',
        underscore: '/javascripts/underscore',
        baseUrl: '/tutorials/atmospheric/001-balanced-temperature/'
    }
}, ['cs!simulator']);
