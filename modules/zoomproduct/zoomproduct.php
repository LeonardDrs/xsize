<?php

if (!defined('_PS_VERSION_'))
	exit;

class ZoomProduct extends Module {
	public function __construct(){
		$this->name = 'zoomproduct';
		$this->tab = 'xsize';
		$this->version = '1.0';
		$this->author = 'xSize';
		$this->need_instance = 0;

		parent::__construct();

		$this->displayName = $this->l('Zoom Produit');
		$this->description = $this->l('Effectue un zoom sur les produits de la page d\'un catalogue');
	}

	public function install(){
		if(!$this->registerHook('topListProductsCategory')){
			Db::getInstance()->autoExecuteWithNullValues(_DB_PREFIX_.'hook', array(
				'name' =>    'topListProductsCategory',
				'title' =>    'topListProductsCategory',
				'position' =>    '1',
				'live_edit' =>    '0'
			), 'INSERT');
		}
		if (parent::install() == false || !$this->registerHook('topListProductsCategory'))
			return false;
		return true;
	}
	function hookTopListProductsCategory($params){
		global $smarty;
		return $this->display(__FILE__, 'zoomproduct.tpl');
	}
	public function uninstall(){
		if (!parent::uninstall())
			Db::getInstance()->Execute('DELETE FROM `'._DB_PREFIX_.'zoomproduct`');
			Db::getInstance()->Execute('DELETE FROM `'._DB_PREFIX_.'hook` WHERE `name` = "topListProductsCategory" ');
		parent::uninstall();
	}

}
?>