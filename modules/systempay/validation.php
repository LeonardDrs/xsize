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

require dirname(dirname(dirname(__FILE__))) . '/config/config.inc.php';
include dirname(dirname(dirname(__FILE__))) . '/header.php';

// Damn global variables
global $cookie;

// restore language from order info
if(key_exists('vads_order_info', $_REQUEST) && !empty($_REQUEST['vads_order_info'])) {
	$parts = explode('=', $_REQUEST['vads_order_info'], 2);
	$cookie->id_lang = $parts[1];
}

/**
 * @var Systempay $systempay
 * @var SystempayApi $api
 * @var SystempayResponse $systempay_resp
 */

/*
 * The payment platform can use only one check url,
 * but prestashop may have both standard payment module or the multi-payment module.
 * They need to have their validation code in the same place (i.e. here),
 * so we detect the case and load the appropriate module.
 */
if ((!array_key_exists('vads_payment_config', $_REQUEST) || stripos($_REQUEST['vads_payment_config'], 'MULTI') === false)
	&& (!array_key_exists('vads_contrib', $_REQUEST) || stripos($_REQUEST['vads_contrib'], 'multi') === false)) {
	// Single payment case
	require dirname(__FILE__) . '/systempay.php';
	$systempay = new Systempay();
} else {
	require dirname(dirname(__FILE__)) . '/systempaymulti/systempaymulti.php';
	$systempay = new SystempayMulti();
}

$systempay_resp = new SystempayResponse($_REQUEST, Configuration::get('SYSTEMPAY_MODE'), Configuration::get('SYSTEMPAY_KEY_TEST'), Configuration::get('SYSTEMPAY_KEY_PROD'));
$from_server = $systempay_resp->get('hash') != null;

// Check the authenticity of the request
if (!$systempay_resp->isAuthentified()) {
	if ($from_server) {
		die($systempay_resp->getOutputForGateway('auth_fail'));
	}
	// Goto index
	Tools::redirectLink(__PS_BASE_URI__);
}

/*
 * response is authentified
 */

// Retrieve cart
$id_cart = $systempay_resp->get('order_id');
$cart = new Cart($id_cart);
if (!$cart) {
	// unable to retrieve cart from db
	if ($from_server) {
		die($systempay_resp->getOutputForGateway('order_not_found'));
	}
	Tools::redirectLink(
			__PS_BASE_URI__ . 'order-confirmation.php?id_cart=' . $id_cart
					. '&id_module=' . $systempay->id . '&error=payment_error');
}

// Retrieve order
$id_order = intval(Order::getOrderByCartId($cart->id));
$order = new Order($id_order);

// Act according to case
if (empty($order->id_cart)) {
	// Order has not been accepted yet
	if ($systempay_resp->isAcceptedPayment()) {
		// Payment OK
		
		$order = $systempay->validate($id_cart, _PS_OS_PAYMENT_, $systempay_resp);

		// Display success message
		if ($from_server) {
			// Display server code
			die ($systempay_resp->getOutputForGateway('payment_ok'));
		} else {
			$extra_param = "";
			if ($systempay_resp->get('ctx_mode') == 'TEST') {
				// !$from_server => this is a client return
				// ctx_mode=TEST => the user is the webmaster
				// order has not been paid, but we receive a successful payment code => automatic response didn't work
				// So we display a warning about the not working check_url
				$extra_param = "&check_url_warn=on";
			}
			
			// Amount paid not equals initial amount. Error ! 
			if (number_format($order->total_paid, 2) != number_format($order->total_paid_real, 2)) {
				$extra_param .= "&error=amount_error";
			}
			
			Tools::redirectLink(
					__PS_BASE_URI__ . 'order-confirmation.php?id_cart=' . $id_cart
							. '&id_module=' . $systempay->id . '&id_order=' . $order->id . '&key='
							. $order->secure_key . $extra_param);
		}
	} else {
		// Payment KO
		$systempay->managePaymentFailure($systempay_resp, $id_cart, $from_server, $order);
	}
} else {
	// Order already registered
	if ($order->hasBeenPaid() && $systempay_resp->isAcceptedPayment()) {
		// Just display a confirmation message
		if ($from_server) {
			die($systempay_resp->getOutputForGateway('payment_ok_already_done'));
		} else {
			Tools::redirectLink(
					__PS_BASE_URI__ . 'order-confirmation.php?id_cart=' . $id_cart
							. '&id_module=' . $systempay->id . '&id_order=' . $order->id . '&key='
							. $order->secure_key);
		}
	} if(!$order->hasBeenPaid() && !$systempay_resp->isAcceptedPayment()) {
		// Order has been registred with payment error status. Payment failure reconfirmed. 
		if ($from_server) {
			die($systempay_resp->getOutputForGateway('payment_ko_already_done'));
		} else {
			Tools::redirectLink(__PS_BASE_URI__ . 'history.php');
		}
	} else {
		// Invalid payment code received, but order has already been registered !
		if ($from_server) {
			die($systempay_resp->getOutputForGateway('payment_ko_on_order_ok'));
		} else {
			$extra_param = "";
			if (number_format($order->total_paid, 2) != number_format($order->total_paid_real, 2)) {
				// Amount paid not equals to initial amount. 
				$extra_param .= "&error=amount_error";
			} else {
				// Other error 
				$extra_param = "&error=cancel_on_accepted";
			}
			
			Tools::redirectLink(
					__PS_BASE_URI__ . 'order-confirmation.php?id_cart=' . $id_cart
							. '&id_module=' . $systempay->id . '&id_order=' . $order->id . '&key='
							. $order->secure_key . $extra_param);
		}
	}
}
?>