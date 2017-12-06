/**
 * Zepto picLazyLoad Plugin
 * 图片延迟加载 http://ons.me/484.html
 * 20140517 v1.0
 */

;(function($){
    $.fn.picLazyLoad = function(settings){
        var $this = $(this),
            _winScrollTop = 0,
            _winHeight = $(window).height();

        settings = $.extend({
            threshold: 0, // 鎻愬墠楂樺害鍔犺浇
            placeholder: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC'
        }, settings||{});

        // 鎵ц鎳掑姞杞藉浘鐗�
        lazyLoadPic();

        // 婊氬姩瑙﹀彂鎹㈠浘
        $(window).on('scroll',function(){
            _winScrollTop = $(window).scrollTop();
            lazyLoadPic();
        });

        // 鎳掑姞杞藉浘鐗�
        function lazyLoadPic(){
            $this.each(function(){
                var $self = $(this);
                // 濡傛灉鏄痠mg
                if($self.is('img')){
                    if($self.attr('data-original')){
                        var _offsetTop = $self.offset().top;
                        if((_offsetTop - settings.threshold) <= (_winHeight + _winScrollTop)){
                            $self.attr('src',$self.attr('data-original'));
                            $self.removeAttr('data-original');
                        }
                    }
                // 濡傛灉鏄儗鏅浘
                }else{
                    if($self.attr('data-original')){
                        // 榛樿鍗犱綅鍥剧墖
                        if($self.css('background-image') == 'none'){
                            $self.css('background-image','url('+settings.placeholder+')');
                        }
                        var _offsetTop = $self.offset().top;
                        if((_offsetTop - settings.threshold) <= (_winHeight + _winScrollTop)){
                            $self.css('background-image','url('+$self.attr('data-original')+')');
                            $self.removeAttr('data-original');
                        }
                    }
                }
            });
        }
    }
})(Zepto);