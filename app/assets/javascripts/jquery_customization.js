$(document).on('ready page:load', function(){

	$("audio").on('canplay canplaythrough', function(){
    this.play();
    this.pause();
	});

});