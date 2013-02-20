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

{capture name=path}{l s='Your shopping cart'}{/capture}
{include file="$tpl_dir./breadcrumb.tpl"}


{assign var='current_step' value='summary'}
{include file="$tpl_dir./order-steps.tpl"}
{include file="$tpl_dir./errors.tpl"}

{if isset($empty)}
	<p class="warning">{l s='Your shopping cart is empty.'}</p>
{elseif $PS_CATALOG_MODE}
	<p class="warning">{l s='This store has not accepted your new order.'}</p>
{else}
	<script type="text/javascript">
	// <![CDATA[
	var currencySign = '{$currencySign|html_entity_decode:2:"UTF-8"}';
	var currencyRate = '{$currencyRate|floatval}';
	var currencyFormat = '{$currencyFormat|intval}';
	var currencyBlank = '{$currencyBlank|intval}';
	var txtProduct = "{l s='product'}";
	var txtProducts = "{l s='products'}";
	// ]]>
	</script>
	<p style="display:none" id="emptyCartWarning" class="warning">{l s='Your shopping cart is empty.'}</p>
	<section id="produits">
		<table>
			<tr id="title">
				<th class="first-item">Produit(s)</th>
				<th>Description</th>
				<th>Dispo.</th>
				<th>Prix unitaire</th>
				<th>Quantité</th>
				<th class="last-item">Total TTC</th>
			</tr>
			{foreach from=$products item=product name=productLoop}
				{assign var='productId' value=$product.id_product}
				{assign var='productAttributeId' value=$product.id_product_attribute}
				{assign var='quantityDisplayed' value=0}
				{* Display the product line *}
				{include file="$tpl_dir./shopping-cart-product-line.tpl"}
			{/foreach}
		</table>
	</section>
	<section class="page" id="recap-produits">
		<section class="right">
			<p>Total produits TTC : {displayPrice price=$total_products_wt}</p>
			<p>Total des frais de port TTC : {displayPrice price=$shippingCost}</p>
			<p id="total">Total TTC : {displayPrice price=$total_price}</p>
		</section>
		{if $voucherAllowed}
		<section id="reduc">
			{if isset($errors_discount) && $errors_discount}
				<ul class="error">
				{foreach from=$errors_discount key=k item=error}
					<li>{$error|escape:'htmlall':'UTF-8'}</li>
				{/foreach}
				</ul>
			{/if}
			<form action="{if $opc}{$link->getPageLink('order-opc.php', true)}{else}{$link->getPageLink('order.php', true)}{/if}" method="post" id="voucher">
					<p>Bons de réduction</p>
					<div><label for="discount_name">{l s='Code:'}</label>
						<input type="text" id="discount_name" name="discount_name" value="{if isset($discount_name) && $discount_name}{$discount_name}{/if}" />
					<p class="submit"><input type="hidden" name="submitDiscount" /><input type="submit" name="submitAddDiscount" value="{l s='Add'}" class="button" /></p>
				{if $displayVouchers}
					<h4>{l s='Take advantage of our offers:'}</h4>
					<div id="display_cart_vouchers">
					{foreach from=$displayVouchers item=voucher}
						<span onclick="$('#discount_name').val('{$voucher.name}');return false;" class="voucher_name">{$voucher.name}</span> - {$voucher.description} <br />
					{/foreach}
					</div>
				{/if}
			</form>
		</section>
		{/if}
		{if !$opc}<a href="{$link->getPageLink('order.php', true)}?step=1{if $back}&amp;back={$back}{/if}" class="exclusive nextstep" title="{l s='Next'}">Suivant</a>{/if}
	</section>
{/if}