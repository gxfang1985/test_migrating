(function($){
    "use strict";

    var textarea;
    if( typeof grn !== "undefined" ) {
        grn.base.namespace("grn.component.textarea");
        textarea = grn.component.textarea;
        textarea.disableAutoInit = false;
    }

    var expand_height_margin = 30;
    var narrow_gap = 30;

    window.grn_autoexpand_textarea = function( elm ) {
        var height = $(elm).css('height');
        if( height != null && height.slice != undefined )
        {
            height = parseInt( height.slice( 0, -2 ) );
        } else {
            height = $(elm).outerHeight();
        }
        //min_height は必ず narrow_gap より大きい値にする。
        var textarea_min_height =  height > narrow_gap ? height : narrow_gap + 1;

        var prev_height = elm.offsetHeight;

        $(elm).css({'minHeight': textarea_min_height + 'px' });

        if( $(elm).hasClass('noautoexpand') ) {
            return;
        }

        function autoexpand(){
            if( grn.browser.msie )
            {
                // テキストエリアの拡張
                if( elm.scrollHeight  > elm.offsetHeight )
                {
                    $(elm).css( {'height': Math.max( elm.scrollHeight + expand_height_margin, textarea_min_height ) + 'px' } ) ;
                }
                else
                {
                    //縮小しない
                }
            }
            else
            {
                var dummy_elm = document.getElementById( "dummy_textarea_" + elm.id );
                dummy_elm.value = elm.value;
                $(dummy_elm).css( {'height': textarea_min_height + 'px'} );

                if( dummy_elm.scrollHeight > dummy_elm.offsetHeight ) {
                    $(dummy_elm).css( {'height': Math.max( dummy_elm.scrollHeight + expand_height_margin, textarea_min_height ) + 'px'} ) ;
                } else {
                    var current_height = dummy_elm.offsetHeight;
                    while( dummy_elm.scrollHeight < dummy_elm.offsetHeight && dummy_elm.offsetHeight >= textarea_min_height && current_height > 0) {
                        current_height = dummy_elm.offsetHeight - narrow_gap;
                        $(dummy_elm).css( {'height': Math.max(current_height, 0) + 'px' } );

                        // Exit this loop if setStyle can not set style.
                        // Occur with iOS5 + Safari.
                        if( dummy_elm.style.height != Math.max(current_height, 0) )
                            break;
                    }

                    $(dummy_elm).css( {'height': Math.max( dummy_elm.scrollHeight + expand_height_margin, textarea_min_height ) + 'px'} ) ;
                }

                // ユーザーが手動でテキストエリアを拡張した場合は縮小しない
                if( prev_height != elm.offsetHeight && elm.offsetHeight > dummy_elm.offsetHeight )
                    return;

                $(elm).css( {'height': dummy_elm.style.height} );
                prev_height = elm.offsetHeight;
            }
        }

        $(elm).on( 'keyup', autoexpand );
        if( ! grn.browser.msie )
        {
            $(elm).on( 'keydown', autoexpand );
            $(elm).on( 'change', autoexpand );
        }

        $(elm).on( 'paste',function(){
            setTimeout( function(){ autoexpand(elm);}, 100 );
        });

        $(elm).on('grn.textarea:resize', autoexpand);

        autoexpand();
    };

    $(function (){
        if (textarea && textarea.disableAutoInit) {
            return;
        }

        $("textarea.autoexpand").each(function(){
            grn_autoexpand_textarea($(this)[0]);
        });

        $(document).trigger('grn.textarea:initialized');
    });
})(jQuery);
