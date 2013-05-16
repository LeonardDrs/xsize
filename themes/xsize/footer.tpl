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


		{if !$content_only}

			{if $page_name=='index'}
			<!-- Right -->
				<div id="right_column" class="column">
					{$HOOK_RIGHT_COLUMN}
				</div>
			{/if}
			</div>

		<!--------------------------------------FOOTER--------------------------------------------------- -->
	     <div id="footer">
				<div id="topFooter">
					<div id="contTopFooter">
					<ul id="menuFooter">
						<li class="elemFoot">
							<img class="inconFooter1" src="{$img_dir}/home/Iintero.png"/>
							<p class="texteFooter">Besoin d'aide ? Appelez nous au 02 45 48 38 95</p>
						</li>
						<li class="elemFoot">
							<a href="https://www.facebook.com/pages/X-size-boutique-de-v%C3%AAtements-grandes-tailles-pour-hommes-et-femmes/140079426065873" target="_blank"><img class="inconFooter1" src="{$img_dir}/home/Ifb.png"/>
							<p class="texteFooter">Rejoignez nous sur Facebook</p></a>
						</li>
						<li class="elemFoot">
						</li>
						<li class="elemFoot">
							{$HOOK_FOOTER2}
						</li>
						<li class="elemFoot">
							<img class="inconFooter2" src="{$img_dir}/home/cb.jpg"/>
							<img class="inconFooter2" src="{$img_dir}/home/visa.jpg"/>
							<img class="inconFooter2" src="{$img_dir}/home/mastercard.jpg"/>
							<img class="inconFooter2" src="{$img_dir}/home/cheque.jpg"/>
						</li>
					</ul>
					</div>
				</div>
				<div id="bottomFooter">
					{$HOOK_FOOTER}
				</div>
			</div>
			{/if}
	</body>
</html>

