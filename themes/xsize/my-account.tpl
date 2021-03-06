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

{capture name=path}{l s='My account'}{/capture}
{include file="$tpl_dir./breadcrumb.tpl"}

<h1 class="account-title1">{l s='My account'}</h1>
<!--<h4>{l s='Welcome to your account. Here you can manage your addresses and orders.'}</h4>-->
<div id="account-div">
	<ul id="account-homeul">
		<li><a class="aimg" href="{$link->getPageLink('history.php', true)}" title="{l s='Orders'}"><img src="{$img_dir}assets/account-calendar.png" alt="{l s='Orders'}"/></a><a class="account-a" href="{$link->getPageLink('history.php', true)}" title="{l s='Orders'}">{l s='History and details of my orders'}</a></li>
		<hr/>
		<li><a class="aimg" href="{$link->getPageLink('addresses.php', true)}" title="{l s='Addresses'}"><img src="{$img_dir}assets/account-map.png" alt="{l s='Addresses'}"/></a><a class="account-a" href="{$link->getPageLink('addresses.php', true)}" title="{l s='Addresses'}">{l s='My addresses'}</a></li>
		<hr/>
		<li><a class="aimg" href="{$link->getPageLink('identity.php', true)}" title="{l s='Information'}"><img src="{$img_dir}assets/account-infos.png" alt="{l s='Information'}"/></a><a class="account-a" href="{$link->getPageLink('identity.php', true)}" title="{l s='Information'}">{l s='My personal information'}</a></li>
		<hr/>
		{if $returnAllowed}
			<li><a class="aimg" href="{$link->getPageLink('order-follow.php', true)}" title="{l s='Merchandise returns'}"><img src="{$img_dir}icon/return.gif" alt="{l s='Merchandise returns'}"/></a><a class="account-a" href="{$link->getPageLink('order-follow.php', true)}" title="{l s='Merchandise returns'}">{l s='My merchandise returns'}</a></li>
		{/if}
		<li><a class="aimg" title="Bon de retour"><img src="{$img_dir}assets/account-bdr.png" alt="Bon de retour"/></a><a class="account-a" target="_blank" href="{$img_dir}bon_retour.pdf" title="Bon de retour">Bon de retour</a></li>
		<hr/>
	<!--
		<li><a href="{$link->getPageLink('order-slip.php', true)}" title="{l s='Credit slips'}"><img src="{$img_dir}assets/account-bdr.png" alt="{l s='Credit slips'}"/></a><a class="account-a" href="{$link->getPageLink('order-slip.php', true)}" title="{l s='Credit slips'}">{l s='My credit slips'}</a></li>
		{if $voucherAllowed}
			<li><a href="{$link->getPageLink('discount.php', true)}" title="{l s='Vouchers'}"><img src="{$img_dir}icon/voucher.gif" alt="{l s='Vouchers'}"/></a><a href="{$link->getPageLink('discount.php', true)}" title="{l s='Vouchers'}">{l s='My vouchers'}</a></li>
		{/if}
	-->
		{$HOOK_CUSTOMER_ACCOUNT}
	</ul>
	<p id="account-homep"><a href="{$base_dir}" title="{l s='Home'}"><img src="{$img_dir}assets/account-home.png" alt="{l s='Home'}"/></a><a class="account-a" id="account-blue" href="{$base_dir}" title="{l s='Home'}">{l s='Home'}</a></p>
</div>
