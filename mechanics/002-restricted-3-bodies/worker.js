importScripts('/javascripts/require.js');

require({
    paths: {
        cs: '/javascripts/cs',
        underscore: '/javascripts/underscore',
        baseUrl: '/tutorials/mechanics/002-binary-stars/'
    }
}, ['cs!simulator']);
