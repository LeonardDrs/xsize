{if isset($systempay_opc_enabled) && $systempay_opc_enabled}
	{assign var='order_page' value='order-opc.php'}
{else}
	{assign var='order_page' value='order.php'}
{/if}

{capture name=path}<a href="{$base_dir}{$order_page}">{l s='Your shopping cart' mod='systempay'}</a><span class="navigation-pipe">{$navigationPipe}</span>Systempay{/capture}
{include file="$tpl_dir./breadcrumb.tpl"}

<h2>{l s='Redirection to payment gateway' mod='systempay'}</h2>

{assign var='current_step' value='payment'}
{include file="$tpl_dir./order-steps.tpl"}

{if isset($systempay_empty_cart) && $systempay_empty_cart}
	<p class="warning">{l s='Your shopping cart is empty.' mod='systempay'}</p>
{else}

	<h3>{l s='Payment by bank card' mod='systempay'}</h3>
	
	<form action="{$systempay_url}" method="post" id="systempay_form"> 
		{foreach from=$systempay_params key='key' item='value'}
			<input type="hidden" name="{$key}" value="{$value}" />
		{/foreach}
	
		<p>
			<img src="{$base_dir}modules/systempay/BannerLogo.gif" alt="Systempay" style="margin-bottom: 5px" />
			<br />
			{l s='Please wait, you will be redirected to the payment platform.' mod='systempay'}
			<br /> <br />
			{l s='If you are not redirected in 10 seconds, please click the button below.' mod='systempay'} 
			<br /><br />
		</p>
	
		<p class="cart_navigation">
			<input type="submit" name="submitPayment" value="{l s='Pay' mod='systempay'}" class="exclusive" />
		</p>
	</form>
	
	<script type="text/javascript">
		{literal}
			$(document).ready(function() {
				$('#systempay_form').submit();
			});
		{/literal}
	</script>
{/if}	
