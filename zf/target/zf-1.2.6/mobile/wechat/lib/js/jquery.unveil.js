/**
 * jQuery Unveil
 * A very lightweight jQuery plugin to lazy load images
 * http://luis-almeida.github.com/unveil
 *
 * Licensed under the MIT license.
 * Copyright 2013 Luís Almeida
 * https://github.com/luis-almeida
 */

;(function($) {

  $.fn.unveil = function(wrapper,threshold, callback) {
    //var $w = $(window),
	  var $w = wrapper,
        th = threshold || 0,
        retina = window.devicePixelRatio > 1,
        attrib = retina? "data-src-retina" : "data-src",
        images = this,
        loaded;
    this.one("unveil", function() {
      var source = this.getAttribute(attrib);
      source = source || this.getAttribute("data-src");
      if (source) {
    	$(this).attr("src",source);
  		$(this).attr("data-type","");
  		$(this).attr("opacity",0);
    	$(this).bind("load",function(){
    		$(this).fadeIn();
    		//console.log("加载完成")
    	});
    	$(this).bind("error",function(){
    		console.log("图片不存在")
    	    this.setAttribute("src", ctxMobile+"/img/notimg.png");
    	});
        if (typeof callback === "function") callback.call(this);
      }
    });

    function unveil() {
      var inview = images.filter(function() {
        var $e = $(this);
        if ($e.is(":hidden")) return;
        
        /*var wt = $w.scrollTop(),
            wb = wt + $w.height(),
            et = $e.offset().top,
            eb = et + $e.height();*/
        var et = $e.offset().top,
            eb = et + $e.height(),
            windowHeight=$(window).height();
        //return eb >= wt - th && et <= wb + th;
        return et <= windowHeight - th;
      });

      loaded = inview.trigger("unveil");
      images = images.not(loaded);
    }
    if($w!=null)
    	$w.on("scroll", unveil);

    unveil();

    return this;

  };

})(window.jQuery || window.Zepto);
