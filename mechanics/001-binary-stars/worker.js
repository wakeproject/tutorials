importScripts('/require.js');

require({
    waitSeconds: 20,
    paths: {
        cs: '/cs',
        underscore: '/underscore',
        baseUrl: '/tutorials/mechanics/001-binary-stars/'
    }
}, ['cs!simulator']);
