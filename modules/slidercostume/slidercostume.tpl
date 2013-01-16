<!-- MODULE slider de costumes -->
<div id="featuredP">
	<div id="titreTopVente"><h2 id="titre-costume">NOS COSTUMES</h2></div>
		{if isset($products) AND $products}
			<div id="navFeat">
				<a id="featuredNavLeft" title="produitsInf" href="/">Précédent</a>
				<a id="featuredNavRight" title="produitsSup" href="/">Suivant</a>
			</div><!-- end of #navFeat -->
			<ul class="clearfix">
			{foreach from=$products item=product name=homeFeaturedProducts}
				<li class="{if $smarty.foreach.homeFeaturedProducts.first}first_item{elseif $smarty.foreach.homeFeaturedProducts.last}last_item{else}item{/if} {if $smarty.foreach.homeFeaturedProducts.iteration%$nbItemsPerLine == 0}last_item_of_line{elseif $smarty.foreach.homeFeaturedProducts.iteration%$nbItemsPerLine == 1}clear{/if} {if $smarty.foreach.homeFeaturedProducts.iteration > ($smarty.foreach.homeFeaturedProducts.total - ($smarty.foreach.homeFeaturedProducts.total % $nbItemsPerLine))}last_line{/if}">
					<a href="{$product.link}" title="{$product.name|escape:html:'UTF-8'}"><img class ="imgTopp" src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_best_seller')}" alt="{$product.name|escape:html:'UTF-8'}" /></a>
					<div class="prodDesc">
						<h3>{$product.manufacturer_name}</h3>
						<h4>{$product.name|strip_tags|truncate:13:'...'}</h4>
						<p>{if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if}</p>
					<div>
				</li>
			{/foreach}
			</ul>
		{else}
			<p>{l s='No featured products' mod='homefeatured'}</p>
		{/if}
		{if $products|@count>4}
		{literal}
			<script type="text/javascript" charset="utf-8">
			var $featuredP = $('#featuredP');
			$ul = $featuredP.find('ul');
			$featuredP.find('#navFeat').css('display','block').find('a').css('z-index',9999);
			$ul.css({'position':'relative','right':0});
			var anim = false;
			$featuredP.find('#featuredNavLeft').click(function() {
				if (anim){return false;}
				var currRight = parseInt($ul.css('right').split('px')[0]);
				if (currRight<=0) {return false};
				anim=true;
				$ul.animate({'right':currRight-$ul.find('li').outerWidth(true)+"px"},function() {
					anim=false;
				});
				return false;
			})
			$featuredP.find('#featuredNavRight').click(function() {
				if (anim){return false;}
				var currRight = parseInt($ul.css('right').split('px')[0]);
				if (currRight>=$ul.find('li').outerWidth(true)*($ul.find('li').length-4)) {return false};
				anim=true;
				$ul.animate({'right':currRight+$ul.find('li').outerWidth(true)+"px"},function() {
					anim = false;
				});
				return false;
			})
			</script>
		{/literal}
		{/if}
</div><!-- end of #featuredP -->



<!-- /MODULE Home Featured Products -->
