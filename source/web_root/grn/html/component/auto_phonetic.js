/**
 * Component for automatic sort key input.
 * For example, furigana and pinyin.
 */
grn.base.namespace("grn.component.auto_phonetic");

grn.component.auto_phonetic = function(nameId, sortKeyId) {
    // target element
    var nameElement_ = document.getElementById(nameId);
    var sortKeyElement_ = document.getElementById(sortKeyId);

    var config = {
        interval :30, // check interval of name value. (milli second)
        intervalId : null, // interval handler
        conversion : false, // kanji conversion flag
        removeString : new RegExp('[^ 　ぁあ-んヴー]', 'g'), // Character outside the target
        smallCharacter : new RegExp('[ぁぃぅぇぉっゃゅょ]', 'g'), // small letter
        alphabet : new RegExp('[ a-zA-Z]', 'g') // alphabet
    };

    var buffer = {
        input        :'', // temp input char
        output       :'', // temp output char
        nameValue    :'', // name field's value
        sortKeyValue :''  // sort key field's value
    };

    var startCheckName = function() {
        stateInput();
        config.intervalId = setInterval(checkName, config.interval);
    };

    var blurEvent = function() {
        stopCheckName();
        insertAlphabet();
    };

    var insertAlphabet = function() {
        var alphabetMatch = nameElement_.value.match(config.alphabet);
        var alphabetName = (alphabetMatch instanceof Array) ? alphabetMatch.join('') : '';
        if ( alphabetName == nameElement_.value && sortKeyElement_.value.replace(/\s/g, '').length == 0 ) {
            sortKeyElement_.value = alphabetName;
        }
    };

    var stopCheckName = function() {
        clearInterval(config.intervalId);
    };

    /**
     * @param {Event} e
     */
    var keyDown = function(e) {
        if ( config.conversion ) {
            stateInput();
        }
    };

    var stateInput = function() {
        buffer.nameValue = nameElement_.value;
        buffer.sortKeyValue = sortKeyElement_.value;
        config.conversion = false;
    };

    var checkName = function() {
        var newInput = nameElement_.value;
        if ( newInput == '' ) {
            initialize();
        } else {
            newInput = removeInvalidString(newInput);
            if ( buffer.input != newInput ) {
                buffer.input = newInput;
                if ( ! config.conversion ) {
                    var newValue = newInput.replace(config.removeString, '');
                    checkConversion(newValue);
                    setSortKey(newValue);
                }
            }
        }
    };

    /**
     * initialize settings and text
     */
    var initialize = function() {
        buffer.input = '';
        buffer.output = '';
        buffer.nameValue = '';
        buffer.sortKeyValue = '';
        sortKeyElement_.value = '';
        config.conversion = false;
    };

    /**
     * remove invalid character
     * @param {String} string
     * @return {String}
     */
    var removeInvalidString = function(string) {
        if ( string.indexOf( buffer.nameValue ) != -1 ) {
            return string.replace(buffer.nameValue, '');
        } else {
            var ignoreArray = buffer.nameValue.split('');
            var inputArray = string.split('');
            for ( var i = 0; i < inputArray.length; i++ ) {
                if ( ignoreArray[i] == inputArray[i] ) {
                    inputArray[i] = '';
                }
            }
            return inputArray.join('');
        }
    };

    /**
     * set phonetic character to sortKeyElement
     * @param {String} string
     */
    var setSortKey = function(string) {
        if ( ! config.conversion ) {
            buffer.output = string;
            sortKeyElement_.value = buffer.sortKeyValue + buffer.output;
        }
    };

    /**
     * check kanji conversion
     * @param {String} string
     */
    var checkConversion = function(string) {
        if ( config.conversion ) {
            return;
        }
        if ( Math.abs( buffer.output.length - string.length ) > 1 ) {
            var tmpString = string.replace( buffer.output, '' ); // 新しく増えた文字が
            var smallCharCount = ( tmpString.search( config.smallCharacter ) == -1 ) ? 0 : 1; // 拗音だったら
            if ( Math.abs( buffer.output.length - string.length + smallCharCount ) > 1 ) { // 入力文字列の長さを1文字分減らす
                stateConversion();
            }
        } else if( buffer.output.length == buffer.input.length && buffer.output != buffer.input ) {
            stateConversion();
        }
    };

    var stateConversion = function() {
        buffer.sortKeyValue = buffer.sortKeyValue + buffer.output;
        config.conversion = true;
        buffer.output = '';
    };

    // set event listener
    jQuery(nameElement_).focus(startCheckName);
    jQuery(nameElement_).keydown(keyDown);
    jQuery(nameElement_).blur(blurEvent);
};
