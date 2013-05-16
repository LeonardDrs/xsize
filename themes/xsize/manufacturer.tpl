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
{capture name=path}<a href="{$base_dir}marques.php">Marques</a><span class="navigation-pipe"> &gt; </span>{$manufacturer->name|escape:'htmlall':'UTF-8'}{/capture}
{include file="$tpl_dir./breadcrumb.tpl"}

{include file="$tpl_dir./errors.tpl"}
<div class="h1demarques"><h1 class="nosmarques">{$manufacturer->name|escape:'htmlall':'UTF-8'}</h1></div>
<div id="marque">
	<div class="rte">
		<div class="divmarque">
			<div class="marquecontainer">
				<div class="desc">
					<img src="{$img_manu_dir}{$manufacturer->id}-medium.jpg" />
					{$manufacturer->description}
				</div><!-- end of .desc -->
			</div>
		</div>
	</div><!-- end of .rte -->
</div><!-- end of #marque -->