$(document).on('ready page:load', function() {
$('.txt-box').keypress(function (e) {
  if (e.charCode != 0) {
    var regex = new RegExp("^[a-zA-Z0-9\\-\\s]+$");
    var key = String.fromCharCode(!e.charCode ? e.which : e.charCode);
    if (!regex.test(key)) {
      e.preventDefault();
      return false;
    }
  }
});
});
