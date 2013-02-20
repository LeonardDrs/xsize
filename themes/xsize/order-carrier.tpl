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

{if !$opc}
	<script type="text/javascript">
	//<![CDATA[
		var orderProcess = 'order';
		var currencySign = '{$currencySign|html_entity_decode:2:"UTF-8"}';
		var currencyRate = '{$currencyRate|floatval}';
		var currencyFormat = '{$currencyFormat|intval}';
		var currencyBlank = '{$currencyBlank|intval}';
		var txtProduct = "{l s='product'}";
		var txtProducts = "{l s='products'}";

		var msg = "{l s='You must agree to the terms of service before continuing.' js=1}";
		{literal}
		function acceptCGV()
		{
			if ($('#cgv').length && !$('input#cgv:checked').length)
			{
				alert(msg);
				return false;
			}
			else
				return true;
		}
		{/literal}
	//]]>
	</script>
{else}
	<script type="text/javascript">
		var txtFree = "{l s='Free!'}";
	</script>
{/if}


{if !$opc}
{capture name=path}{l s='Shipping'}{/capture}
{include file="$tpl_dir./breadcrumb.tpl"}
{/if}

<!-- {if !$opc}<h1>{l s='Shipping'}</h1>{else}<h2>2. {l s='Delivery methods'}</h2>{/if} -->

{if !$opc}
{assign var='current_step' value='shipping'}
{include file="$tpl_dir./order-steps.tpl"}

{include file="$tpl_dir./errors.tpl"}

<section class="page" id="comptes">
	<form id="form" action="{$link->getPageLink('order.php', true)}" method="post" onsubmit="return acceptCGV();">
		<section id="panier5">
			<h2>Choisissez votre mode de livraison :</h2>
			<table>
				<tr>
					<th></th>
					<th>Transporteur</th>
					<th>Informations</th>
					<th>Prix</th>
				</tr>
				{if isset($carriers)}
					{foreach from=$carriers item=carrier name=myLoop}
						<tr>
							<td>
								<input type="radio" name="id_carrier" value="{$carrier.id_carrier|intval}" id="id_carrier{$carrier.id_carrier|intval}"  {if $opc}onclick="updateCarrierSelectionAndGift();"{/if} {if !($carrier.is_module AND $opc AND !$isLogged)}{if $carrier.id_carrier == $checked}checked="checked"{/if}{else}disabled="disabled"{/if} />
							</td>
							<td class="carrier_name">
								<label for="id_carrier{$carrier.id_carrier|intval}">
								{$carrier.name|escape:'htmlall':'UTF-8'}
								</label>
							</td>
							<td class="carrier_infos">{$carrier.delay|escape:'htmlall':'UTF-8'}</td>
							<td class="carrier_price">
								{if $carrier.price}
										{if $priceDisplay == 1}{convertPrice price=$carrier.price_tax_exc}{else}{convertPrice price=$carrier.price}{/if}
									{if $use_taxes}{if $priceDisplay == 1} {l s='(tax excl.)'}{else} {l s='(tax incl.)'}{/if}{/if}
								{else}
									{l s='Free!'}
								{/if}
							</td>
						</tr>
					{/foreach}
					<tr id="HOOK_EXTRACARRIER">{$HOOK_EXTRACARRIER}</tr>
				{/if}
			</table>
		</section>
		{if $conditions AND $cms_id}
			<p class="checkbox">
				<input type="checkbox" name="cgv" id="cgv" value="1" {if $checkedTOS}checked="checked"{/if} />
				<label for="cgv">{l s='I agree to the terms of service and adhere to them unconditionally.'}</label> <a href="{$link_conditions}" class="iframe">{l s='(read)'}</a>
			</p>
			<script type="text/javascript">$('a.iframe').fancybox();</script>
		{/if}

		<p class="cart_navigation submit">
			<input type="hidden" name="step" value="3" />
			<input type="hidden" name="back" value="{$back}" />
			<a href="{$link->getPageLink('order.php', true)}{if !$is_guest}?step=1{if $back}&back={$back}{/if}{/if}" title="{l s='Previous'}" class="button">&laquo; {l s='Previous'}</a>
			<!-- <a id="valid" href="{$link->getPageLink('order.php', true)}{if !$is_guest}?step=3{if $back}&back={$back}{/if}{/if}" title="{l s='Next'}" class="button"><img src="{$img_dir}/assets/valider.png" alt="Valider"/></a> -->
			<input type="submit" name="processCarrier" value="{l s='Next'}" class="exclusive" />
		</p>
	</form>
</section>
</div>
{/if}