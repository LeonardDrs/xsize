{literal}
<script type="text/javascript" charset="utf-8"/>
	function Zoom(e,t,i,$t) {
		
		var scrolly = (e.pageY-$t[0].y)*$t.height()/i.height();
		var scrollx = (e.pageX-$t[0].x)*$t.width()/i.width();
		i.css('margin-top',-scrolly)
		i.css('margin-left',-scrollx)

	};
	$(function(){
		$('#product_list figure a img').mouseenter(function(e) {
			$('.zoom_product').remove();
			var $this=$(this);
			$this.parent('a').attr('title','');
			var src=$this.data('largeurl');
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
					Zoom(e,$zthis,$zimg,$this);
				});
				var $zthis=$('.zoom_product');
				var $zimg=$zthis.children('img');
				// Zoom(e,$zthis,$zimg);
		});
	});
</script>
{/literal}