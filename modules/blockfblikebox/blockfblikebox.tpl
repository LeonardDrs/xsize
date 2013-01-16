<!-- MODULE Block advertising -->
<div class="facebook_like_box_block">
	<div class="topRightColumn">{l s='Retrouvez-nous sur Facebook' mod='blockfblikebox'}</div>
    <iframe src="http://www.facebook.com/plugins/likebox.php?href={$facebook_page_url|escape:'url'}&amp;width={$facebook_width}&amp;connections={$facebook_connections}&amp;stream={$facebook_stream}&amp;header={$facebook_header}&amp;height={$facebook_height}" scrolling="no" frameborder="0" style="{if $allow_transparency == 'false'}background-color: {$bg_color};{/if}border:none; overflow:hidden; width:{$facebook_width}px; height:{$facebook_height}px;" {if $allow_transparency == 'true'}allowtransparency=" allowtransparency"{/if}></iframe>
</div>
<!-- /MODULE Block advertising -->