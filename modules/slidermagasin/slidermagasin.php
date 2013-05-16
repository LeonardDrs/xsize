<?php

if (!defined('_PS_VERSION_'))
	exit;

class SliderMagasin extends Module
{
	function __construct()
	{
		$this->name = 'slidermagasin';
		$this->tab = 'slider';
		$this->version = '1.0';
		$this->author = 'Hetic';
		$this->need_instance = 0;

		parent::__construct();

		$this->displayName = $this->l('Slider du magasin');
		$this->description = $this->l('Slider en bas de la page magasin.');
	}

	function install()
	{
	  	if (parent::install() == false OR !$this->registerHook('leftColumn') OR !$this->registerHook('sliderMagasin'))
	  		return false;
		return (parent::install());
	}


	public function uninstall()
	{
	  	if (!parent::uninstall())
	    	Db::getInstance()->Execute('DELETE FROM `'._DB_PREFIX_.'slidermagasin`');
	    parent::uninstall();
	}

	function getContent()
	{
		if ( Tools::isSubmit('upload'))$this ->upload();
		$this -> affiche();
	}

/*###################################################################*/
//SCRIPT D'UPLOAD D'IMAGE
	function redimensionner_image($fichier, $nouvelle_taille) {

	    //VARIABLE D'ERREUR
	    global $error;

	    //TAILLE EN PIXELS DE L'IMAGE REDIMENSIONNEE
	    $longueur = $nouvelle_taille;
	    $largeur = $nouvelle_taille;

	    //TAILLE DE L'IMAGE ACTUELLE
	    $taille = getimagesize($fichier);

		//SI LE FICHIER EXISTE
	    if ($taille) {

	        //SI JPG
	        if ($taille['mime']=='image/jpeg' ) {
	            //OUVERTURE DE L'IMAGE ORIGINALE
	            $img_big = imagecreatefromjpeg($fichier);
	            $img_new = imagecreate($longueur, $largeur);

	            //CREATION DE LA MINIATURE
	            $img_petite = imagecreatetruecolor($longueur, $largeur) or $img_petite = imagecreate($longueur, $largeur);

				//COPIE DE L'IMAGE REDIMENSIONNEE
	            imagecopyresized($img_petite,$img_big,0,0,0,0,$longueur,$largeur,$taille[0],$taille[1]);
	            imagejpeg($img_petite,$fichier);

	        }

	        //SI PNG
	        else if ($taille['mime']=='image/png' ) {
	            //OUVERTURE DE L'IMAGE ORIGINALE
	            $img_big = imagecreatefrompng($fichier); // On ouvre l'image d'origine
	            $img_new = imagecreate($longueur, $largeur);

	            //CREATION DE LA MINIATURE
	            $img_petite = imagecreatetruecolor($longueur, $largeur) OR $img_petite = imagecreate($longueur, $largeur);

	            //COPIE DE L'IMAGE REDIMENSIONNEE
	            imagecopyresized($img_petite,$img_big,0,0,0,0,$longueur,$largeur,$taille[0],$taille[1]);
	            imagepng($img_petite,$fichier);

	        }
	        // GIF
	        else if ($taille['mime']=='image/gif' ) {
	            //OUVERTURE DE L'IMAGE ORIGINALE
	            $img_big = imagecreatefromgif($fichier);
	            $img_new = imagecreate($longueur, $largeur);

	            //CREATION DE LA MINIATURE
	            $img_petite = imagecreatetruecolor($longueur, $largeur) or $img_petite = imagecreate($longueur, $largeur);

	            //COPIE DE L'IMAGE REDIMENSIONNEE
	            imagecopyresized($img_petite,$img_big,0,0,0,0,$longueur,$largeur,$taille[0],$taille[1]);
	            imagegif($img_petite,$fichier);

	        }
	    }
	}

