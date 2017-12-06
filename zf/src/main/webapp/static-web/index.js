/**
 * Created by 项磊 on 2016/7/22.
 */
var setREM = function(){
    var width = $(window).width(), rem;
    if(width >= 768){
        rem = width/50;
    }else{
        rem = width/10;
    }
    $('html').css('font-size', rem + 'px');
};
setREM();
window.addEventListener('load', function(){
    $('.ui-btn').on('tap, click', function(){
        //window.open('inConstruction/inConstruction.html');
        window.location.href = 'inConstruction/inConstruction.html';
    });
});
window.onresize=function(){
    setREM();
};