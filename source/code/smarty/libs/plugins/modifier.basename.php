<?php
// @codingStandardsIgnoreStart

function smarty_modifier_basename( $path )
{
    // $smarty.template contains locale prefix.
    // we have to remove it.
    $pos = strpos( $path, '/' ) + 1;
    $tpl_path = substr( $path, $pos );

    // remove sufix.
    $parts = explode( '.', $tpl_path );
    return $parts[0];
}

// @codingStandardsIgnoreEnd
?>