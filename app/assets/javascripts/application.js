// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function(){
	$(document).on('click', '.artist-row', function(){
		var url = '/users/show';
		$.get(url, function(res){
			$('#sidebar').html(res);
		})
	})
	$(document).on('click', '.song-row', function(){
		var url = '/songs/show';
		$.get(url, function(res){
			$('#sidebar').html(res);
		})
	})
	$(document).on('click', '.popup-click', function(){
		action = $(this).attr('data-alt-src');
		$.get(action, function(res){
			$('#popup').html(res);
		})
		$('#popup').css("display", "block")
	})
	$(document).on('click', '.close', function(){
		$('#popup').css("display", "none")
	})
})