<!-- MODULE Slider t  -->
  <div id="banner" class="grid_16">
    <div id="banner-imgs">
    {foreach from=$slides item=slide}
		{if $slide.title}
        <a href="{$slide.href}" ><img src="{$slide.url}" alt="{$slide.title}" /></a>
		{/if}
 {/foreach}
    </div>
  </div>
<div id="reset"></div><!-- end of #reset -->
<!-- /MODULE Slider  -->