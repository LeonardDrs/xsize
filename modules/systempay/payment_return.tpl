{if $status == 'ok'}
	<p>{l s='Your order on' mod='systempay'} <span class="bold">{$shop_name}</span> {l s='is complete.' mod='systempay'}
		<br /><br />
		{l s='We registered your payment of ' mod='systempay'} <span class="price">{$total_to_pay}</span>
		<br /><br />{l s='For any questions or for further information, please contact our' mod='systempay'} <a href="{$base_dir_ssl}contact-form.php">{l s='customer support' mod='systempay'}</a>.
	</p>
{else}
	{if $error_msg != ''}
		<p class="warning">
			{$error_msg}
			{if $contact_support == true}
				{l s='Please contact our' mod='systempay'}&nbsp;<a href="{$base_dir_ssl}contact-form.php">{l s='customer support' mod='systempay'}</a>.
			{/if}
		</p>
		
		<br/><br/>
	{/if}
	
	{if $check_url_warn == true}
		<p class="warning">
			{l s='Order registered, but automatic confirmation has not been received. Have you properly configured the check url in the bank backoffice ?' mod='systempay'}
			<br />
			{l s='If you think this is an error, you can contact our' mod='systempay'}
			<a href="{$base_dir_ssl}contact-form.php">{l s='customer support' mod='systempay'}</a>.
		</p>
	{/if}
{/if}