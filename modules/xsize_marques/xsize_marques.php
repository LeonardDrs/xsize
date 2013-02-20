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

		// $this->page = basename(__FILE__, '.php');
		$this->displayName = $this->l('xSize Marques');
		$this->description = $this->l('Mise à jour des tailles en fonction des marques');
	}

	function createDb()
	{
		Db::getInstance()->Execute('
		CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'xsize_marques` (
		`id_correspondance` int(11) NOT NULL AUTO_INCREMENT UNIQUE,
		`id_manufacturer` int(11) NOT NULL,
		`cm` varchar(255) NOT NULL,
		`taille` varchar(255) NOT NULL,
		KEY `id_correspondance` (`id_correspondance`)
		)ENGINE=MyISAM DEFAULT CHARSET=latin1;');
	}

	function install()
	{
		$this->createDb();
		if(!parent::install() || !$this->registerHook('home') || !$this->registerHook('header')) return false;
	}

	public function uninstall()
	{
		Db::getInstance()->Execute('DROP TABLE `'._DB_PREFIX_.'xsize_marques`');
		return (parent::uninstall());
	}

	//Config



	function getContent()
	{
		if (Tools::isSubmit('upload'))$this->uploade();
		$this -> affiche();
	}



/*###################################################################*/
	function uploade(){
		var_dump($_POST);
	}

	function upload(){
		//Uploading
		$astrIncomingFiles = array('1_jpg', '2_jpg', '3_jpg', '4_jpg', '5_jpg');
		$astrFilenames = array('1.jpg', '2.jpg', '3.jpg', '4.jpg','5.jpg');
		$auiDimensions = array(array(1500, 700), array(1500, 700), array(1500, 700), array(1500, 700), array(1500, 700));

		echo '<div class="conf confirm">';

		for ($i = 0; $i < 5; ++$i)
		{
			$infile = $astrIncomingFiles[ $i ];
			$outfile = $astrFilenames[ $i ];
			if ($_FILES[ $infile ]['error'] != UPLOAD_ERR_NO_FILE)
			{
				if (isset($_FILES[ $infile ]['name']) && ($_FILES[ $infile ]['error'] == UPLOAD_ERR_OK))
				{
					$auiImgSize = getimagesize($_FILES[ $infile ]['tmp_name']);
					$auiImgDims = $auiDimensions[ $i ];

					if (($auiImgSize[ 0 ] <= $auiImgSize[ 0 ]) && ($auiImgSize[ 1 ] <= $auiImgSize[ 1 ])) // ici pour check la taille etc
					{
						if (move_uploaded_file($_FILES[ $infile ]['tmp_name'], _PS_ROOT_DIR_.'/modules/Slider/images/'.$outfile))
						{
							$title=Tools::getValue("title".strval($i+1));
							$href=Tools::getValue("url".strval($i+1));
							$url='./modules/Slider/images/'.strval($i+1).'.jpg';
							$id=$i+1;
							Db::getInstance()->autoExecute(_DB_PREFIX_.'xsize_slider', array(
								'id_image' => $id,
								'title' =>     pSQL($title),
								'url' =>       pSQL($url),
								'href' =>      pSQL($href)
							), 'UPDATE','id_image ='.$id);
							// var_dump($_FILES[ $infile ]);
							echo "<li> Image ".$outfile.$title.$url." charg&eacute;e avec succ&egrave;s</li>";
						}
						else
						{
							echo "<li> Echec du chargement de l'image ".$outfile.".</li>";
						}
					}
					else
					{
						echo '<li> Les dimensions de l\'image '.$outfile.' sont incorrectes. Fichier : ('.$auiImgSize[0].', '.$auiImgSize[1].') Requis : ('.$auiImgDims[0].', '.$auiImgDims[1].')</li>';
					}
				}
				else
				{
					switch ($_FILES[ $infile ]['error'])
					{
						case UPLOAD_ERR_INI_SIZE:
							 $message = "The uploaded file exceeds the upload_max_filesize directive in php.ini";
							 break;
						case UPLOAD_ERR_FORM_SIZE:
							 $message = "The uploaded file exceeds the MAX_FILE_SIZE directive that was specified in the HTML form";
							 break;
						case UPLOAD_ERR_PARTIAL:
							 $message = "The uploaded file was only partially uploaded";
							 break;
						case UPLOAD_ERR_NO_FILE:
							 $message = "No file was uploaded";
							 break;
						case UPLOAD_ERR_NO_TMP_DIR:
							 $message = "Missing a temporary folder";
							 break;
						case UPLOAD_ERR_CANT_WRITE:
							 $message = "Failed to write file to disk";
							 break;
						case UPLOAD_ERR_EXTENSION:
							 $message = "File upload stopped by extension";
							 break;

						default:
							 $message = "Unknown upload error";
							 break;
					}

					echo '<li>Erreur lors du chargement du fichier '.$outfile.' : '.$message.'</li>';
				}
			}
			else
			{
				echo '<li>Image "'.$infile.'" inchang&eacute;e.</li>';
			}
		}
		echo '</div><br />';

	}

