<?php

if (!defined('_PS_VERSION_'))
	exit;

class bh_auto_menu extends Module
{

	private $config = array('BH_AM_DISPLAY_HB'=>1,'BH_AM_DISPLAY_CAT'=>0);
	
	function __construct()
	{
		$this->name = 'bh_auto_menu';
		$this->tab = 'Bastien HERAULT';
		if (_PS_VERSION_ >= 1.4) 
			$this->tab = 'front_office_features';
		$this->author = 'Bastien HERAULT';
		$this->version = 1.0;
		parent::__construct();
		$this->displayName = $this->l('Automatic horizontal menu for categories');
		$this->description = $this->l('This module add an horizontal menu to the header section of your website. It\'s automatically build from the categories of your website !');
		$config = Configuration::getMultiple(array_keys($this->config));
		if (is_array($config) && $config>0) 
			$this->config = $config;
	}

	function install()
	{
		if (!parent::install() OR !$this->registerHook('header') OR !$this->registerHook('top'))
			return false;
		if (is_array($this->config) && $this->config>0) {
			foreach ($this->config as $key=>$value) {
				Configuration::updateValue($key, $value);
			}
		}
		return true;
	}
	
	function uninstall()
    {
		if (is_array($this->config) && $this->config>0) {
			foreach ($this->config as $key=>$value) {
				Configuration::deleteByName($key);
			}
		}
        if (!parent::uninstall())
            return false;
        return true;
    }
	
	public function getContent() {
		$output = '<h2>'.$this->displayName.'</h2>';
		if (Tools::isSubmit('submitAutoMenu'))
		{
			$errors = array ();
			$BH_AM_DISPLAY_HB = (int)(Tools::getValue('BH_AM_DISPLAY_HB'));
			$BH_AM_DISPLAY_CAT = (int)(Tools::getValue('BH_AM_DISPLAY_CAT'));
			if (!isset($BH_AM_DISPLAY_HB) || ($BH_AM_DISPLAY_HB!==0 && $BH_AM_DISPLAY_HB!==1))
				$errors[] = $this->l('Invalid value for link to home');
			if (!isset($BH_AM_DISPLAY_CAT) || ($BH_AM_DISPLAY_CAT!==0 && $BH_AM_DISPLAY_CAT!==1))
				$errors[] = $this->l('Invalid value for Categories block display');
			if (empty($errors)) {
				Configuration::updateValue('BH_AM_DISPLAY_HB', (int)($BH_AM_DISPLAY_HB));
				Configuration::updateValue('BH_AM_DISPLAY_CAT', (int)($BH_AM_DISPLAY_CAT));
				$output .= $this->displayConfirmation($this->l('Settings updated'));
			}
			else 
				$output .= $this->displayError(implode('<br />', $errors));				
		}
		return $output.$this->displayForm().$this->displaySupport();
	}
	
	public function displayForm() {
		$output = '
		<form action="'.$_SERVER['REQUEST_URI'].'" method="post">
			<fieldset><legend><img src="'.$this->_path.'logo.gif" alt="" title="" />'.$this->l('Settings').'</legend>
				<h3 style="color: #268CCD; text-align: center;">'.$this->l('This module need the "Categories block module by Prestashop" installed and activated to work !').'</h3><br />
				<label style="width: 600px;">'.$this->l('Display a link to home in the menu ?').'</label>
				<div class="margin-form" style="padding-left: 610px;">
					<input type="radio" name="BH_AM_DISPLAY_HB" id="BH_AM_DISPLAY_HB_ON" value="1" '.(intval(Tools::getValue('BH_AM_DISPLAY_HB', $this->config['BH_AM_DISPLAY_HB']))==1 ? 'checked="checked" ' : '').'/>
					<label class="t" for="BH_AM_DISPLAY_HB_ON"> <img src="../img/admin/enabled.gif" alt="'.$this->l('Enabled').'" title="'.$this->l('Enabled').'" /></label>
					<input type="radio" name="BH_AM_DISPLAY_HB" id="BH_AM_DISPLAY_HB_OFF" value="0" '.(intval(Tools::getValue('BH_AM_DISPLAY_HB', $this->config['BH_AM_DISPLAY_HB']))==0 ? 'checked="checked" ' : '').'/>
					<label class="t" for="BH_AM_DISPLAY_HB_OFF"> <img src="../img/admin/disabled.gif" alt="'.$this->l('Disabled').'" title="'.$this->l('Disabled').'" /></label>
				</div>
				<br class="clear" />
				<label style="width: 600px;">'.$this->l('Also display the Categories block menu in right or left column ?').'</label>
				<div class="margin-form" style="padding-left: 610px;">
					<input type="radio" name="BH_AM_DISPLAY_CAT" id="BH_AM_DISPLAY_CAT_ON" value="1" '.(intval(Tools::getValue('BH_AM_DISPLAY_CAT', $this->config['BH_AM_DISPLAY_CAT']))==1 ? 'checked="checked" ' : '').'/>
					<label class="t" for="BH_AM_DISPLAY_CAT_ON"> <img src="../img/admin/enabled.gif" alt="'.$this->l('Enabled').'" title="'.$this->l('Enabled').'" /></label>
					<input type="radio" name="BH_AM_DISPLAY_CAT" id="BH_AM_DISPLAY_CAT_OFF" value="0" '.(intval(Tools::getValue('BH_AM_DISPLAY_CAT', $this->config['BH_AM_DISPLAY_CAT']))==0 ? 'checked="checked" ' : '').'/>
					<label class="t" for="BH_AM_DISPLAY_CAT_OFF"> <img src="../img/admin/disabled.gif" alt="'.$this->l('Disabled').'" title="'.$this->l('Disabled').'" /></label>
				</div>
				<br class="clear" />
				<center><input type="submit" name="submitAutoMenu" value="'.$this->l('Save').'" class="button" /></center>
			</fieldset>
		</form>';
		return $output;
	}
	
	private function displaySupport() {
		$str = '';
		$str .= '
<br />
<fieldset>
<legend>'.$this->l('Credits').'</legend>
'.$this->l('This module was developed by Bastien HERAULT.').'<br />
'.$this->l('Thank you to report any bug on our website').' <br />
'.$this->l('Please note that we do not answer questions about the module usage.').'
</fieldset>';
		return ($str);
	}

	function hookHeader($params)
	{
		global $smarty;
		if (is_array($this->config) && $this->config>0) {
			$smarty->assign($this->config);
		}
		return $this->display(__FILE__, 'bh_auto_menu_header.tpl');
	}
	
	function hookTop($params)
	{
		
		return $this->display(__FILE__, 'bh_auto_menu.tpl');
	}
	
}

?>