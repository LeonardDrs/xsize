<?php
class FrontController extends FrontControllerCore
{
	public function displayHeader()
	{
		global $css_files, $js_files;

		if (!self::$initialized)
			$this->init();

		// P3P Policies (http://www.w3.org/TR/2002/REC-P3P-20020416/#compact_policies)
		header('P3P: CP="IDC DSP COR CURa ADMa OUR IND PHY ONL COM STA"');

		/* Hooks are volontary out the initialize array (need those variables already assigned) */
		self::$smarty->assign(array(
			'time' => time(),
			'img_update_time' => Configuration::get('PS_IMG_UPDATE_TIME'),
			'static_token' => Tools::getToken(false),
			'token' => Tools::getToken(),
			'logo_image_width' => Configuration::get('SHOP_LOGO_WIDTH'),
			'logo_image_height' => Configuration::get('SHOP_LOGO_HEIGHT'),
			'priceDisplayPrecision' => _PS_PRICE_DISPLAY_PRECISION_,
			'content_only' => (int)Tools::getValue('content_only')
		));
		self::$smarty->assign(array(
			'HOOK_HEADER' => Module::hookExec('header'),
			'HOOK_TOP' => Module::hookExec('top'),
			'HOOK_CLIENT' => Module::hookExec('client'),
			'HOOK_PANIER' => Module::hookExec('panier'),
			'HOOK_LEFT_COLUMN' => Module::hookExec('leftColumn'),
			'HOOK_TOP_LIST_PRODUCTS_CATEGORY' => Module::hookExec('topListProductsCategory'),
			'HOOK_FOOTER2' => Module::hookExec('footer2'),
			'HOOK_FOOTER3' => Module::hookExec('footer3'),
			'SLIDERMAGASIN' => Module::hookExec('sliderMagasin'),
			'SLIDERCOSTUME' => Module::hookExec('sliderCostume')
		));

		if ((Configuration::get('PS_CSS_THEME_CACHE') OR Configuration::get('PS_JS_THEME_CACHE')) AND is_writable(_PS_THEME_DIR_.'cache'))
		{
			// CSS compressor management
			if (Configuration::get('PS_CSS_THEME_CACHE'))
				Tools::cccCss();

			//JS compressor management
			if (Configuration::get('PS_JS_THEME_CACHE'))
				Tools::cccJs();
		}
	//	$id_category=6;
		$catMenu = new Category(6, self::$cookie->id_lang);
		$subCategories = $catMenu->getSubCategories((int)self::$cookie->id_lang);
		self::$smarty->assign('categories', $subCategories);
		self::$smarty->assign('css_files', $css_files);
		self::$smarty->assign('js_files', array_unique($js_files));
		self::$smarty->display(_PS_THEME_DIR_.'header.tpl');
	}
}
?>