{literal}
<script type="text/javascript" charset="utf-8"/>
	function Zoom(e,t,i) {
		var scrolly = e.layerY*(i.height()/t.height()/2);
		var scrollx = e.layerX*(i.width()/t.width()/2);
		i.css('margin-top',-scrolly)
		i.css('margin-left',-scrollx)
	};
	$(function(){
		$('#product_list figure a img').mouseenter(function(e) {
			$('.zoom_product').remove();
			var $this=$(this);
			$this.parent('a').attr('title','');
			var src=$this.data('largeUrl');
			var alt=$this.attr('alt');
			var $a=$this.parent('a');
			$a.parents('figure').append("<div class='zoom_product'>").css('position','relative');
			$('.zoom_product')
				.height($this.height())
				.width($this.width())
				.css({overflow:'hidden',position:'absolute',top:2,left:23,cursor:'pointer'})
				.click(function() {
					window.location.href = $(this).siblings('a').attr('href');
				})
				.append('<img src="'+src+'" alt="'+alt+'" />')
				.mouseleave(function() {
					$('.zoom_product').remove()
				})
				.mousemove(function(e) {
					Zoom(e,$zthis,$zimg);
				});
				var $zthis=$('.zoom_product');
				var $zimg=$zthis.children('img');
				// Zoom(e,$zthis,$zimg);
		});
	});
</script>
{/literal}