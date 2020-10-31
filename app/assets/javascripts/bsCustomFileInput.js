bsCustomFileInput.init();
document.getElementById('inputFileReset').addEventListener('click', function() {
  var elem = document.getElementById('inputFile');
  elem.value = '';
  elem.dispatchEvent(new Event('change'));
});