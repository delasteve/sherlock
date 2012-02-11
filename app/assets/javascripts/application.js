// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

var suffixes = ['B', 'kB', 'MB', 'GB', 'TB'];
function round(num, places) {
  var shift = Math.pow(10, places);
  return Math.round(num * shift)/shift;
};

function formatValue(v) {
  if (v < 1000)
    return v;

  var magnitude = Math.floor(String(Math.floor(v)).length / 3);
  if (magnitude > suffixes.length - 1)
    magnitude = suffixes.length - 1;
  return String(round(v / Math.pow(10, magnitude * 3), 2)) +
    suffixes[magnitude];
}

