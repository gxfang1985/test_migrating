{if $sso_link.count == 0}
 {literal}
<iframe name="sso_frame" src="{/literal}{grn_pageurl page='grn/sso/sso/request_dummy_frame' dummy=1}{literal}" style="display:none;" width="0" height="0" frameborder="0" onload='onLoadSSOFrame();'></iframe>
<script language="javascript" type="text/javascript">
<!--

var g_status       = '';
var g_redirect_url = '';
var g_target       = '';

function onLoadSSOFrame()
{
  //Redirect Other System
  if (g_status == 'redirect')
  {
    g_status = '';
    if (g_target != '')
    {
      //Open Other Window
      window.open(g_redirect_url, g_target);    
    }
    else
    {
      //Open Same Window
      window.location.href = g_redirect_url;
    }
  }

  //Submit SSO Form
  if (g_status == 'submit')
  {
    g_status = 'redirect';
    frame = window.frames['sso_frame'];
    form = frame.document.forms[0];
    if (form != undefined)
    {
      form.submit();
    }
    else
    {
      onLoadSSOFrame();
    }
  }

  return;
}

function onClickSSOLink(iframe_url, redirect_url, target)
{
  //Set Global Parameters
  g_redirect_url = redirect_url;
  g_target       = target;

  //Open IFrame with Source URL
  window.open(iframe_url, 'sso_frame');
  g_status = 'submit';
  return;
}
//-->
</script>
 {/literal}
 {/if}
{assign var="sso_link_count" value=$sso_link.count}
{capture name="washed_url" assign="washed_url"}{$redirect_url|escape:'javascript'|escape:'url'}{/capture}
{capture name="washed_iframe_url" assign="washed_iframe_url"}{$iframe_url|escape:'javascript'|escape:'url'}{/capture}
{if $truncated_caption}
 {grn_link caption=$caption truncated_caption=$truncated_caption image=$image script="javascript:onClickSSOLink('$washed_iframe_url', '$washed_url', '$target');" page_direct=TRUE}
{else}
 {grn_link caption=$caption image=$image script="javascript:onClickSSOLink('$washed_iframe_url', '$washed_url', '$target');" page_direct=TRUE}
{/if}
