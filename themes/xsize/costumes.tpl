		<section id="content costumespage">
			<h1>{l s="COSTUMES"}</h1>
			<section class="page">

			</section>

			<!--<section class="page" id="costumezone">
				<section id="costumes">
					<img class="vert preview_inner" src="{$img_dir}/products/costumes/mec1.jpg" alt="mec1"/>
					<span class="loupe-j"></span>
					<img class="beige preview_inner" src="{$img_dir}/products/costumes/mec2.jpg" alt="mec2"/>
					<span class="loupe-r"></span>
					<img class="rouge preview_inner" src="{$img_dir}/products/costumes/mec3.jpg" alt="mec3"/>
					<span class="loupe-b"></span>
					<img class="bleu preview_inner" src="{$img_dir}/products/costumes/mec4.jpg" alt="mec4"/>
					<span class="loupe-v"></span>
				</section>
			</section>-->
			<div class="page" id="costumezone2">
				<div id="costumes2">
					<div class="column_left">
						<div>
							<div id="costume1">
								<img class="preview_inner1" src="{$img_dir}/products/costumes/mec1.jpg" alt="mec1"/>
							<span class="loupe-v"></span>
							</div>
						</div>
						<div>
							<div id="costume2">
								<img class="preview_inner2" src="{$img_dir}/products/costumes/mec2.jpg" alt="mec2"/>
								<span class="loupe-r"></span>
							</div>
						</div>
					</div>
					<div class="column_right">
							<div>
								<div id="costume3">
									<img class="preview_inner3" src="{$img_dir}/products/costumes/mec3.jpg" alt="mec3"/>
									<span class="loupe-j"></span>
								</div>
							</div>
							<div>
								<div id="costume4">
									<img class="preview_inner4" src="{$img_dir}/products/costumes/mec4.jpg" alt="mec4"/>
									<span class="loupe-b"></span>
								</div>
							</div>
					</div>
				</div>
			</div>

			<!--<div id="works" class="page">
				<div id="works_previews">
					<div id="works_previews_inner">
						<div class="column works_right first">
							<div class="preview top_preview">
								<div class="preview_inner">
									<img class="vert" src="{$img_dir}/products/costumes/mec1.jpg" alt="mec1">
									<span class="loupe-j"></span>
								</div>
							</div>
							<div class="preview bottom_preview">
								<div class="preview_inner">
									<img class="beige" src="{$img_dir}/products/costumes/mec2.jpg" alt="mec2">
									<span class="loupe-r"></span>
								</div>
							</div>
						</div>
						<div class="column works_left">
							<div class="preview top_preview">
								<div class="preview_inner">
									<img class="rouge" src="{$img_dir}/products/costumes/mec3.jpg" alt="mec3">
									<span class="loupe-b"></span>
								</div>
							</div>
							<div class="preview bottom_preview">
								<div class="preview_inner">
									<img class="bleu" src="{$img_dir}/products/costumes/mec4.jpg" alt="mec4">
									<span class="loupe-v"></span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>-->

		{$SLIDERCOSTUME}
<script type="text/javascript">
{literal}
$(document).ready(function() {

	$(".preview_inner1").live("click", function() { //Au clic sur un aperÃ§u
		if($(this).css("z-index")=="0") {
			$(this).css("z-index", "1").stop().animate({
				width: 440,
				height: 440,
				top: 0,
				left: 0
			}, 200, function() {
			});
		}
	});
	$(".preview_inner2").live("click", function() { //Au clic sur un aperÃ§u
		if($(this).css("z-index")=="0") {
			$(this).css("z-index", "1").stop().animate({
				width: 440,
				height: 440,
				bottom: 230,
				left: 0
			}, 200, function() {
			});
		}
	});
	$(".preview_inner3").live("click", function() { //Au clic sur un aperÃ§u
		if($(this).css("z-index")=="0") {
			$(this).css("z-index", "1").stop().animate({
				width: 440,
				height: 440,
				right: 230,
				top: 0
			}, 200, function() {
			});
		}
	});
	$(".preview_inner4").live("click", function() { //Au clic sur un aperÃ§u
		if($(this).css("z-index")=="0") {
			$(this).css("z-index", "1").stop().animate({
				width: 440,
				height: 440,
				bottom: 230,
				right: 230
			}, 200, function() {
			});
		}
	});

	//Diminution des aperÃ§u au clic
	$("html").click(function() {
		if($(".preview_inner1").css("z-index")=="1") {
				$(".preview_inner1").stop().animate({
					width: 210,
					height: 210,
					top: 0,
					left: 0,
				}, 200, function() {
					$(this).css("z-index", "0");
				});
		}
		if($(".preview_inner2").css("z-index")=="1") {
				$(".preview_inner2").stop().animate({
					width: 210,
					height: 210,
					bottom: 0,
					left: 0,
				}, 200, function() {
					$(this).css("z-index", "0");
				});
		}
		if($(".preview_inner3").css("z-index")=="1") {
				$(".preview_inner3").stop().animate({
					width: 210,
					height: 210,
					top: 0,
					right: 0,
				}, 200, function() {
					$(this).css("z-index", "0");
				});
		}
		if($(".preview_inner4").css("z-index")=="1") {
				$(".preview_inner4").stop().animate({
					width: 210,
					height: 210,
					bottom: 0,
					right: 0,
				}, 200, function() {
					$(this).css("z-index", "0");
				});
		}
	});

});
{/literal}
</script>