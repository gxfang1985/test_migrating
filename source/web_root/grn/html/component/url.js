/**
 * Module URL
 *
 * Provides methods to create and parse url.
 * Supports parsing query string and hash parameters.
 * The hash parameters can be parsed if the parameters in the hash should be in query string format.
 *  e.g: /cgi-bin/cbgrn/grn.exe/schedule/view?id=1&bdate=2014-01-10#commentId=9&foo=10
 *
 * EXAMPLE:
 *
 * -- Create URL
 *
 * grn.component.url.page('schedule/view', {id:1, bdate:'2014-01-10'})
 * // Output: "/cgi-bin/cbgrn/grn.exe/schedule/view?id=1&bdate=2014-01-10"
 *
 * grn.component.url.page('schedule/view', {id:1, bdate:'2014-01-10'}, "Comment")
 * // Output: "/cgi-bin/cbgrn/grn.exe/schedule/view?id=1&bdate=2014-01-10#Comment"
 *
 * grn.component.url.page('schedule/view', {id:1, bdate:'2014-01-10'}, {commentId: 9})
 * // Output: "/cgi-bin/cbgrn/grn.exe/schedule/view?id=1&bdate=2014-01-10#commentId=9"
 *
 * grn.component.url.setParameters('path/to/page?foo=111&bar=222', {foo:999, hoge:3})
 * // Output: "path/to/page?foo=999&bar=222&hoge=3"
 *
 * grn.component.url.setParameters('path/to/page?#bar=10', null, {hoge:22, bar:99})
 * // Output: "path/to/page?#bar=99&hoge=22"
 *
 * -- Parse URL
 *
 * grn.component.url.getQueryString('/cgi-bin/cbgrn/grn.exe/schedule/view?id=1&bdate=2014-01-10')
 * // Output: "id=1&bdate=2014-01-10"
 *
 * // Parse a query string
 * grn.component.url.parseQueryString('/cgi-bin/cbgrn/grn.exe/schedule/view?id=1&bdate=2014-01-10')
 * // Output: Object {id: "1", bdate: "2014-01-10"}
 *
 * // Parse a hash parameter
 * grn.component.url.parseHash('/cgi-bin/cbgrn/grn.exe/schedule/view?id=1&bdate=2014-01-10#commentId=9&foo=20')
 * // Output: Object {commentId: "9", foo: "20"}
 */

