<?php

class Slider extends Module
{

	public function __construct()
	{
 	 	$this->name = 'Slider';
		$this->tab = 'xsize';
 	 	$this->version = '1.0';
		$this->author = 'xSize';
		$this->need_instance = 0;
		
	 	parent::__construct();

		// $this->page = basename(__FILE__, '.php');
		$this->displayName = $this->l('Slider Home');
		$this->description = $this->l('Slider d\'images pour la page d\'accueil');
	}

	function createDb()
	{
		Db::getInstance()->Execute('
		CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'xsize_slider` (
		`id_slide` int(11) NOT NULL AUTO_INCREMENT,
		`id_image` int(11) NOT NULL UNIQUE,
		`title` varchar(255) NOT NULL,
		`url` varchar(255) NOT NULL,
		`href` varchar(255) NOT NULL,
		KEY `id_slide` (`id_slide`)
		)ENGINE=MyISAM DEFAULT CHARSET=latin1;');
		for ($i=1; $i < 6; $i++)
		{
			Db::getInstance()->Execute('
			INSERT INTO `'._DB_PREFIX_.'xsize_slider` (`id_image`)
			VALUES ('.$i.')');
		}
	}

	function install()
	{
		$this->createDb();
		if(!parent::install() || !$this->registerHook('home') || !$this->registerHook('header')) return false;
	}

	public function uninstall()
	{
		Db::getInstance()->Execute('DROP TABLE `'._DB_PREFIX_.'xsize_slider`');
		return (parent::uninstall());
	}

	//Config



	function getContent()
	{
		if (Tools::isSubmit('upload'))$this ->upload();
		$this -> affiche();
	}



/*###################################################################*/
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
		$slides = $this->getImages();
		echo '
				<FORM method="POST" action="'.$_SERVER['REQUEST_URI'].'" ENCTYPE="multipart/form-data">
					<INPUT type=hidden name=MAX_FILE_SIZE  VALUE=1562144>
				
					</br></br>

                    Ce module vous permet de modifier les images du slider.<Br></br><Br></br>
          
                   <hr>'
;

					foreach($slides as $key=>$image)
					{
						echo '
						<b>Image '.($key+1).'<u>.jpg</u></b> Original dimension (530x240)<br/>
						<input type="file" name="'.($key+1).'.jpg" accept="image/jpeg, image/jpg"><br/><br/>
						 Miniature :<br/><br/>
						<img src=".'.$image[url].'" border="0" width="200" /><br/><br/>
						<label for="title'.($key+1).'" style="width:72px">Titre</label><input type="text" name="title'.($key+1).'" id="title'.($key+1).'" value="'.$image[title].'"><br/><br/>
						<label for="url'.($key+1).'" style="width:72px">Lien associé</label><input type="text" name="url'.($key+1).'" id="url'.($key+1).'" value="'.$image[href].'"><br/><br/>
						<hr> ';
						
					}
echo '

					
					<INPUT type=submit name="upload" value="Envoyer">
					
					                                           <hr> 


				</FORM>'
;
				
	}
	
	function getImages()
	{
		$sql='
		SELECT * 
		FROM '._DB_PREFIX_.'xsize_slider
		ORDER BY id_image';
		if ($results = Db::getInstance()->ExecuteS($sql))
			foreach ($results as $key=>$row)
			{
					$slides[$key] = $row;
			}
		return $slides;
	}

	function hookHeader($params){
		Tools::addCSS(_MODULE_DIR_.$this->name.'/css/'.$this->name.'.css');
		Tools::addJS(_MODULE_DIR_.$this->name.'/js/jquery.cycle.js');
		Tools::addJS(_MODULE_DIR_.$this->name.'/js/'.$this->name.'.js');
	}
	
	function hookHome($params)
	{
		global $smarty;
		$slides = $this->getImages();
		$smarty->assign('slides',$slides);
		return $this->display(__FILE__, 'Slider.tpl');
	}

}
