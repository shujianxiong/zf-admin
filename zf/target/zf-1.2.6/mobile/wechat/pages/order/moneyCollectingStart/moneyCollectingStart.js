$(function() {
			$('.circle').each(function(index, el) {
				var num = $(this).find('span').text() * 3.6;
				if (num<=180) {
					$(this).find('.right').css('transform', "rotate(" + num + "deg)");
				} else {
					$(this).find('.right').css('transform', "rotate(180deg)");
					$(this).find('.left').css('transform', "rotate(" + (num - 180) + "deg)");
				};
			});

		});