/*###################################################################*/
	function affiche() //Panneau de gestion 
	{
		$marques = $this->getMarques();
		$last = "";
		// foreach($marques as $key=>$marque){
		// 	echo "<pre>";
		// 	var_dump($marque);
		// 	echo "</pre>";
		// 	foreach ($marque['taille'] as $key => $taille) {
		// 		var_dump($taille);
		// 	}
		// }
		echo '
				<FORM id="mod_marques" method="POST" action="'.$_SERVER['REQUEST_URI'].'" ENCTYPE="multipart/form-data">
					</br></br>

                    Ce module vous permet de modifier les tailles en fonction des marques.<br/><br/><br/>
          
                   <hr>
                   <table>
                   <tr><th>Marque</th><th>Taille</th><th>Centimètres</th></tr>

';
					foreach($marques as $key=>$marque)
					{
						
						echo '<tr>
						<td><b>'.$marque['name'].'</b></td>
						<td><input type=text name="'.$marque['id_manufacturer'].'-taille[]" value="'.$marque['taille'].'" /></td>
						<td><input type=text name="'.$marque['id_manufacturer'].'-cm[]" value="'.$marque['cm'].'" /></td>
						';
						if ($last != $marque['name']){ echo '<td><a href="#">Ajouter</a>';}
						echo '</tr>';
						if ($last == $marque['name'] && !empty($marque['taille'])){
							echo '<tr>
							<td class="new" ><b>'.$marque['name'].'</b></td>
							<td><input type=text name="'.$marque['id_manufacturer'].'-taille[]" value="" /></td>
							<td><input type=text name="'.$marque['id_manufacturer'].'-cm[]" value="" /></td>
							</tr>';
						}
						$last = $marque['name'];
					}
echo '

					</table>
					<INPUT type=submit name="upload" value="Envoyer">
					
					                                           <hr> 


				</FORM>'
;
				
	}
	
	function getMarques()
	{
		// $sql='
		// SELECT m.id_manufacturer, m.name, (SELECT taille FROM `'._DB_PREFIX_.'xsize_marques` AS xm WHERE xm.id_manufacturer = m.id_manufacturer) AS taille, (SELECT cm FROM `'._DB_PREFIX_.'xsize_marques` AS xm WHERE xm.id_manufacturer = m.id_manufacturer) AS cm 
		// FROM '._DB_PREFIX_.'manufacturer AS m
		// ORDER BY `name`';
		$sql='
		SELECT m.id_manufacturer, m.name, xm.taille,xm.cm FROM `'._DB_PREFIX_.'manufacturer` AS m LEFT JOIN `'._DB_PREFIX_.'xsize_marques` AS xm ON xm.id_manufacturer = m.id_manufacturer ORDER BY `name`';
		if ($results = Db::getInstance()->ExecuteS($sql))
			foreach ($results as $key=>$row)
			{
					$marques[$key] = $row;
			}
		// var_dump($marques);
		return $marques;
	}

	function hookHeader($params){
		Tools::addCSS(_MODULE_DIR_.$this->name.'/css/'.$this->name.'.css');
		Tools::addJS(_MODULE_DIR_.$this->name.'/js/jquery.cycle.js');
		Tools::addJS(_MODULE_DIR_.$this->name.'/js/'.$this->name.'.js');
	}
	
	function hookHome($params)
	{
		global $smarty;
		$marques = $this->getMarques();
		$smarty->assign('marques',$marques);
		return $this->display(__FILE__, 'Slider.tpl');
	}
}
