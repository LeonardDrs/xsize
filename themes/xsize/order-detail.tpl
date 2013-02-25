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
*  @version  Release: $Revision: 14424 $
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

{if !isset($smarty.get.ajax)}
<div class="block-center" id="block-history">
	<div id="block-order-detail">
{/if}
<form action="{if isset($opc) && $opc}{$link->getPageLink('order-opc.php', true)}{else}{$link->getPageLink('order.php', true)}{/if}" method="post" class="submit">
	<div style="height:100px;">
		<input type="hidden" value="{$order->id}" name="id_order"/>
		<h4 id="h3formajax">
			{l s='Order placed on'} {dateFormat date=$order->date_add full=0}
		</h4>
		<input type="submit" value="{l s='Reorder'}" name="submitReorder" class="button exclusive" style="float:right; margin-top:30px;"/>
	</div>
</form>

{if count($order_history)}
<!--<p class="bold">{l s='Follow your order step by step'}</p>-->
<div class="table_block">
	<table id="tablooo" class="detail_step_by_step std">
		<tr>
			<td>{l s='Date'}</td>
			<td>:</td>
			<td>{l s='Status'}</td>
		</tr>
		<tr>
			<td>{l s='Commande'}</td>
			<td>:</td>
			<td><a class="color-myaccount" href="#">{l s='#'}{$order->id|string_format:"%06d"}</a></td>
		</tr>
		<tr>
			{if $carrier->id}
			<td>{l s='Transporteur'} </td>
			<td>:</td>
			<td>{if $carrier->name == "0"}{$shop_name|escape:'htmlall':'UTF-8'}{else}{$carrier->name|escape:'htmlall':'UTF-8'}{/if}</td>
			{/if}
		</tr>
		<tr>
			<td>{l s='Paiement'} </td>
			<td>:</td>
			<td>{$order->payment|escape:'htmlall':'UTF-8'}</td>
		</tr>
	</table>
	<!--<table class="detail_step_by_step std">
		<thead>
			<tr>
				<th class="first_item">{l s='Date'}</th>
				<th class="last_item">{l s='Status'}</th>
			</tr>
		</thead>
		<tbody>
		{foreach from=$order_history item=state name="orderStates"}
			<tr class="{if $smarty.foreach.orderStates.first}first_item{elseif $smarty.foreach.orderStates.last}last_item{/if} {if $smarty.foreach.orderStates.index % 2}alternate_item{else}item{/if}">
				<td>{dateFormat date=$state.date_add full=1}</td>
				<td>{$state.ostate_name|escape:'htmlall':'UTF-8'}</td>
			</tr>
		{/foreach}
		</tbody>
	</table>-->
</div>
{/if}

{if isset($followup)}
<p class="bold">{l s='Click the following link to track the delivery of your order'}</p>
<a href="{$followup|escape:'htmlall':'UTF-8'}">{$followup|escape:'htmlall':'UTF-8'}</a>
{/if}

<!--<p class="bold">{l s='Order:'} <span class="color-myaccount">{l s='#'}{$order->id|string_format:"%06d"}</span></p>-->
<!--{if $carrier->id}<p class="bold">{l s='Carrier:'} {if $carrier->name == "0"}{$shop_name|escape:'htmlall':'UTF-8'}{else}{$carrier->name|escape:'htmlall':'UTF-8'}{/if}</p>{/if}-->
<!--<p class="bold">{l s='Payment method:'} <span class="color-myaccount">{$order->payment|escape:'htmlall':'UTF-8'}</span></p>-->
{if $invoice AND $invoiceAllowed}
<p id="facturepdf">
	<img src="{$img_dir}icon/pdf.gif" alt="" class="icon" />
	<a href="{$link->getPageLink('pdf-invoice.php', true)}?id_order={$order->id|intval}{if $is_guest}&secure_key={$order->secure_key}{/if}">{l s='Download your invoice as a .PDF file'}</a>
