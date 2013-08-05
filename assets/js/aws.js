// JavaScript Document
function toggle(obj) {

	var el = document.getElementById(obj);

	el.style.display = (el.style.display != 'none' ? 'none' : '' );

}

function toggleCheckbox(obj) {

	var el = document.getElementById(obj);
if(el.checked){el.previousSibling.style.cssText='background-image:url(../img/check.png); background-position:left;';}else{el.previousSibling.style.cssText='border-right-color:#fff;border-right-style:solid;border-right-width:10px;';}


}