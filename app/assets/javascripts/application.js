// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require jquery.cookie
//= require jquery-fileupload
//= require jquery.numeric.rjo
//= require jquery.maskedinput.min
//= require nested_form
//= require bootstrap 
//= require bootstrap-select.min
//= require bootstrap-confirm-dialog


//= require moment
//= require moment/pt-br
//= require bootstrap-datetimepicker
//= require pickers

//------------------------------------ MASCARA QTD  ------------------------------------------------------
function mascararQtd(_qtd) { // $(".qtd").maskMoney({thousands:'', decimal:'.', precision: 3});
    _qtd.numeric();
}


