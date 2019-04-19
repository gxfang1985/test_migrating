{include file='grn/mobile_member_index.tpl' trigger_create='true' list_title=$list_title}
<script language="JavaScript" text="text/javascript">
    {literal}
    (function($){
        var member_list = $('#member_list');
        member_list.on('create', function(e, data)
        {
            var redirect = data.responseData.list.redirect;
            if( redirect )
            {
                location.href = redirect;
            }
        });
    })(jQuery)
</script>
{/literal}
