importScripts('/javascripts/require.js');

require({
    paths: {
        cs: '/javascripts/cs',
        underscore: '/javascripts/underscore',
        baseUrl: '/tutorials/mechanics/001-binary-stars/'
    }
}, ['cs!generator']);