if (!grn.base.isNamespaceDefined("grn.component.url")) {

    grn.base.namespace("grn.component.url");

    grn.component.url = (function () {
        'use strict';

        // The following properties should be set in the external template

        grn.component.url.PAGE_PREFIX = 'cbgrn';
        grn.component.url.PAGE_EXTENSION = '';
        grn.component.url.STATIC_URL = '/cbgrn';
        grn.component.url.BUILD_DATE = '';

        /**
         * Create a static URL
         * @param {string} path - Path to the static resource
         * @param {string|object} params - The query string or if it's object it will be serialized to query string
         * @returns {string}
         */
        function staticUrl(path, params) {
            return staticUrlInternal(path, params, false);
        }

        /**
         * Create a static URL
         * @param {string} path - Path to the static resource
         * @param {string|object} params - The query string or if it's object it will be serialized to query string
         * @param {boolean} noBuildDate - Set "true" to append build date to the end of the given URL
         * @returns {string}
         */
        function staticUrlInternal(path, params, noBuildDate) {
            var url = grn.component.url.STATIC_URL;

            if (path) {
                url += '/' + path;
            }

            url = appendQueryData(url, params, noBuildDate);

            return url;
        }

        /**
         * Create url to an image
         * @param path - Path to the image static resource
         * @param {string|object} params - The query string or if it's object it will be serialized to query string
         * @returns {string}
         */
        function image(path, params) {
            var url = staticUrlInternal('grn/image', null, true);

            if (path) {
                url += '/' + path;
            }

            url = appendQueryData(url, params);

            return url;
        }

        /**
         * Parse a URL and return its components
         * @param url
         * @returns {{pathname: string, search: string, hash: string}}
         */
        function parse(url) {
            var pathname = url;
            var query_position = url.indexOf("?");
            var search = '';

            if (query_position !== -1) {
                pathname = url.substr(0, query_position);
                search = toQueryString(parseQueryString(url));
            }

            var hash = getHash(url);

            return {
                pathname: pathname,
                search: search,
                hash: hash
            };
        }

        /**
         * Set parameters to the given URL. If the parameter already exists,
         * this will override all of the existing value that correspond to the parameter name.
         * @param {string} url
         * @param {object} query_params
         * @param {object|string} hash_params
         * @returns {string}
         */
        function setParameters(url, query_params, hash_params) {
            var components = parse(url);
            var current_query_params = parseQueryString(components.search);
            var current_hash_params = parseHash(url);
            var name;

            // update query params
            if (typeof query_params === "object") {
                for (name in query_params) {
                    if (!query_params.hasOwnProperty(name)) {
                        continue;
                    }

                    current_query_params[name] = query_params[name];
                }
            }

            // update hash params
            if (typeof current_hash_params === "object" && typeof hash_params === "object") {
                for (name in hash_params) {
                    if (!hash_params.hasOwnProperty(name)) {
                        continue;
                    }

                    current_hash_params[name] = hash_params[name];
                }
            } else {
                current_hash_params = hash_params;
            }

            // create new url
            var new_url = components.pathname + '?' + toQueryString(current_query_params);

            if (typeof current_hash_params === "string" && current_hash_params !== "") {
                new_url += "#" + current_hash_params;
            } else if (typeof current_hash_params === "object" && Object.keys(current_hash_params).length > 0) {
                new_url += "#" + toQueryString(current_hash_params);
            }

            return new_url;
        }

        /**
         * Append query string to the given URL
         * @param {string} url
         * @param {object} params
         * @param {object} [noBuildDate]
         * @returns {string}
         */
        function appendQueryData(url, params, noBuildDate) {
            var queryString = toQueryString(params);
            if (queryString.length > 0) {
                url += '?' + queryString;
            }

            if (noBuildDate === true) {
                return url;
            }

            var buildDate = grn.component.url.BUILD_DATE;
            if (buildDate) {
                url += url.indexOf('?') === -1 ? '?' : '&';
                url += buildDate;
            }

            return url;
        }

        /**
         * Create a Garoon URL
         * @param {string} page_path - The Garoon page. e.g schedule/view
         * @param {string|object} [params] - The query string or if it's object it will be serialized to query string
         * @param {string|object} [hash] - The hash string or if it's object it will be serialized to query string format
         */
        function page(page_path, params, hash) {
            page_path = page_path || 'index';
            var url = grn.component.url.PAGE_PREFIX +
                '/' + page_path + grn.component.url.PAGE_EXTENSION +
                '?';

            // Query string
            var queryString = toQueryString(params);
            if (queryString.length > 0) {
                url += queryString;
            }

            // URL hash
            url += formatHash(hash);

            return url;
        }

        /**
         * Serialize a object to query string
         * @param {string|object} params - The object to serialize
         */
        function toQueryString(params) {
            var queryString = '';

            if (typeof params === 'undefined') {
                return queryString;
            }

            if (typeof params === 'string') {

                queryString = params;

            } else if (typeof params === 'object') {

                var paramArray = [];
                for (var name in params) {
                    if (params.hasOwnProperty(name)) {
                        var value = params[name];
                        value = value == null ? '' : value;

                        paramArray.push(name + '=' + encodeURIComponent(value));
                    }
                }

                queryString = paramArray.join('&');
            }

            return queryString;
        }

        /**
         * Format URL hash
         * @param {string|object} hash - The hash name or hash array to serialize
         * - If the given value is string, it will be appended to "#"
         * - If the given value is key-value object, it will be serialized into query string format
         *   e.g. #foo=1&bar=2&hoge3
         */
        function formatHash(hash) {
            if (typeof hash === 'undefined') {

                return '';

            } else if (typeof hash === 'string') {

                return '#' + hash;

            } else if (typeof hash === 'object') {

                return '#' + toQueryString(hash);

            }

            return '';
        }

        /**
         * Get the query string from the given URL
         */
        function getQueryString(url) {
            var queryString = url;
            var pos = url.indexOf('?');
            if (pos !== -1) {
                queryString = url.substr(pos + 1);
            }

            return queryString;
        }

        function parseQueryParams(query_string) {
            if (query_string.length === 0) {
                return {};
            }

            // Parse query params
            var query_params = {};
            var query_string_array = query_string.split('&');
            var i, len;
            for (i = 0, len = query_string_array.length; i < len; i++) {
                var param = query_string_array[i].split('=');
                var name = param[0];
                var value = typeof param[1] !== "undefined" ? param[1] : '';

                /**
                 * On server side, to encode the URL, Garoon uses "urlencode" function which encodes spaces as plus (+) signs.
                 * But the plus sign will NOT be decoded by using "decodeURIComponent" function at client side.
                 * So the plus sign should be replaced with percent sign (%20) before using decodeURIComponent to decode.
                 */
                value = value.replace(/\+/g, '%20');

                if (name.length > 0) {
                    query_params[name] = decodeURIComponent(value);
                }
            }

            return query_params;
        }

        /**
         * Parse the query string of the given URL to key-value object
         */
        function parseQueryString(url) {
            var queryString = getQueryString(url);

            var hashPos = queryString.indexOf('#');
            // Remove hash in the query string
            if (hashPos !== -1) {
                queryString = queryString.substr(0, hashPos);
            }

            return parseQueryParams(queryString);
        }

        /**
         * Get the hash of the given URL
         */
        function getHash(url) {
            var hash = '';
            var hashPos = url.indexOf('#');
            if (hashPos !== -1) {
                hash = url.substr(hashPos + 1);
            }
            return hash;
        }

        /**
         * Change the hash of current URL
         * @param hash
         */
        function changeCurrentLocationHash(hash) {
            location.hash = formatHash(hash);
        }

        /**
         * Parse the hash of the given URL
         * The hash parameter should be in query string format.
         * e.g. somepage#foo=1&bar=2&hoge=3
         * @result {string|object}
         */
        function parseHash(url) {
            var hash = getHash(url);

            if (hash.length === 0) {
                return hash;
            }

            var isKeyValueParam = hash.match(/.*=/);   //e.g. foo=1
            if (isKeyValueParam == null) {
                return hash;
            }

            return parseQueryParams(hash);
        }

        return {
            staticUrl: staticUrl,
            image: image,
            page: page,
            parse: parse,
            setParameters: setParameters,
            toQueryString: toQueryString,
            getQueryString: getQueryString,
            parseQueryString: parseQueryString,
            getHash: getHash,
            changeCurrentLocationHash: changeCurrentLocationHash,
            parseHash: parseHash
        };

    }());

}