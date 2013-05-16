<?php

class xsize_marques extends Module
{

	public function __construct()
	{
 	 	$this->name = 'xsize_marques';
		$this->tab = 'xsize';
 	 	$this->version = '1.0';
		$this->author = 'xSize';
		$this->need_instance = 0;
		
	 	parent::__construct();

		$this->page = basename(__FILE__, '.php');
		$this->displayName = $this->l('xSize Marques');
		$this->description = $this->l('Mise à jour des tailles en fonction des marques');
	}

	function createDb()
	{
		Db::getInstance()->Execute('
		CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'xsize_marques` (
		`id_correspondance` int(11) NOT NULL AUTO_INCREMENT,
		`id_manufacturer` int(11) NOT NULL,
		`cm` varchar(255) NOT NULL,
		`taille` varchar(255) NOT NULL,
		KEY `id_correspondance` (`id_correspondance`)
		)ENGINE=MyISAM DEFAULT CHARSET=latin1;');
	}

	function install()
	{
		$this->createDb();
		if(!parent::install() || !$this->registerHook('home') || !$this->registerHook('header') OR !$this->registerHook('productMarqueDescription'))
			return false;
	}

	public function uninstall()
	{
		Db::getInstance()->Execute('DROP TABLE `'._DB_PREFIX_.'xsize_marques`');
		return (parent::uninstall());
	}

	//Config



	function getContent()
	{
		if (Tools::isSubmit('upload'))$this->upload();
		$this -> affiche();
	}



/*###################################################################*/

	function upload(){
		foreach ($_POST as $key=>$marq) {
			$nb =  preg_replace("#[-a-zA-Z]#", "", $key);
			if (isset($manufacturer[$nb])) {
				array_push($manufacturer[$nb],$marq);
			} else {
				$manufacturer[$nb]=array($marq);
			}
		}
		
		$sql = "INSERT INTO  `"._DB_PREFIX_."xsize_marques` (
		`id_correspondance` ,
		`id_manufacturer` ,
		`taille` ,
		`cm`
		)
		VALUES";
		if ($manufacturer) {
			foreach ($manufacturer as $key=>$marq) {
				if ($marq[0]) {
					foreach($marq[0] as $k=>$val) {
						if (!empty($marq[0][$k])) {
							$sql.= " (
							NULL ,  '".$key."',  '".$marq[0][$k]."',  '".$marq[1][$k]."'
							),";
						}
					}
				}
			}
		}

		Db::getInstance()->Execute('TRUNCATE TABLE `'._DB_PREFIX_.'xsize_marques`');
		Db::getInstance()->Execute(substr($sql,0,-1));
	}

/*###################################################################*/
	function affiche() //Panneau de gestion 
	{
		$marques = $this->getMarques();
		$last = "";

		echo '
				<FORM id="mod_marques" method="POST" action="'.$_SERVER['REQUEST_URI'].'">
					</br></br>

                    Ce module vous permet de modifier les tailles en fonction des marques.<br/><br/><br/>
          
                   <hr>
';

					foreach($marques as $key=>$marque)
					{
						if ($last != $marque['name']){ // if first
							echo '
							<div class="'.$marque['name'].'" style="margin:20px 0 10px;">
							<b>'.$marque['name'].'</b>
							<br>';
						}
						if (!empty($marque['taille'])){
							echo '
							<div class="ctn" style="margin-top:5px;">
								<input type=text name="'.$marque['id_manufacturer'].'-taille[]" value="'.$marque['taille'].'" />
								<input type=text name="'.$marque['id_manufacturer'].'-cm[]" value="'.$marque['cm'].'" />
							</div>
							';
						}
						if ($marques[$key+1]['name']!=$marque['name']) { // if last
							echo '
							<div class="ctn" style="margin-top:5px;display:inline-block">
								<input type=text name="'.$marque['id_manufacturer'].'-taille[]" value="" />
								<input type=text name="'.$marque['id_manufacturer'].'-cm[]" value="" />
							</div>
							<span class="add" style="display:inline-block;cursor:pointer;">Ajouter</span>
							';
							echo '</div>';
						}
						$last = $marque['name'];
					}
echo '

					</table>
					<INPUT type=submit name="upload" value="Envoyer">
					
					                                           <hr> 


				</FORM>
				<script type="text/javascript" charset="utf-8">
					$(".add").click(function(){
						$(this).prev(".ctn").clone().find("input").val("").end().insertBefore($(this))
						$(this).prev().prev().css("display","block");
					})
				</script>'
;
				
	}
	
	function getMarques($front = false)
	{
		// $sql='
		// SELECT m.id_manufacturer, m.name, (SELECT taille FROM `'._DB_PREFIX_.'xsize_marques` AS xm WHERE xm.id_manufacturer = m.id_manufacturer) AS taille, (SELECT cm FROM `'._DB_PREFIX_.'xsize_marques` AS xm WHERE xm.id_manufacturer = m.id_manufacturer) AS cm 
		// FROM '._DB_PREFIX_.'manufacturer AS m
		// ORDER BY `name`';
		$sql='
		SELECT m.id_manufacturer, m.name, xm.taille,xm.cm FROM `'._DB_PREFIX_.'manufacturer` AS m LEFT JOIN `'._DB_PREFIX_.'xsize_marques` AS xm ON xm.id_manufacturer = m.id_manufacturer';
		if ($results = Db::getInstance()->ExecuteS($sql))
			foreach ($results as $key=>$row)
			{
					$marques[$key] = $row;
			}
		

		foreach ($marques as $key) {
			if (isset($manufacturer[$key['id_manufacturer']])) {
				array_push($manufacturer[$key['id_manufacturer']],$key);
			} else {
				$manufacturer[$key['id_manufacturer']]=array($key);
			}
		}

		if ($front) {
			return $manufacturer;
		} else {
			return $marques;
		}
	}

	// function hookHeader($params){
		// Tools::addCSS(_MODULE_DIR_.$this->name.'/css/'.$this->name.'.css');
		// Tools::addJS(_MODULE_DIR_.$this->name.'/js/jquery.cycle.js');
		// Tools::addJS(_MODULE_DIR_.$this->name.'/js/'.$this->name.'.js');
	// }
	
	public function hookProductMarqueDescription($params)
	{
		global $smarty;
		$id_p = Tools::getValue('id_product');
		$id_manufacturer = Db::getInstance()->getValue('SELECT `id_manufacturer` FROM `'._DB_PREFIX_.'product` WHERE `id_product`='.$id_p);
		$marques = $this->getMarques(true);
		$smarty->assign('marques',$marques);
		$smarty->assign('manufacturer_id',$id_manufacturer);
		return $this->display(__FILE__, 'marques.tpl');
	}
}
