<?php

class BlockHTML extends Module
{
	function __construct()
	{
		$this->name = 'blockhtml';
		$this->tab = 'Blocks';
		$this->version = '0.1';

		parent::__construct(); // The parent construct is required for translations

		$this->page = basename(__FILE__, '.php');
		$this->displayName = $this->l('Block HTML');
		$this->description = $this->l('Adds a block with free HTML code');
	}

	function install()
	{
		if (!parent::install())
			return false;
		if (!$this->registerHook('leftColumn'))
			return false;
		return true;
	}

	/**
	* Returns module content
	*
	* @param array $params Parameters
	* @return string Content
	*/
	function hookLeftColumn($params)
	{
		if (file_exists(dirname(__FILE__).'/values.xml'))
		{
			if ($xml = simplexml_load_file(dirname(__FILE__).'/values.xml'))
			{
				global $cookie, $smarty;
				$smarty->assign(array(
					'text' => $xml->{'left_'.$cookie->id_lang},
					'this_path' => $this->_path
				));
				return $this->display(__FILE__, 'blockhtml.tpl');
			}
		}
		return false;
	}

	/**
	* Returns module content
	*
	* @param array $params Parameters
	* @return string Content
	*/
	function hookRightColumn($params)
	{
		if (file_exists(dirname(__FILE__).'/values.xml'))
		{
			if ($xml = simplexml_load_file(dirname(__FILE__).'/values.xml'))
			{
				global $cookie, $smarty;
				$smarty->assign(array(
					'text' => $xml->{'right_'.$cookie->id_lang},
					'this_path' => $this->_path
				));
				return $this->display(__FILE__, 'blockhtml.tpl');
			}
		}
		return false;
	}

	function getContent()
	{
		/* display the module name */
		$this->_html = '<h2>'.$this->displayName.'</h2>';

		/* update the editorial xml */
		if (isset($_POST['submitUpdate']))
		{
			// Forbidden key
			$forbidden = array('submitUpdate');

			// Generate new XML data
			$newXml = '<?xml version=\'1.0\' encoding=\'utf-8\' ?>'."\n";
			$newXml .= '<html>'."\n";
			// Making header data
			foreach ($_POST AS $key => $field)
			{
				if (_PS_MAGIC_QUOTES_GPC_)
					$field = stripslashes($field);
				if ($line = $this->putContent($newXml, $key, $field, $forbidden, 'header'))
					$newXml .= $line;
			}
			$newXml .= "\n</html>\n";

			/* write it into the editorial xml file */
			if ($fd = @fopen(dirname(__FILE__).'/values.xml', 'w'))
			{
				if (!@fwrite($fd, $newXml))
					$this->_html .= $this->displayError($this->l('Unable to write to the text file.'));
				if (!@fclose($fd))
					$this->_html .= $this->displayError($this->l('Can\'t close the text file.'));
			}
			else
				$this->_html .= $this->displayError($this->l('Unable to update the text file.<br />Please check the text file\'s writing permissions.'));
		}

		/* display the editorial's form */
		$this->_displayForm();

		return $this->_html;
	}

	private function _displayForm()
	{
		/* Languages preliminaries */
		$defaultLanguage = intval(Configuration::get('PS_LANG_DEFAULT'));
		$languages = Language::getLanguages();
		$iso = Language::getIsoById($defaultLanguage);
		$divLangName = 'text_left¤text_right';

		/* xml loading */
		$xml = false;
		if (file_exists(dirname(__FILE__).'/values.xml'))
				if (!$xml = @simplexml_load_file(dirname(__FILE__).'/values.xml'))
					$this->_html .= $this->displayError($this->l('Your text file is empty.'));

		$this->_html .= '
		<script language="javascript">id_language = Number('.$defaultLanguage.');</script>
		<form method="post" action="'.$_SERVER['REQUEST_URI'].'">
			<fieldset>
				<legend><img src="'.$this->_path.'logo.gif" alt="" title="" /> '.$this->displayName.'</legend>
				<label>'.$this->l('Left text').'</label>
				<div class="margin-form">';

				foreach ($languages as $language)
				{
					$this->_html .= '
					<div id="text_left_'.$language['id_lang'].'" style="display: '.($language['id_lang'] == $defaultLanguage ? 'block' : 'none').';float: left;">
						<textarea cols="64" rows="10" id="left_'.$language['id_lang'].'" name="left_'.$language['id_lang'].'">'.($xml ? stripslashes(htmlspecialchars($xml->{'left_'.$language['id_lang']})) : '').'</textarea>
					</div>';
				 }

				$this->_html .= $this->displayFlags($languages, $defaultLanguage, $divLangName, 'text_left', true);

				$this->_html .= '
					<p class="clear">'.$this->l('Text of your choice; for example, explain your mission, highlight a new product, or describe a recent event').'</p>
				</div>
				<label>'.$this->l('Right text').'</label>
				<div class="margin-form">';

				foreach ($languages as $language)
				{
					$this->_html .= '
					<div id="text_right_'.$language['id_lang'].'" style="display: '.($language['id_lang'] == $defaultLanguage ? 'block' : 'none').';float: left;">
						<textarea cols="64" rows="10" id="right_'.$language['id_lang'].'" name="right_'.$language['id_lang'].'">'.($xml ? stripslashes(htmlspecialchars($xml->{'right_'.$language['id_lang']})) : '').'</textarea>
					</div>';
				 }

				$this->_html .= $this->displayFlags($languages, $defaultLanguage, $divLangName, 'text_right', true);

				$this->_html .= '
					<p class="clear">'.$this->l('Text of your choice; for example, explain your mission, highlight a new product, or describe a recent event').'</p>
				</div>
				<div class="clear pspace"></div>
				<div class="margin-form clear"><input type="submit" name="submitUpdate" value="'.$this->l('Update the text').'" class="button" /></div>
			</fieldset>
		</form>';
	}

	function putContent($xml_data, $key, $field, $forbidden)
	{
		foreach ($forbidden AS $line)
			if ($key == $line)
				return 0;
		$field = htmlspecialchars($field);
		if (!$field)
			return 0;
		return ("\n".'		<'.$key.'>'.$field.'</'.$key.'>');
	}

}
?>
