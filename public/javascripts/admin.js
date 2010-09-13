
var nested_forms = new Array();

function replace_ids(s, name){
    var new_id = new Date().getTime();
    var to_rep = 'new_'+name+'';
    return s.replace(new RegExp(to_rep, "g"), new_id);
}

$(document).ready(function(){
    $('.add_nested_item').click(function(){
        var app = nested_forms[this.rel];
        app = replace_ids(app, this.rel);
        $('#'+this.rel+'s_fields').append(decodeURIComponent(app));
        if($(this).attr('data-callback')){
            eval($(this).attr('data-callback')+"(this);");
        }
        return false;
    });

});