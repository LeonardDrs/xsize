{literal}
<script type="text/javascript" charset="utf-8"/>
	function Zoom(e,t,i,$t) {
		var scrolly = ((e.pageY-$t[0].y)*(i.height()-$t.width())/$t.height());
		var scrollx = ((e.pageX-$t[0].x)*(i.width()-$t.width())/$t.width());
		i.css('margin-top',-scrolly)
		i.css('margin-left',-scrollx)

	};
	$(function(){
		$('body').on('mouseenter', '#product_list figure a img', function(e) {
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
				.css({overflow:'hidden',position:'absolute',top:0,left:20,cursor:'pointer',border:'2.5px solid #eeeded'})
				.click(function() {
					window.location.href = $(this).siblings('a').attr('href');
				})
				.append('<img src="'+src+'" alt="'+alt+'" />')
				.mousemove(function(e) {
					Zoom(e,$zthis,$zimg,$this);
				});
				var $zthis=$('.zoom_product');
				var $zimg=$zthis.children('img');
		});
		$('body').on('mouseleave','.zoom_product',function() {
			$('.zoom_product').remove();
		})
	});
</script>
{/literal}