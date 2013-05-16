{*
* 2007-2012 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2012 PrestaShop SA
*  @version  Release: $Revision: 14011 $
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

<!-- MODULE Home Featured Products -->
<div id="featuredP">
	<div id="titreTopVente"><h2>NOS MEILLEURES VENTES</h2></div>
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
						<h3>{$product.name|strip_tags|truncate:30:'...'}</h3>
						<h4>{$product.manufacturer_name}</h4>
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
			$('#featuredNavLeft').css('left','-10000px');
			var $featuredP = $('#featuredP');
			$ul = $featuredP.find('ul');
			$featuredP.find('#navFeat').css('display','block').find('a').css('z-index',9999);
			$ul.css({'position':'relative','right':0});
			var anim = false;
			$featuredP.find('#featuredNavLeft').click(function() {
				$('#featuredNavRight').css('right','2px');
				if (anim){return false;}
				var currRight = parseInt($ul.css('right').split('px')[0]);
				anim=true;
				$ul.animate({'right':currRight-$ul.find('li').outerWidth(true)+"px"},function() {
					anim=false;
				});
				if (currRight-$ul.find('li').outerWidth(true)<=0) {
					$('#featuredNavLeft').css('left','-10000px');
					return false
				};
				return false;
			})
			$featuredP.find('#featuredNavRight').click(function() {
				$('#featuredNavLeft').css('left','12px');
				if (anim){return false;}
				var currRight = parseInt($ul.css('right').split('px')[0]);
				anim=true;
				$ul.animate({'right':currRight+$ul.find('li').outerWidth(true)+"px"},function() {
					anim = false;

				});
				if (currRight+$ul.find('li').outerWidth(true)>=$ul.find('li').outerWidth(true)*($ul.find('li').length-4)) {
					$('#featuredNavRight').css('right','-100000px');
					return false
					};
				return false;
			})
			</script>
		{/literal}
		{/if}
</div><!-- end of #featuredP -->



<!-- /MODULE Home Featured Products -->
