$(document).ready(function(){
$('select#chainb_name').chainedTo('select#chaina_name');
$('select#chainc_name').chainedTo('select#chainb_name');
$('select#chainb_bath').chainedTo('select#chaina_name');
$('select#chainc_bath').chainedTo('select#chainb_bath');
$('select#chainb_price').chainedTo('select#chaina_name');
$('select#chainc_price').chainedTo('select#chainb_price');
$('select#chainb_buildup').chainedTo('select#chaina_uom');
$('select#chainc_buildup').chainedTo('select#chainb_buildup');
$('select#chainb_landarea').chainedTo('select#chaina_uom');
$('select#chainc_landarea').chainedTo('select#chainb_landarea');
});