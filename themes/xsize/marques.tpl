{include file="$tpl_dir./breadcrumb.tpl"}
<h1>NOS MARQUES</h1>
<section id="abcedaire">
	<a href="#A">A</a>
	<a href="#B">B</a>
	<a href="#C">C</a>
	<a href="#D">D</a>
	<a href="#E">E</a>
	<a href="#F">F</a>
	<a href="#G">G</a>
	<a href="#H">H</a>
	<a href="#I">I</a>
	<a href="#J">J</a>
	<a href="#K">K</a>
	<a href="#L">L</a>
	<a href="#M">M</a>
	<a href="#N">N</a>
	<a href="#O">O</a>
	<a href="#P">P</a>
	<a href="#Q">Q</a>
	<a href="#R">R</a>
	<a href="#S">S</a>
	<a href="#T">T</a>
	<a href="#U">U</a>
	<a href="#V">V</a>
	<a href="#W">W</a>
	<a href="#X">X</a>
	<a href="#Y">Y</a>
	<a href="#Z">Z</a>
</section>
<section class="page">
{if $manufacturers}
	{foreach from=$manufacturers item=manufacturer name=foo}
			{if $smarty.foreach.foo.first}
				<section id="{$manufacturer.name|escape:'htmlall':'UTF-8'|substr:0:1}">
						<h2>{$manufacturer.name|escape:'htmlall':'UTF-8'|substr:0:1}</h2>
						<table>
							<tr>
				{else}
				{if $manufacturer.name|escape:'htmlall':'UTF-8'|substr:0:1 != $manufacturers[$smarty.foreach.foo.index-1].name|substr:0:1}
				</tr>
						</table>
					</section>
					<div id="sep"></div>
					<section id="{$manufacturer.name|escape:'htmlall':'UTF-8'|substr:0:1}">
						<h2>{$manufacturer.name|escape:'htmlall':'UTF-8'|substr:0:1}</h2>
						<table>
							<tr>
				{/if}
			{/if}
		<td><a href="{$link->getManufacturerLink($manufacturer.id_manufacturer,$manufacturer.link_rewrite)}">{$manufacturer.name|escape:'htmlall':'UTF-8'}</a></td>
	{/foreach}
	</tr>
	</table>
	</section>
	<a id="goTop" href="#"></a>
{else}
	<p>{l s='No manufacturer' mod='blockmanufacturer'}</p>
{/if}
</section>
<!--[if lt IE 8]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE8.js"></script>
<![endif]-->