</p>
{/if}
{if $order->recyclable && isset($isRecyclable) && $isRecyclable}
<p><img src="{$img_dir}icon/recyclable.gif" alt="" class="icon" />&nbsp;{l s='You have given permission to receive your order in recycled packaging.'}</p>
{/if}
{if $order->gift}
	<p><img src="{$img_dir}icon/gift.gif" alt="" class="icon" />&nbsp;{l s='You requested gift-wrapping for your order.'}</p>
	<p>{l s='Message:'} {$order->gift_message|nl2br}</p>
{/if}
<br />
<div id="coucou">
<ul class="address item" id="uladresse" {if $order->isVirtual()}style="display:none;"{/if}>
	<li class="address_title">{l s='Invoice'}</li>
	{foreach from=$inv_adr_fields name=inv_loop item=field_item}
		{if $field_item eq "company" && isset($address_invoice->company)}<li class="address_company">{$address_invoice->company|escape:'htmlall':'UTF-8'}</li>
		{elseif $field_item eq "address2" && $address_invoice->address2}<li class="address_address2">{$address_invoice->address2|escape:'htmlall':'UTF-8'}</li>
		{elseif $field_item eq "phone_mobile" && $address_invoice->phone_mobile}<li class="address_phone_mobile">{$address_invoice->phone_mobile|escape:'htmlall':'UTF-8'}</li>
		{else}
				{assign var=address_words value=" "|explode:$field_item} 
				<li>{foreach from=$address_words item=word_item name="word_loop"}{if !$smarty.foreach.word_loop.first} {/if}<span class="address_{$word_item}">{$invoiceAddressFormatedValues[$word_item]|escape:'htmlall':'UTF-8'}</span>{/foreach}</li>
		{/if}
	
	{/foreach}
</ul>
<ul class="address alternate_item" id="uladresse2" {if $order->isVirtual()}full_width{/if}">
	<li class="address_title">{l s='Delivery'}</li>
	{foreach from=$dlv_adr_fields name=dlv_loop item=field_item}
		{if $field_item eq "company" && isset($address_delivery->company)}<li class="address_company">{$address_delivery->company|escape:'htmlall':'UTF-8'}</li>
		{elseif $field_item eq "address2" && $address_delivery->address2}<li class="address_address2">{$address_delivery->address2|escape:'htmlall':'UTF-8'}</li>
		{elseif $field_item eq "phone_mobile" && $address_delivery->phone_mobile}<li class="address_phone_mobile">{$address_delivery->phone_mobile|escape:'htmlall':'UTF-8'}</li>
		{else}
				{assign var=address_words value=" "|explode:$field_item} 
				<li>{foreach from=$address_words item=word_item name="word_loop"}{if !$smarty.foreach.word_loop.first} {/if}<span class="address_{$word_item}">{$deliveryAddressFormatedValues[$word_item]|escape:'htmlall':'UTF-8'}</span>{/foreach}</li>
		{/if}
	{/foreach}
</ul>
</div>
{$HOOK_ORDERDETAILDISPLAYED}
{if !$is_guest}<form action="{$link->getPageLink('order-follow.php', true)}" method="post">{/if}

