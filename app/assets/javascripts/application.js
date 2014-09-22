//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require moment
//= require moment/nb
//= require bootstrap-datetimepicker
//= require nprogress
//= require nprogress-turbolinks
//= require_self
NProgress.configure
  //showSpinner: false
  ease: 'ease'
  speed: 500

$().ready(function () {
    $('.date').datetimepicker({format: 'YYYY-MM-DD', pickTime: false});
    $('.datetime').datetimepicker({format: 'YYYY-MM-DD H.mm'});
});
