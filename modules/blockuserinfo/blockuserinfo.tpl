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

<!-- Block user information module HEADER -->
<div id="topCompte">
	<ul id="menuTopCompte">
		{if $cookie->isLogged()}
			<li class="elemTopCompte">
				Bienvenue, {$cookie->customer_firstname} {$cookie->customer_lastname}
			</li>
			|
			<li class="elemTopCompte">
				<a href="{$link->getPageLink('my-account.php', true)}" title="{l s='Mon compte' mod='blockuserinfo'}">{l s='Mon compte' mod='blockuserinfo'}</a>
			</li>
			|
			<li class="elemTopCompte">
				<a href="{$link->getPageLink('index.php')}?mylogout" title="{l s='Log me out' mod='blockuserinfo'}">{l s='Log out' mod='blockuserinfo'}</a>
			</li>
		{else}
				<a id="nolog" href="{$link->getPageLink('connexion_inscription.php', true)}">{l s='Connexion | Identification' mod='blockuserinfo'}</a>
		{/if}
	</ul>
</div>
<!-- /Block user information module HEADER -->
