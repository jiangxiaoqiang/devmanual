var FindProxyForURL = function(init, profiles) {
    return function(url, host) {
        "use strict";
        var result = init, scheme = url.substr(0, url.indexOf(":"));
        do {
            result = profiles[result];
            if (typeof result === "function") result = result(url, host, scheme);
        } while (typeof result !== "string" || result.charCodeAt(0) === 43);
        return result;
    };
}("+dolphin2", {
    "+dolphin2": function(url, host, scheme) {
        "use strict";
        if (/^59\.214\.215\.6$/.test(host)) return "+dolphin-proxy";
        if (/^10\.10\.1\.11$/.test(host)) return "+dolphin-proxy";
        return "DIRECT";
    },
    "+dolphin-proxy": function(url, host, scheme) {
        "use strict";
        if (/^127\.0\.0\.1$/.test(host) || /^::1$/.test(host) || /^localhost$/.test(host)) return "DIRECT";
        return "PROXY 10.55.10.2:8888";
    }
});