<div id="order-detail-content" class="table_block">
	<table class="std" id="table-recap">
		<thead >
			<tr>
				{if $return_allowed}<th class="first_item"><input type="checkbox" /></th>{/if}
				<th class="{if $return_allowed}item{else}first_item{/if}">{l s='Reference'}</th>
				<th class="item">{l s='Product'}</th>
				<th class="item">{l s='Quantity'}</th>
				<th class="item">{l s='Unit price'}</th>
				<th class="last_item">{l s='Total price'}</th>
			</tr>
		</thead>
		<tfoot>
			{if $priceDisplay && $use_tax}
				<tr id="ligne1" class="item">
					<td colspan="{if $return_allowed}6{else}5{/if}">
						{l s='Total products (tax excl.):'} <span class="price2">{displayWtPriceWithCurrency price=$order->getTotalProductsWithoutTaxes() currency=$currency}</span>
					</td>
				</tr>
			{/if}
			<tr id="ligne1" class="item">
				<td colspan="{if $return_allowed}6{else}5{/if}">
					{l s='Total products'} {if $use_tax}{l s='(tax incl.)'}{/if}: <span class="price2">{displayWtPriceWithCurrency price=$order->getTotalProductsWithTaxes() currency=$currency}</span>
				</td>
			</tr>
			{if $order->total_discounts > 0}
			<tr id="ligne1" class="item">
				<td colspan="{if $return_allowed}6{else}5{/if}">
					{l s='Total vouchers:'} <span class="price-discount">{displayWtPriceWithCurrency price=$order->total_discounts currency=$currency}</span>
				</td>
			</tr>
			{/if}
			{if $order->total_wrapping > 0}
			<tr id="ligne1" class="item">
				<td colspan="{if $return_allowed}6{else}5{/if}">
					{l s='Total gift-wrapping:'} <span class="price-wrapping">{displayWtPriceWithCurrency price=$order->total_wrapping currency=$currency}</span>
				</td>
			</tr>
			{/if}
			<tr id="ligne1" class="item">
				<td colspan="{if $return_allowed}6{else}5{/if}">
					{l s='Total shipping'} {if $use_tax}{l s='(tax incl.)'}{/if}: <span class="price-shipping">{displayWtPriceWithCurrency price=$order->total_shipping currency=$currency}</span>
				</td>
			</tr>
			<tr id="ligne1" class="item">
				<td colspan="{if $return_allowed}6{else}5{/if}">
					{l s='Total:'} <span class="price2">{displayWtPriceWithCurrency price=$order->total_paid currency=$currency}</span>
				</td>
			</tr>
		</tfoot>
		<tbody>
		{foreach from=$products item=product name=products}
			{if !isset($product.deleted)}
				{assign var='productId' value=$product.product_id}
				{assign var='productAttributeId' value=$product.product_attribute_id}
				{if isset($customizedDatas.$productId.$productAttributeId)}{assign var='productQuantity' value=$product.product_quantity-$product.customizationQuantityTotal}{else}{assign var='productQuantity' value=$product.product_quantity}{/if}
				{if isset($customizedDatas.$productId.$productAttributeId)}
					<tr class="item">
						{if $return_allowed}<td class="order_cb"></td>{/if}
						<td><label for="cb_{$product.id_order_detail|intval}">{if $product.product_reference}{$product.product_reference|escape:'htmlall':'UTF-8'}{else}--{/if}</label></td>
						<td class="bold">
							<label for="cb_{$product.id_order_detail|intval}">{$product.product_name|escape:'htmlall':'UTF-8'}</label>
						</td>
						<td><input class="order_qte_input"  name="order_qte_input[{$smarty.foreach.products.index}]" type="text" size="2" value="{$product.customizationQuantityTotal|intval}" /><label for="cb_{$product.id_order_detail|intval}"><span class="order_qte_span editable">{$product.customizationQuantityTotal|intval}</span></label></td>
						<td>
							<label for="cb_{$product.id_order_detail|intval}">
								{if $group_use_tax}
									{convertPriceWithCurrency price=$product.product_price_wt currency=$currency convert=0}
								{else}
									{convertPriceWithCurrency price=$product.product_price currency=$currency convert=0}
								{/if}
							</label>
						</td>
						<td>
							<label for="cb_{$product.id_order_detail|intval}">
								{if isset($customizedDatas.$productId.$productAttributeId)}
									{if $group_use_tax}
										{convertPriceWithCurrency price=$product.total_customization_wt currency=$currency convert=0}
									{else}
										{convertPriceWithCurrency price=$product.total_customization currency=$currency convert=0}
									{/if}
								{else}
									{if $group_use_tax}
										{convertPriceWithCurrency price=$product.total_wt currency=$currency convert=0}
									{else}
										{convertPriceWithCurrency price=$product.total_price currency=$currency convert=0}
									{/if}
								{/if}
							</label>
						</td>
					</tr>
					{foreach from=$customizedDatas.$productId.$productAttributeId item='customization' key='customizationId'}
					<tr class="alternate_item">
						{if $return_allowed}<td class="order_cb"><input type="checkbox" id="cb_{$product.id_order_detail|intval}" name="customization_ids[{$product.id_order_detail|intval}][]" value="{$customizationId|intval}" /></td>{/if}
						<td colspan="2">
						{foreach from=$customization.datas key='type' item='datas'}
							{if $type == $CUSTOMIZE_FILE}
							<ul class="customizationUploaded">
								{foreach from=$datas item='data'}
									<li><img src="{$pic_dir}{$data.value}_small" alt="" class="customizationUploaded" /></li>
								{/foreach}
							</ul>
							{elseif $type == $CUSTOMIZE_TEXTFIELD}
							<ul class="typedText">{counter start=0 print=false}
								{foreach from=$datas item='data'}
									{assign var='customizationFieldName' value="Text #"|cat:$data.id_customization_field}
									<li>{$data.name|default:$customizationFieldName}{l s=':'} {$data.value}</li>
								{/foreach}
							</ul>
							{/if}
						{/foreach}
						</td>
						<td>
							<input class="order_qte_input" name="customization_qty_input[{$customizationId|intval}]" type="text" size="2" value="{$customization.quantity|intval}" /><label for="cb_{$product.id_order_detail|intval}"><span class="order_qte_span editable">{$customization.quantity|intval}</span></label>
						</td>
						<td colspan="2"></td>
					</tr>
					{/foreach}
				{/if}
				{if $product.product_quantity > $product.customizationQuantityTotal}
					<tr class="item">
						{if $return_allowed}<td class="order_cb"><input type="checkbox" id="cb_{$product.id_order_detail|intval}" name="ids_order_detail[{$product.id_order_detail|intval}]" value="{$product.id_order_detail|intval}" /></td>{/if}
						<td><label for="cb_{$product.id_order_detail|intval}">{if $product.product_reference}{$product.product_reference|escape:'htmlall':'UTF-8'}{else}--{/if}</label></td>
						<td class="bold">
							<label for="cb_{$product.id_order_detail|intval}">
								{if $product.download_hash && $invoice && $product.product_quantity_refunded == 0 && $product.product_quantity_return == 0}
									<a href="{$link->getPageLink('get-file.php', true)}?key={$product.filename|escape:'htmlall':'UTF-8'}-{$product.download_hash|escape:'htmlall':'UTF-8'}{if isset($is_guest) && $is_guest}&id_order={$order->id}&secure_key={$order->secure_key}{/if}" title="{l s='download this product'}">
										<img src="{$img_dir}icon/download_product.gif" class="icon" alt="{l s='Download product'}" />
									</a>
									<a href="{$link->getPageLink('get-file.php', true)}?key={$product.filename|escape:'htmlall':'UTF-8'}-{$product.download_hash|escape:'htmlall':'UTF-8'}{if isset($is_guest) && $is_guest}&id_order={$order->id}&secure_key={$order->secure_key}{/if}" title="{l s='download this product'}">
										{$product.product_name|escape:'htmlall':'UTF-8'}
									</a>
								{else}
									{$product.product_name|escape:'htmlall':'UTF-8'}
								{/if}
							</label>
						</td>
						<td><input class="order_qte_input" name="order_qte_input[{$product.id_order_detail|intval}]" type="text" size="2" value="{$productQuantity|intval}" /><label for="cb_{$product.id_order_detail|intval}"><span class="order_qte_span editable">{$productQuantity|intval}</span></label></td>
						<td>
							<label for="cb_{$product.id_order_detail|intval}">
							{if $group_use_tax}
								{convertPriceWithCurrency price=$product.product_price_wt currency=$currency convert=0}
							{else}
								{convertPriceWithCurrency price=$product.product_price currency=$currency convert=0}
							{/if}
							</label>
						</td>
						<td>
							<label for="cb_{$product.id_order_detail|intval}">
							{if $group_use_tax}
								{convertPriceWithCurrency price=$product.total_wt currency=$currency convert=0}
							{else}
								{convertPriceWithCurrency price=$product.total_price currency=$currency convert=0}
							{/if}
							</label>
						</td>
					</tr>
				{/if}
			{/if}
		{/foreach}
		{foreach from=$discounts item=discount}
			<tr class="item">
				<td>{$discount.name|escape:'htmlall':'UTF-8'}</td>
				<td>{l s='Voucher:'} {$discount.name|escape:'htmlall':'UTF-8'}</td>
				<td><span class="order_qte_span editable">1</span></td>
				<td>&nbsp;</td>
				<td>{if $discount.value != 0.00}{l s='-'}{/if}{convertPriceWithCurrency price=$discount.value currency=$currency convert=0}</td>
				{if $return_allowed}
				<td>&nbsp;</td>
				{/if}
			</tr>
		{/foreach}
		</tbody>
	</table>
