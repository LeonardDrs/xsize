<?php
if (!defined('_CAN_LOAD_FILES_'))
	exit;

/* Facebook Like Box Block
 *
 * Adds a Facebook social plugin Like Box
 *
 * @ (C) Copyright 2010 by (internet-solutions.si | celavi.org) Ales Loncar
 * @ Version 0.1
 *
 */
class BlockFbLikeBox extends Module
{
    private $_html = '';
    private $_lb_facebook_page_url = '';
    private $_lb_width = '';
    private $_lb_height = '';
    private $_lb_connections = '';
    private $_lb_stream = '';
    private $_lb_header = '';
    private $_lb_transparency = '';
    private $_lb_bg_color = '';

    function __construct()
    {
        $this->name = 'blockfblikebox';
        $this->tab  = 'internet-solutions.si | celavi.org';
        $this->version = 0.3;

        parent::__construct();
        $this->_refreshProperties();

        $this->displayName = $this->l('Facebook Like Box Block');
        $this->description = $this->l('Adds a Facebook social plugin Like Box');
    }

    public function install()
    {
        if (!parent::install() OR
            !$this->registerHook('rightColumn') )
                return false;
        Configuration::updateValue('LB_FACEBOOK_PAGE_URL','http://www.facebook.com/pages/Fit-Body-Shop/147527681944441');
        Configuration::updateValue('LB_WIDTH','190');
        Configuration::updateValue('LB_HEIGHT','370');
        Configuration::updateValue('LB_CONNECTIONS','9');
        Configuration::updateValue('LB_BG_COLOR', '#FFFFFF');
        return true;
    }

    function hookRightColumn($params)
    {
        global $smarty;

        $smarty->assign('facebook_page_url', $this->_lb_facebook_page_url);
        $smarty->assign('facebook_width', $this->_lb_width);
        $smarty->assign('facebook_height', $this->_lb_height);
        $smarty->assign('facebook_connections', $this->_lb_connections);
        $smarty->assign('facebook_stream', ($this->_lb_stream) ? 'true' : 'false');
        $smarty->assign('facebook_header', ($this->_lb_header) ? 'true' : 'false');
        $smarty->assign('allow_transparency', ($this->_lb_transparency) ? 'true' : 'false');
        $smarty->assign('bg_color', $this->_lb_bg_color);


        return $this->display(__FILE__, 'blockfblikebox.tpl');
    }

    function hookLeftColumn($params)
    {
        return $this->hookRightColumn($params);
    }

    public function getContent()
    {
        $this->_html = '<h2>'.$this->displayName.'</h2>';
        $this->_postProcess();
        $this->_displayForm();
        return $this->_html;
    }

    private function _postProcess()
    {
        if (Tools::isSubmit('submitChanges')) {
            if (!Configuration::updateValue('LB_FACEBOOK_PAGE_URL', Tools::getValue('lb_facebook_page_url'))
                || !Configuration::updateValue('LB_WIDTH', Tools::getValue('lb_width'))
                || !Configuration::updateValue('LB_HEIGHT', Tools::getValue('lb_height'))
                || !Configuration::updateValue('LB_CONNECTIONS', Tools::getValue('lb_connections'))
                || !Configuration::updateValue('LB_STREAM', Tools::getValue('lb_stream'))
                || !Configuration::updateValue('LB_HEADER', Tools::getValue('lb_header'))
                || !Configuration::updateValue('LB_TRANSPARENCY', Tools::getValue('lb_transparency'))
                || !Configuration::updateValue('LB_BG_COLOR', Tools::getValue('lb_bg_color')) )
                $this->_html .= '<div class="alert error">'.$this->l('Cannot update settings').'</div>';
            else
                $this->_html .= '<div class="conf confirm"><img src="../img/admin/ok.gif" alt="'.$this->l('Confirmation').'" />'.$this->l('Settings updated').'</div>';
        }
        $this->_refreshProperties();
    }

