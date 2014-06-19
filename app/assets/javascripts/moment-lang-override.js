// moment.js language configuration
// Adapted for the desired Remit format.

(function (factory) {
    if (typeof define === 'function' && define.amd) {
        define(['moment'], factory); // AMD
    } else if (typeof exports === 'object') {
        module.exports = factory(require('../moment')); // Node
    } else {
        factory(window.moment); // Browser global
    }
}(function (moment) {
    return moment.lang('en-gb', {
        relativeTime : {
            future : "",
            past : "%s ago",
            s : "0m",
            m : "1m",
            mm : "%dm",
            h : "1h",
            hh : "%dh",
            d : "1d",
            dd : "%dd",
            M : "1mo",
            MM : "%dmo",
            y : "1y",
            yy : "%dy"
        },
    });
}));
