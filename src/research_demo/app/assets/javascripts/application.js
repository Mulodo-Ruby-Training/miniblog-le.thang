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
  function ajax_loading(){
    $("body").append('<div class="ajax-loading" ></div>')
    $(".ajax-loading").css({
      position: 'fixed',
      top: 0, 
      width: '100%',
      height: '100%',
      background: "silver url('/assets/ajax_loader_orange_48.gif') no-repeat 50% 50%",
      opacity: 0.6,
      cursor: 'wait'
    });
  }
  