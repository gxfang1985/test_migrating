<td id="view_part" valign="center">
    <input class="line" type="button" name="to_add" value="{cb_msg module='grn.address' key='GRN_ADDR-161' replace='true'}" onClick="if( ! grn_is_selected( this.form,'c_uid[]' ) ) return false; this.form.func.value='{$add_users}_to';PrepareSubmit( this.form, 'c_uid[]' );submit()"><br><input class="line" type="button" name="to_delete" value="{cb_msg module='grn.address' key='GRN_ADDR-162' replace='true'}" onClick="if( ! grn_is_selected( this.form,'s_uid_to[]' ) ) return false; this.form.func.value='{$remove_users}_to';PrepareSubmit( this.form, 's_uid_to[]' );submit()">
</td>
<td id="view_part">

    To<br>
    <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <select name="s_uid_to[]" size="5" multiple>
                    {foreach from=$selected_users.to item=user}
                        {if $user.raw_address}
                            <option value="{$user.uid}:{$user.escape_address}">{$user.email_address|escape}</option>
                        {else}
                            <option value="{$user.uid}:{$user.escape_address}">&quot;{$user.display_name}&quot; &lt;{$user.email_address|escape}&gt;</option>
                        {/if}
                    {/foreach}
                    <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                </select>
            </td>
            <td>&nbsp;</td>
            <td>
                <a href="javascript:OrderTop('list', 's_uid_to[]')">{grn_image image='order_top20.gif' alt=''}</a><br>
                <a href="javascript:OrderUp('list', 's_uid_to[]')">{grn_image image='order_up20.gif' alt=''}</a><br>
                <a href="javascript:OrderDown('list', 's_uid_to[]')">{grn_image image='order_down20.gif' alt=''}</a><br>
                <a href="javascript:OrderBottom('list', 's_uid_to[]')">{grn_image image='order_bottom20.gif' alt=''}</a>
            </td>
        </tr>
    </table>

</td>
</tr>
<tr>
    <td id="view_part" valign="center">
        <input class="line" type="button" name="cc_add" value="{cb_msg module='grn.address' key='GRN_ADDR-163' replace='true'}" onClick="if( ! grn_is_selected( this.form,'c_uid[]' ) ) return false; this.form.func.value='{$add_users}_cc';PrepareSubmit( this.form, 'c_uid[]' );submit()"><br><input class="line" type="button" name="cc_delete" value="{cb_msg module='grn.address' key='GRN_ADDR-164' replace='true'}" onClick="if( ! grn_is_selected( this.form,'s_uid_cc[]' ) ) return false; this.form.func.value='{$remove_users}_cc';PrepareSubmit( this.form, 's_uid_cc[]' );submit()">
    </td>
    <td id="view_part">
        Cc<br>
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <select name="s_uid_cc[]" size="5" multiple>
                        {foreach from=$selected_users.cc item=user}
                            {if $user.raw_address}
                                <option value="{$user.uid}:{$user.escape_address}">{$user.email_address|escape}</option>
                            {else}
                                <<option value="{$user.uid}:{$user.escape_address}">&quot;{$user.display_name}&quot; &lt;{$user.email_address|escape}&gt;</option>
                            {/if}
                        {/foreach}
                        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                    </select>
                </td>
                <td>&nbsp;</td>
                <td>
                    <a href="javascript:OrderTop('list', 's_uid_cc[]')">{grn_image image='order_top20.gif' alt=''}</a><br>
                    <a href="javascript:OrderUp('list', 's_uid_cc[]')">{grn_image image='order_up20.gif' alt=''}</a><br>
                    <a href="javascript:OrderDown('list', 's_uid_cc[]')">{grn_image image='order_down20.gif' alt=''}</a><br>
                    <a href="javascript:OrderBottom('list', 's_uid_cc[]')">{grn_image image='order_bottom20.gif' alt=''}</a>
                </td>
            </tr>
        </table>
    </td>
</tr>
<tr>
    <td id="view_part" valign="center">
        <input class="line" type="button" name="bcc_add" value="{cb_msg module='grn.address' key='GRN_ADDR-165' replace='true'}" onClick="if( ! grn_is_selected( this.form,'c_uid[]' ) ) return false; this.form.func.value='{$add_users}_bcc';PrepareSubmit( this.form, 'c_uid[]' );submit()"><br><input class="line" type="button" name="bcc_delete" value="{cb_msg module='grn.address' key='GRN_ADDR-166' replace='true'}" onClick="if( ! grn_is_selected( this.form,'s_uid_bcc[]' ) ) return false; this.form.func.value='{$remove_users}_bcc';PrepareSubmit( this.form, 's_uid_bcc[]' );submit()">
    </td>
    <td id="view_part">
        Bcc<br>
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <select name="s_uid_bcc[]" size="5" multiple>
                        {foreach from=$selected_users.bcc item=user}
                            {if $user.raw_address}
                                <option value="{$user.uid}:{$user.escape_address}">{$user.email_address|escape}</option>
                            {else}
                                <option value="{$user.uid}:{$user.escape_address}">&quot;{$user.display_name}&quot; &lt;{$user.email_address|escape}&gt;</option>
                            {/if}
                        {/foreach}
                        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                    </select>
                </td>
                <td>&nbsp;</td>
                <td>
                    <a href="javascript:OrderTop('list', 's_uid_bcc[]')">{grn_image image='order_top20.gif' alt=''}</a><br>
                    <a href="javascript:OrderUp('list', 's_uid_bcc[]')">{grn_image image='order_up20.gif' alt=''}</a><br>
                    <a href="javascript:OrderDown('list', 's_uid_bcc[]')">{grn_image image='order_down20.gif' alt=''}</a><br>
                    <a href="javascript:OrderBottom('list', 's_uid_bcc[]')">{grn_image image='order_bottom20.gif' alt=''}</a>
                </td>
            </tr>
        </table>
    </td>
</tr>