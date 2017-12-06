function setShowBottomSize(){
	var ShowBottom =$(".minicast_content_pic_bottom")
	console.log(ShowBottom)
	var ShowBottomspan =ShowBottom.children("span")
	for(var i = 0; i<ShowBottomspan.length; i++){
		ShowBottomspan[i].style.height = ShowBottomspan[0].offsetWidth +'px';
		ShowBottomspan[i].style.lineHeight = ShowBottomspan[0].offsetWidth +'px';
	}
}

setShowBottomSize();