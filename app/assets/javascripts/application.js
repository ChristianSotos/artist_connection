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
			$('#sidebar > div').fadeOut(500);
			setTimeout(function(){
					$('#sidebar').html(res);
			},500);
		})
	})
	$(document).on('click', '.song-row', function(){
		var url = $(this).attr('data-alt-src');
		$.get(url, function(res){
			$('#sidebar > div').fadeOut(500);
			setTimeout(function(){
					$('#sidebar').html(res);
			},500);
		})
	})
	$(document).on('click', '.popup-click', function(){
		var action = $(this).attr('data-alt-src');
		$.get(action, function(res){
			$('#popup').html(res);
		})
		$('#popup').css("display", "block")
	})
	$(document).on('click', '#back-btn', function(){
		var action = $(this).attr('data-alt-src');
		$.get(action, function(res){
			$('#popup > div').fadeOut(500);
			setTimeout(function(){
				$('#popup').html(res);
			}, 500);
		})
	})
	$(document).on('click', '.qty-btns', function(){
		var action = $(this).attr('data-alt-src');
		$.get(action, function(res){
			$('#popup > div').fadeOut(500);
			setTimeout(function(){
					$('#popup').html(res);
			},500);
		})
		$('#popup').css("display", "block")
	})

	$(document).on('click', '.close', function(){
		$('#popup').fadeOut();
	})
	$(document).on('submit', '.no-file', function(){
		var action = $(this).attr('action');
		if (action == "/register"){
			var phonum = $('#phone-input1').val() + $('#phone-input2').val() + $('#phone-input3').val()
			$('#phone-number').val(phonum); 
		}
		$.post(action, $(this).serialize(), function(res){
			$('#popup > div').fadeOut(500);
			setTimeout(function(){
					$('#popup').html(res);
			},500);
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
		if($(this).attr('id') == "full_name"){
			$(this).fadeOut(300);
			setTimeout(function(){
					$('#edit-first-name').fadeIn();
					$('#edit-last-name').fadeIn();
			},300);
		}
		var id = "#edit-" + $(this).attr('id'); 
		$(this).fadeOut(300);
			setTimeout(function(){
					$(id).fadeIn();
			},500);
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
	$(document).on('change', '.user-edit', function(){
		var url = "/users/update";
		obj = {
			field: $(this).attr('data-alt-field'),
			value: $(this).val()
		}
		$.post(url, obj, function(){
		})
	})
	$(document).on('change', '.top-search', function(){
		var search_input = $('#top-search-input').val();
		var genre_input = $('#top-search-genre').val();
		obj = {
			search: search_input,
			genre: genre_input,
			pagination: 0
		}
		$.post("/songs/top_search", obj, function(res){
			$('#top-songs-div').html(res);
		})
		return false
	})
	$(document).on('click', '.pagination', function(){
		var search_input = $('#top-search-input').val();
		var genre_input = $('#top-search-genre').val();
		var page = $(this).attr('data-alt-src') - 1
		obj = {
			search: search_input,
			genre: genre_input,
			pagination: page
		}
		$.post("/songs/top_search", obj, function(res){
			// $('#top-songs-div').toggle("slide", "left", 2000);
			$('#top-songs-div').html(res);
			// setTimeout(function(){
			// 	$('#top-songs-div').toggle("slide", "right", 2000);
			// }, 2000);
		})
		return false
	})
	$(document).on('click', '.user-pagination', function(){
		var page = $(this).attr('data-alt-src') - 1
		obj = {
			pagination: page
		}
		$.post("/songs/user_pagination", obj, function(res){
			$('#user-songs-div').html(res);
		})
		return false
	})
	$(document).on('mouseover', '.featured-images-div', function(){
		$(this).find('h4').fadeIn();
	})
	$(document).on('mouseout', '.featured-images-div', function(){
		$(this).find('h4').hide();
	})
	$(document).on('click', '.icon', function(){
		$('#MyTopnav').slideToggle();
	})

	$(document).on('click', '.ref-del', function(){
		action = $(this).attr('data-alt-src');
		$.get(action, function(res){
			$('#reference-div').html(res);
		})
	})
	$(document).on('click', '#add-ref-btn', function(){
		song_id = $(this).attr('data-alt-src')
		ref_id = $('#references-select').val()
		action = "/reference/add/"+song_id+"/"+ref_id
		$.get(action,function(res){
			$('#reference-div').html(res);
		})
	})
	$(document).on('submit', '#new-ref', function(){
		action = $(this).attr('action')
		$.post(action, $(this).serialize(), function(res){
			$('#reference-div').html(res);
		})
	})
	$(document).on('click', '#submit-review', function(){
		ay = $('#song-review-analysis').val();
		rat = $('#song-review-rating').val();
		obj = {
			analysis: ay,
			rating: rat
		}
		song_id = $(this).attr('data-alt-src');
		action = "/review/add/"+song_id;
		$.post(action, obj, function(){

		})
	})

	var clicked = false;

	$(document).on("click", ".star", function(){
			$(this).css("background-image", "url('/assets/goldstar.png')");
			for (var i=0; i<$(this).attr("data-alt"); i++) {
				$('#' + $(this).siblings()[i].id).css("background-image", "url('/assets/goldstar.png')");
			}
	})
	$(document).on('mouseenter', '.star', function(){
		for (var i=0; i<$(this).attr("data-alt"); i++) {
			$('#' + $(this).siblings()[i].id).css("background-image", "url('/assets/goldstar.png')");
		}
		$(this).css("background-image", "url('/assets/goldstar.png')");
	})
	// $(document).on('mouseleave', '.star', function(){
	// 	for (var i=0; i<$(this).attr("data-alt"); i++) {
	// 		$('#' + $(this).siblings()[i].id).css("background-image", "url('/assets/whitestar.png')");
	// 	}
	// 	$(this).css("background-image", "url('/assets/whitestar.png')");
	// })	
})