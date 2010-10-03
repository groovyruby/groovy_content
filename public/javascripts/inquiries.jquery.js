$(document).ready(function(){
	$('.inquiry_form_placeholder').each(function(idx, elem){
		var elem_id = $(elem).attr('id');
		var form_name = $(elem).attr('data-form');
		if(!form_name) form_name = $(elem).text();
		var url = "/inquiries/new?form="+form_name;
		$(elem).load(url, function(){
			$('form.inquiry_'+form_name).ajaxForm({
				clearForm: true,
				success: function(){
					alert('Dziękujemy za przesłanie formularza!');
				}
			});
			return true;
		});
	});
});