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

<section id="content">
{capture name=path}{$category->name|escape:'htmlall':'UTF-8'}{/capture}
{include file="$tpl_dir./breadcrumb.tpl"}
{include file="$tpl_dir./errors.tpl"}
{if isset($category)}
	{if $category->id AND $category->active}
		<div class="h1spacer">
		<h1>
			{strip}
				{$category->name|escape:'htmlall':'UTF-8'}
				{if isset($categoryNameComplement)}
					{$categoryNameComplement|escape:'htmlall':'UTF-8'}
				{/if}
			{/strip}
		</h1>
		</div>

		{if $products}
				{include file="$tpl_dir./product-sort.tpl"}
				{include file="$tpl_dir./product-list.tpl" products=$products}
				{*include file="$tpl_dir./pagination.tpl"*}
			{elseif !isset($subcategories)}
				<p class="warning">{l s='There are no products in this category.'}</p>
			{/if}


		{if $category->id == 3}
			<script type="text/javascript">
				{literal}
				// category.tpl
					var hidizz = function() {
							$('.block_content #ul_layered_id_attribute_group_27,.block_content #ul_layered_id_attribute_group_7,.block_content #ul_layered_id_attribute_group_11,.block_content #ul_layered_id_attribute_group_13').each(function() {
								$(this).parents('#layered_form div .clearfix').hide();
							})
					}
					var reformat = function() {
						var initTop = 117;
						var $div = $('<div id="bfbloc"><div id="layered_form" class="wrapper"></div></div>');
						// $div.append($('#ul_layered_id_attribute_group_7,#ul_layered_id_attribute_group_11,#ul_layered_id_attribute_group_13'));
						$('#ul_layered_id_attribute_group_7,#ul_layered_id_attribute_group_11,#ul_layered_id_attribute_group_13,#ul_layered_id_attribute_group_27').each(function() {
							// $div.find('.wrapper').clone(true).append($(this).parents('#layered_form div .clearfix'));
							$(this).parents('#layered_form div .clearfix').clone().appendTo($div.find('.wrapper'))
							$(this).parents('#layered_form div .clearfix').hide();
						})
						$div.find('div.clear').remove();
						$('#product_list').before($div);
						
						$('body').on('click','#bfbloc .layered_close',function(event) {
							event.preventDefault();
							$(this).siblings('ul').toggle().end().find('a').toggleClass('fleche_droite');
						})
						$('body').on('click','#bfbloc input',function(event) {
							$('#layered_block_left').find('#'+$(this).attr('id')).trigger('click');
						})
					}
					reformat();
				{/literal}
			</script>
		{/if}



	{elseif $category->id}
		<p class="warning">{l s='This category is currently unavailable.'}</p>
	{/if}
{/if}
</section>