    private function _refreshProperties()
    {
        $this->_lb_facebook_page_url = Configuration::get('LB_FACEBOOK_PAGE_URL');
        $this->_lb_width            = Configuration::get('LB_WIDTH');
        $this->_lb_height           = Configuration::get('LB_HEIGHT');
        $this->_lb_connections      = Configuration::get('LB_CONNECTIONS');
        $this->_lb_stream           = Configuration::get('LB_STREAM');
        $this->_lb_header           = Configuration::get('LB_HEADER');
        $this->_lb_transparency     = Configuration::get('LB_TRANSPARENCY');
        $this->_lb_bg_color			= Configuration::get('LB_BG_COLOR');
    }

    private function _displayForm()
    {
        $this->_html .= '
            <form action="'.$_SERVER['REQUEST_URI'].'" method="post">
                <fieldset class="width3" style="width:850px">
                    <legend><img src="'.$this->_path.'logo.gif" />'.$this->l('Facebook Like Box Settings').'</legend>
                    <label>'.$this->l('Facebook Page URL').'</label>
                    <div class="margin-form">
                        <input style="width:500px;" type="text" name="lb_facebook_page_url" value="'.Tools::getValue('lb_facebook_page_url', $this->_lb_facebook_page_url).'" />
                        <p class="clear">'.$this->l('The URL of the Facebook Page for this Like box.').'</p>
                    </div>
                    <label>'.$this->l('Width').'</label>
                    <div class="margin-form">
                        <input type="text" name="lb_width" value="'.Tools::getValue('lb_width', $this->_lb_width).'" />
                        <p class="clear">'.$this->l('The width of the plugin in pixels.').'</p>
                    </div>
                    <label>'.$this->l('Height').'</label>
                    <div class="margin-form">
                        <input type="text" name="lb_height" value="'.Tools::getValue('lb_height', $this->_lb_height).'" />
                        <p class="clear">'.$this->l('The height of the plugin in pixels.').'</p>
                    </div>
                    <label>'.$this->l('Connections').'</label>
                    <div class="margin-form">
                        <input type="text" name="lb_connections" value="'.Tools::getValue('lb_connections', $this->_lb_connections).'" />
                        <p class="clear">'.$this->l('Show a sample of this many users who have liked this Page.').'</p>
                    </div>
                    <label>'.$this->l('Show stream').'</label>
                    <div class="margin-form">
                        <input type="checkbox" name="lb_stream" value="1" '.( Tools::getValue('lb_stream', $this->_lb_stream) ? 'checked="checked"' : false ).' />
                        <p class="clear">'.$this->l('Show the profile stream for the public profile.').'</p>
                    </div>
                    <label>'.$this->l('Show header').'</label>
                    <div class="margin-form">
                        <input type="checkbox" name="lb_header" value="1" '.( Tools::getValue('lb_header', $this->_lb_header) ? 'checked="checked"' : false ).' />
                        <p class="clear">'.$this->l('Show the "Find us on Facebook" bar at top. Only shown when either stream or connections are present.').'</p>
                    </div>
                    <label>'.$this->l('Allow Transparency').'</label>
                    <div class="margin-form">
                        <input type="checkbox" name="lb_transparency" value="1" '.( Tools::getValue('lb_transparency', $this->_lb_transparency) ? 'checked="checked"' : false ).' />
                        <p class="clear">'.$this->l('Allow transparency inside  iframe.').'</p>
                    </div>
                    <label>'.$this->l('Iframe background color').'</label>
                    <div class="margin-form">
                        <input type="text" name="lb_bg_color" value="'.Tools::getValue('lb_bg_color', $this->_lb_bg_color).'" />
                        <p class="clear">'.$this->l('Set iframe background color if transparency is not allowed.').'</p>
                    </div>
                    <input type="submit" name="submitChanges" value="'.$this->l('Update').'" class="button" />
                </fieldset>
            </form>';
    }
}