</div>
<!--
<br />
{if !$is_guest}
	{if $return_allowed}
	<p class="bold">{l s='Merchandise return'}</p>
	<p>{l s='If you wish to return one or more products, please mark the corresponding boxes and provide an explanation for the return. Then click the button below.'}</p>
	<p class="textarea">
		<textarea cols="67" rows="3" name="returnText"></textarea>
	</p>
	<p class="submit">
		<input type="submit" value="{l s='Make a RMA slip'}" name="submitReturnMerchandise" class="button_large" />
		<input type="hidden" class="hidden" value="{$order->id|intval}" name="id_order" />
	</p>
	<br />
	{/if}
	</form>

	{if count($messages)}
	<p class="bold">{l s='Messages'}</p>
	<div class="table_block">
		<table class="detail_step_by_step std">
			<thead>
				<tr>
					<th class="first_item" style="width:150px;">{l s='From'}</th>
					<th class="last_item">{l s='Message'}</th>
				</tr>
			</thead>
			<tbody>
			{foreach from=$messages item=message name="messageList"}
				<tr class="{if $smarty.foreach.messageList.first}first_item{elseif $smarty.foreach.messageList.last}last_item{/if} {if $smarty.foreach.messageList.index % 2}alternate_item{else}item{/if}">
					<td>
						{if isset($message.ename) && $message.ename}
							{$message.efirstname|escape:'htmlall':'UTF-8'} {$message.elastname|escape:'htmlall':'UTF-8'}
						{elseif $message.clastname}
							{$message.cfirstname|escape:'htmlall':'UTF-8'} {$message.clastname|escape:'htmlall':'UTF-8'}
						{else}
							<b>{$shop_name|escape:'htmlall':'UTF-8'}</b>
						{/if}
						<br />
						{dateFormat date=$message.date_add full=1}
					</td>
					<td>{$message.message|nl2br}</td>
				</tr>
			{/foreach}
			</tbody>
		</table>
	</div>
	{/if}
	{if isset($errors) && $errors}
		<div class="error">
			<p>{if $errors|@count > 1}{l s='There are'}{else}{l s='There is'}{/if} {$errors|@count} {if $errors|@count > 1}{l s='errors'}{else}{l s='error'}{/if} :</p>
			<ol>
			{foreach from=$errors key=k item=error}
				<li>{$error}</li>
			{/foreach}
			</ol>
		</div>
	{/if}-->
	<!--<form action="{$link->getPageLink('order-detail.php', true)}" method="post" class="std formquitue" id="sendOrderMessage">
		<p class="bold">{l s='Add a message:'}</p>
		<p>{l s='If you would like to add a comment about your order, please write it below.'}</p>
		<p class="textarea">
			<textarea cols="67" rows="3" name="msgText"></textarea>
		</p>
		<p class="submit">
			<input type="hidden" name="id_order" value="{$order->id|intval}" />
			<input type="submit" class="button" name="submitMessage" value="{l s='Send'}"/>
		</p>
	</form>-->
{else}
<p><img src="{$img_dir}icon/infos.gif" alt="" class="icon" />&nbsp;{l s='You cannot make a merchandise return with a guest account'}</p>
{/if}
{if !isset($smarty.get.ajax)}
	</div>
</div>
{/if}