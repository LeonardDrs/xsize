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
*  @version  Release: $Revision: 14008 $
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

{if isset($products)}
{$HOOK_TOP_LIST_PRODUCTS_CATEGORY}
	<!-- Products list -->
	<section id="product_list" class="clearfix">
		{foreach from=$products item=product name=products}
					<figure class="ajax_block_product {foreach from=$product.attribute item=attribute}{foreach from=$attribute item=attr}{$attr|replace:[' ',',']:'_'} {/foreach}{/foreach}{if $smarty.foreach.products.first}first_item{elseif $smarty.foreach.products.last}last_item{/if} {if $smarty.foreach.products.index % 2}alternate_item{else}item{/if} clearfix">
						<a href="{$product.link|escape:'htmlall':'UTF-8'}" class="product_img_link" title="{$product.name|escape:'htmlall':'UTF-8'}"><img class="imgBorder" src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home')}" alt="{$product.legend|escape:'htmlall':'UTF-8'}" {if isset($homeSize)} width="180" height="180"{/if} data-largeUrl="{$link->getImageLink($product.link_rewrite, $product.id_image,'thickbox')}"/></a>
						<figcaption id="marque">{$product.name|truncate:40:'...'|strip_tags:'UTF-8'}</figcaption> 
						<figcaption id="produit">{$product.manufacturer_name}</figcaption> 
						<figcaption id="prix">{if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}{if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if}{/if}</figcaption> 
					</figure>
		{/foreach}
		<!-- Pagination -->
		{include file="$tpl_dir./pagination.tpl"}
		<!-- /Pagination -->
	</section>
	<!-- /Products list -->
{/if}
