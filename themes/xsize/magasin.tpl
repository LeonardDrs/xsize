{include file="$tpl_dir./breadcrumb.tpl"}
<h1>{l s="MAGASIN"}</h1>
<section class="page" id="formulaire-contact">
	<form action="{$request_uri|escape:'htmlall':'UTF-8'}" method="post" enctype="multipart/form-data">
					<h2 class="mail">{l s="Nous contacter :"}</h2>
					<img id="sep-magasin-contact" src="themes/xsize/img/assets/sep-map.png" alt="separateur" width="411" height="1" />
					<label>{l s="Nom "}<span class="required">*</span></label><input class="form champs-magasin" required>
					<label>{l s="Email "}<span class="required">*</span></label>
					{if isset($customerThread.email)}
					<input type="text" class="form champs-magasin" name="from" value="{$customerThread.email}" readonly="readonly" required/>
					{else}
					<input type="text" class="form champs-magasin" name="from" value="{$email}" required/>
					{/if}
					<label>{l s="Votre message "}<span class="required">*</span></label>
					<textarea class="form" name="message" rows="10" cols="32">{if isset($message)}{$message|escape:'htmlall':'UTF-8'|stripslashes}{/if}</textarea>	
					<label class="legend"><span class="required">*</span>{l s=" : Champs obligatoire"}</label>
					<input class="button-magasin" type="submit" name="submitMessage" id="submitMessage" value="{l s="Valider"}" class="button_large" onclick="$(this).hide();" />
				</form>
</section>
<section class="page" id="mapzone">
			
					<div id="map-canvas" style="width: 499px; height: 330px; margin-bottom:30px;"></div>
				
				<section id="gmapAdress">
					<p class="tel">02 45 48 38 95</p>
					<p class="adress">:  7 rue royale, 57000 Orl&eacute;ans, France</p>
				</section>
				<section id="gmapAdress">
					<p>X-size est un magasin de v&ecirc;tements grandes tailles taillant du L au 12XL, N'h&eacute;sitez pas &agrave; venir nous rencontrer dans notre magasin.</p>
				</section>
				<img id="sep-magasin" src="themes/xsize/img/assets/sep-map.png" alt="separateur">
			</section>

<section id="photozone">
	{$SLIDERMAGASIN}
</section>
