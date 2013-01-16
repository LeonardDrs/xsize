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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{$lang_iso}">
	<head>
		<title>{$meta_title|escape:'htmlall':'UTF-8'}</title>
{if isset($meta_description) AND $meta_description}
		<meta name="description" content="{$meta_description|escape:html:'UTF-8'}" />
{/if}
{if isset($meta_keywords) AND $meta_keywords}
		<meta name="keywords" content="{$meta_keywords|escape:html:'UTF-8'}" />
{/if}
		<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
		<meta name="generator" content="PrestaShop" />
		<meta name="robots" content="{if isset($nobots)}no{/if}index,follow" />
		<link rel="icon" type="image/vnd.microsoft.icon" href="{$img_ps_dir}favicon.ico?{$img_update_time}" />
		<link rel="shortcut icon" type="image/x-icon" href="{$img_ps_dir}favicon.ico?{$img_update_time}" />
		<script type="text/javascript">
			var baseDir = '{$content_dir}';
			var static_token = '{$static_token}';
			var token = '{$token}';
			var priceDisplayPrecision = {$priceDisplayPrecision*$currency->decimals};
			var priceDisplayMethod = {$priceDisplay};
			var roundMode = {$roundMode};
		</script>

{if isset($css_files)}
	{foreach from=$css_files key=css_uri item=media}
	<link href="{$css_uri}" rel="stylesheet" type="text/css" media="{$media}" />
	{/foreach}
{/if}
{if $page_name=='magasin'}
	<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
{/if}
{if isset($js_files)}
	{foreach from=$js_files item=js_uri}
	<script type="text/javascript" src="{$js_uri}"></script>
	{/foreach}
{/if}
<!--[if lt IE 9]>
<script src="{$js_dir}html5shiv.js"></script>
<![endif]-->
{$HOOK_HEADER}
	</head>
	<body {if $page_name}id="{$page_name|escape:'htmlall':'UTF-8'}"{/if}>
	{if !$content_only}
	<div id="header">
		<div id="topHeader">
			<a href="cms.php?id_cms=3#echange"><div id="topStatisfait">
				<p>{l s="Satisfait ou rembourse"}<br> {l s="Retour sous 15 jours"}</p>
			</div></a>
			<a href="cms.php?id_cms=3#livr"><div id="topLivraison">
				<p>Livraison gratuite <br> à partir de 50€</p>
			</div></a>
			{$HOOK_CLIENT}
		</div>
		<div id="bottomHeader">
			<div id="contentbottomHeader">
				<a id="logoLink" href="{$link->getPageLink('index.php')}" title="{$shop_name|escape:'htmlall':'UTF-8'}">
					<img src="{$img_ps_dir}logo.png?{$img_update_time}" alt="{$shop_name|escape:'htmlall':'UTF-8'}" {if $logo_image_width}width="{$logo_image_width}"{/if} {if $logo_image_height}height="{$logo_image_height}" {/if} />
				</a>
				<ul id="menu">
					<img class="sep" alt="separateur" src="{$img_dir}/home/sep.png">
					<li class="elemMenu">
						<div class="elemTopMenu menuDeroulant">PRODUITS</div>

						<!---------------------------------SOUSMENU------------------------------- -->

							<div id="contSousMenu">
								<ul id="sousMenu">
									<li class="sousMenuItem">
										<div class="linkSousMenu2">
											<div>Catalogue</div>
										</div>

										<ul class="sousMenuSousItem">
										<img id="fleche" alt="fleche" src="{$img_dir}/home/flecheSousMenu.jpg">
											{foreach from=$categories item=cat}
											<li>
												<div class="linkSousMenu">
													<a title="{$cat.link_rewrite}" href="{$link->getCategoryLink({$cat.id_category}, {$cat.link_rewrite})}">{$cat.name}</a>
												</div>
											</li>
											{/foreach}
										</ul>
									</li>
									<li class="sousMenuItem">
									<div class="linkSousMenu2">
										<a title="Nos costumes" href="{$base_dir}costumes.php">Costumes</a>
									</div>
									</li>
								</ul>
								<img id="sepSousMenu" alt="sepSousMenu" src="{$img_dir}/home/botSousMenu.jpg">
							</div>

						<!---------------------------------SOUSMENU---FIN------------------------------- -->

					</li>
					<img class="sep" alt="separateur" src="{$img_dir}/home/sep.png">
					<li class="elemMenu">
						{$categories.print_r}
						<a class="elemTopMenu" title="Tous les bon plans du moment !" href="{$link->getCategoryLink(3, bonne-affaire)}">BONNES AFFAIRES</a>
					</li>
					<img class="sep" alt="separateur" src="{$img_dir}/home/sep.png">
					<li class="elemMenu">
						<a class="elemTopMenu" title="Les différentes marques en vente chez X-Size" href="{$base_dir}marques.php">MARQUES</a>
					</li>
					<img class="sep" alt="separateur" src="{$img_dir}/home/sep.png">
					<li class="elemMenu">
						<a class="elemTopMenu" title="Toutes les informations sur notre magasin !" href="{$base_dir}magasin.php">MAGASIN</a>
					</li>
					<img class="sep" alt="separateur" src="{$img_dir}/home/sep.png">
				</ul>
				<script type="text/javascript">
					{literal}
						$('#contSousMenu').hover(function() {
							$(this).siblings('.elemTopMenu').css({"background-color": "#FAF8F3","color":"#111"})
						},function() {
							$(this).siblings('.elemTopMenu').css({"background-color": "","color":""})
						})
					{/literal}
				</script>
				{$HOOK_PANIER}
			</div>
		</div>
	 </div>
	 <div id="content" class="clearfix">
	{/if}