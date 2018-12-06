/**
 * sendmail hide & show
 */

function sendmail(hide,open,text){
	$(hide).hide();
	var a = '';
	a +='<div class="text-center"><img src="image/Loading.gif"></img><br>';
	a += text+'</div>';
	$(open).append(a);
	$(open).show();
}