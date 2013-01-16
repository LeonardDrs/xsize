<!-- Block slidermagasin -->
<div id="featuredP">
	<div id="titreTopVente"><h2 id="titre-boutique">NOTRE BOUTIQUE</h2></div>
			<div id="navFeat">
				<a id="featuredNavLeft" title="produitsInf" href="/">Précédent</a>
				<a id="featuredNavRight" title="produitsSup" href="/">Suivant</a>
			</div><!-- end of #navFeat -->
			<ul class="clearfix">
				<li class="first_item last_item_of_line">
					<img class ="imgTopp" src="modules/slidermagasin/images/1.jpg"/>
				</li>
				<li class="item last_item_of_line">
					<img class ="imgTopp" src="modules/slidermagasin/images/2.jpg"/>
				</li>
				<li class="item last_item_of_line">
					<img class ="imgTopp" src="modules/slidermagasin/images/3.jpg"/>
				</li>
				<li class="item last_item_of_line">
					<img class ="imgTopp" src="modules/slidermagasin/images/4.jpg"/>
				</li>

				<li class="item last_item_of_line">
					<img class ="imgTopp" src="modules/slidermagasin/images/5.jpg"/>
				</li>
				<li class="item last_item_of_line">
					<img class ="imgTopp" src="modules/slidermagasin/images/6.jpg"/>
				</li>
				<li class="item last_item_of_line">
					<img class ="imgTopp" src="modules/slidermagasin/images/7.jpg"/>
				</li>
				<li class="item last_item_of_line">
					<img class ="imgTopp" src="modules/slidermagasin/images/8.jpg"/>
				</li>

				<li class="item last_item_of_line">
					<img class ="imgTopp" src="modules/slidermagasin/images/9.jpg"/>
				</li>
				<li class="item last_item_of_line">
					<img class ="imgTopp" src="modules/slidermagasin/images/10.jpg"/>
				</li>
				<li class="item last_item_of_line">
					<img class ="imgTopp" src="modules/slidermagasin/images/11.jpg"/>
				</li>
				<li class="last_item last_item_of_line">
					<img class ="imgTopp" src="modules/slidermagasin/images/12.jpg"/>
				</li>
			</ul>

		{literal}
			<script type="text/javascript" charset="utf-8">
			var $featuredP = $('#featuredP');
			$ul = $featuredP.find('ul');
			$featuredP.find('#navFeat').css('display','block').find('a').css('z-index',9999);
			$ul.css({'position':'relative','right':0});
			var anim = false;
			$featuredP.find('#featuredNavLeft').click(function() {
				$('#featuredNavRight').css('right','2px');
				if (anim){return false;}
				var currRight = parseInt($ul.css('right').split('px')[0]);
				if (currRight<=0) {return false};
				anim=true;
				$ul.animate({'right':currRight-$ul.find('li').outerWidth(true)+"px"},function() {
					anim=false;
				});
				return false;
			})
			$featuredP.find('#featuredNavRight').click(function() {
				$('#featuredNavLeft').css('left','12px');
				if (anim){return false;}
				var currRight = parseInt($ul.css('right').split('px')[0]);
				if (currRight>=$ul.find('li').outerWidth(true)*($ul.find('li').length-4)) {return false};
				anim=true;
				$ul.animate({'right':currRight+$ul.find('li').outerWidth(true)+"px"},function() {
					anim = false;
				});
				return false;
			})
			</script>
		{/literal}
</div>
<!-- /Block slidermagasin -->