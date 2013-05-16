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
<!--<div class="topRightColumn">{l s='Inscrivez-vous a la newsletter' mod='blocknewsletter'}</div>
<img class="inconFooter1" src="{$img_dir}/home/Inews.png"/>
<form method="post">
	<input class="texteFooter" type="texte" value="{if isset($value) && $value}{$value}{else}{l s='Entrez votre email' mod='blocknewsletter'}{/if}" onfocus="javascript:if(this.value=='{l s='Entrez votre email' mod='blocknewsletter'}')this.value='';" onblur="javascript:if(this.value=='')this.value='{l s='Entrez votre email' mod='blocknewsletter'}';" size="18">
	<input class="texteFooter footOk" type="image" type="submit" alt="S'inscrire" src="{$img_dir}/home/inscrire.png" name="submitNewsletter">
	<input class="texteFooter rightOk" type="image" type="submit" alt="S'inscrire" src="{$img_dir}/home/OK.jpg" name="submitNewsletter">
</form>-->
<!-- Block Newsletter module -->

<div id="newsletter_block_left" class="block">
	<div class="topRightColumn">{l s='Inscrivez-vous a la newsletter' mod='blocknewsletter'}</div>
	<img class="inconFooter1" src="{$img_dir}/home/Inews.png"/>
	{if isset($msg) && $msg}
		<div id="popup-news" class="{if $nw_error}warning_inline{else}success_inline{/if}">{$msg}</div>
	{/if}
	<form method="post">
		<input class="mailnews" type="text" name="email" size="18" value="{if isset($value) && $value}{$value}{else}{l s='Entrez votre email' mod='blocknewsletter'}{/if}" onfocus="javascript:if(this.value=='{l s='Entrez votre email' mod='blocknewsletter'}')this.value='';" onblur="javascript:if(this.value=='')this.value='{l s='Entrez votre email' mod='blocknewsletter'}';" />
		<select name="action" style="display:none">
			<option value="0"{if isset($action) && $action == 0} selected="selected"{/if}>{l s='Subscribe' mod='blocknewsletter'}</option>
		</select>
		<input class="texteFooter rightOk" type="image" type="submit" alt="S'inscrire" src="{$img_dir}/home/OK.jpg" name="submitNewsletter">
		<input class="texteFooter footOk" type="image" type="submit" alt="S'inscrire" src="{$img_dir}/home/inscrire.png" name="submitNewsletter">
	</form>
</div>

<!-- /Block Newsletter module-->
