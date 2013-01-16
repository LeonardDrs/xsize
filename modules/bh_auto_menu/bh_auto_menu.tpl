<!-- Copyright <a href="http://www.artisansduweb.com">Artisansduweb.com</a> -->
<div id="bh_auto_menu">
<br class="clear" />
<div id="smoothmenu1" class="ddsmoothmenu">
<br class="clear" />
</div>
</div>
{literal}
<script type="text/javascript">
$(document).ready(function(){
	$('#smoothmenu1').prepend($('#categories_block_left ul.tree').clone());
	$('#smoothmenu1 > ul').removeAttr('class');
	$('#smoothmenu1 > ul').removeAttr('style');
	{/literal}{if $BH_AM_DISPLAY_HB==1}{literal}
	{/literal}{/if}{literal}
	{/literal}{if $BH_AM_DISPLAY_CAT==0}{literal}
	$('#categories_block_left').remove();
	{/literal}{/if}{literal}
	$('#header').append($('#bh_auto_menu'));
	ddsmoothmenu.init({
		mainmenuid: "smoothmenu1", //menu DIV id
		orientation: 'h', //Horizontal or vertical menu: Set to "h" or "v"
		classname: 'ddsmoothmenu', //class added to menu's outer DIV
		contentsource: "markup" //"markup" or ["container_id", "path_to_menu_file"]
	});
});
</script>
{/literal}