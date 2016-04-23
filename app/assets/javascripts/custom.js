$(document).ready(function(){
$('select#region_name').chainedTo('select#place_name');
$('select#area_name').chainedTo('select#region_name');
});