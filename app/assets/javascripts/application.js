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
		var url = '/users/show/'+$(this).attr('id');
		$.get(url, function(res){
			$('#sidebar').css("display", "inline-block")
			$('#sidebar').html(res);
		})
	})
	$(document).on('click', '.song-row', function(){
		var url = $(this).attr('data-alt-src');
		$.get(url, function(res){
			$('#sidebar').css("display", "inline-block")
			$('#sidebar').html(res);
		})
	})
	$(document).on('click', '.popup-click', function(){
		var action = $(this).attr('data-alt-src');
		$.get(action, function(res){
			$('#popup').html(res);
		})
		$('#popup').css("display", "block")
	})

	$(document).on('click', '.close', function(){
		$('#popup').css("display", "none")
	})
	$(document).on('submit', '.no-file', function(){
		var action = $(this).attr('action');
		if (action == "/register"){
			var phonum = $('#phone-1').val() + $('#phone-2').val() + $('#phone-3').val()
			$('#phone-number').val(phonum); 
		}
		$.post(action, $(this).serialize(), function(res){
			console.log(res);
			if (res == "exit"){
				$('#popup').css("display", "none");
			}else{
				$('#popup').html(res);
			}
		})
		return false;
	})
	$(document).on('click', '.play-btn', function(){
		url = "/songs/play_count/"+$(this).attr('data-alt-src');
		$.get(url);
		$('#play-src').attr('src', $(this).attr('id'));
		$('#audio').trigger("load");
		$('#audio').trigger("play");
	})
	$(document).on('click', '.show-to-edit', function(){
		var id = "#edit-" + $(this).attr('id'); 
		$(this).hide();
		$(id).show();
	})
	$(document).on('change', '.song-edit', function(){
		var url = "/songs/update/"+$(this).attr('data-alt-src')
		obj = {
			field: $(this).attr('data-alt-field'),
			value: $(this).val()
		}
		$.post(url, obj, function(res){
			$('#sidebar').html(res);
		})
	})
	$(document).on('change', '.top-search', function(){
		var search_input = $('#top-search-input').val();
		var genre_input = $('#top-search-genre').val();
		obj = {
			search: search_input,
			genre: genre_input
		}
		$.post("/songs/top_search", obj, function(res){
			$('#top-songs-div').html(res);
		})
		return false
	})
})