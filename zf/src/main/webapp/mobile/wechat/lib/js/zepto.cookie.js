(function(a){a.extend(a.fn,{cookie:function(b,c,d){var e,f,g,h;if(arguments.length>1&&String(c)!=="[object Object]"){d=a.extend({},d);if(c===null||c===undefined)d.expires=-1;return typeof d.expires=="number"&&(e=d.expires*24*60*60*1e3,f=d.expires=new Date,f.setTime(f.getTime()+e)),c=String(c),document.cookie=[encodeURIComponent(b),"=",d.raw?c:encodeURIComponent(c),d.expires?"; expires="+d.expires.toUTCString():"",d.path?"; path="+d.path:"",d.domain?"; domain="+d.domain:"",d.secure?"; secure":""].join("")}return d=c||{},h=d.raw?function(a){return a}:decodeURIComponent,(g=(new RegExp("(?:^|; )"+encodeURIComponent(b)+"=([^;]*)")).exec(document.cookie))?h(g[1]):null}})})(Zepto);