	function upload(){
		//Uploading
		$astrIncomingFiles = array( '1_jpg', '2_jpg', '3_jpg', '4_jpg', '5_jpg', '6_jpg');
		$astrFilenames = array( '1.jpg', '2.jpg', '3.jpg', '4.jpg', '5.jpg', '6.jpg');

		echo '<div class="conf confirm">';

		for ( $i = 0; $i < 6; ++$i )
		{
			$infile = $astrIncomingFiles[ $i ];
			$outfile = $astrFilenames[ $i ];

			if ( $_FILES[ $infile ]['error'] != UPLOAD_ERR_NO_FILE )
			{
				if ( isset($_FILES[ $infile ]['name']) && ($_FILES[ $infile ]['error'] == UPLOAD_ERR_OK) )
				{
					$auiImgSize = getimagesize( $_FILES[ $infile ]['tmp_name'] );
					$auiImgDims = $auiDimensions[ $i ];

					if ( ($auiImgSize[ 0 ] <= 500) && ($auiImgSize[ 1 ] <= 500) )
					{
						if ( move_uploaded_file( $_FILES[ $infile ]['tmp_name'], _PS_ROOT_DIR_.'/modules/slidermagasin/images/'.$outfile ) )
						{
							$absImg = _PS_ROOT_DIR_.'/modules/slidermagasin/images/'.$outfile;
							$this -> redimensionner_image($absImg, 178);
							echo "<li> Image ".$outfile." charg&eacute;e avec succ&egrave;s</li>";
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
					switch ( $_FILES[ $infile ]['error'] )
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
		echo '
			<FORM method="POST" action="'.$_SERVER['REQUEST_URI'].'" ENCTYPE="multipart/form-data">
					<INPUT type=hidden name=MAX_FILE_SIZE  VALUE=1562144>
                    Ce module vous permet de modifier les images du slider de la page magasin.<Br></br>
          		<Br></br>

					<b>Image 1<u>.jpg</u></b><br/>
					<INPUT type=file name="1_jpg" accept="image/jpeg, image/jpg"><br/><br/>
					 Miniature :<br/><br/>
                     <img src="../modules/slidermagasin/images/1.jpg" border="0" width="200" ><br/><br/>

					<b>Image 2<u>.jpg</u></b><br/>
					<INPUT type=file name="2_jpg" accept="image/jpeg, image/jpg"><br/><br/>
					 Miniature :<br/><br/>
                    <img src="../modules/slidermagasin/images/2.jpg" border="0" width="200"><br/><br/>

					<b>Image 3<u>.jpg</u></b><br/>
					<INPUT type=file name="3_jpg" accept="image/jpeg, image/jpg"><br/><br/>
					 Miniature :<br/><br/>
                    <img src="../modules/slidermagasin/images/3.jpg" border="0" width="200"><br/><br/>

					<b>Image 4<u>.jpg</u></b><br/>
					<INPUT type=file name="4_jpg" accept="image/jpeg, image/jpg"><br/><br/>
					Miniature :<br/><br/>
                    <img src="../modules/slidermagasin/images/4.jpg" border="0" width="200"><br/><br/>

					<b>Image 5<u>.jpg</u></b><br/>
					<INPUT type=file name="5_jpg" accept="image/jpeg, image/jpg"><br/><br/>
					 Miniature :<br/><br/>
                     <img src="../modules/slidermagasin/images/5.jpg" border="0" width="200" ><br/><br/>

					<b>Image 6<u>.jpg</u></b><br/>
					<INPUT type=file name="6_jpg" accept="image/jpeg, image/jpg"><br/><br/>
					 Miniature :<br/><br/>
                    <img src="../modules/slidermagasin/images/6.jpg" border="0" width="200"><br/><br/>


					<INPUT type=submit name="upload" value="Envoyer">

				</FORM>'

	;

	}



	public function hookLeftColumn($params)
	{
	  	global $smarty;
	  	return $this->display(__FILE__, 'slidermagasin.tpl');
	}

	public function hookRightColumn($params)
	{
	  	return $this->hookLeftColumn($params);
	}

	function hooksliderMagasin($params)
	{
	  	return $this->hookLeftColumn($params);
	}
}