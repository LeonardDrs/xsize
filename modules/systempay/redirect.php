<?php
#####################################################################################################
#
#					Module pour la plateforme de paiement Systempay
#						Version : 1.4d (révision 36570)
#									########################
#					Développé pour Prestashop
#						Version : 1.4.0.x
#						Compatibilité plateforme : V2
#									########################
#					Développé par Lyra Network
#						http://www.lyra-network.com/
#						18/06/2012
#						Contact : supportvad@lyra-network.com
#
#####################################################################################################

include(dirname(__FILE__).'/../../config/config.inc.php');
include(dirname(__FILE__).'/../../init.php');
include(dirname(__FILE__).'/systempay.php');

/* @var $smarty Smarty */ 
global $smarty;

$systempay = new Systempay();

// assigning form params and url
$systempay->prepareForm(); 

if(Configuration::get('PS_ORDER_PROCESS_TYPE')) {
	$smarty->assign('systempay_opc_enabled', true);
} 

// Disable some cache 
header("Last-Modified: " . gmdate("D, d M Y H:i:s", time()-10) . " GMT");
header("Expires: Thu, 19 Nov 1981 08:52:00 GMT" ); // Date in the past
header("Cache-Control: no-store, no-cache, must-revalidate, post-check=0, pre-check=0, max-age=0");
header("Pragma: no-cache");

// Display all and exit
include(_PS_ROOT_DIR_.'/header.php');

// dispaly form in redirect page
echo $systempay->display('systempay.php', 'redirect.tpl');

include(_PS_ROOT_DIR_.'/footer.php');

die ();
?>