function add_fields(link, content) {
  $(link).parent().before(content);
  $('.edittable-label').click(edit_key);
}

function remove_field(link) {
  $(link).closest(".control-group").remove();
}

function edit_key() {
  var label = $(this).text();
  $(this).after( '<input id="label" name="label" style="width: 135px; float: left; padding-top: 5px;" type="text" value="' + label + '">' );
  $(this).hide();
  $(this).next().focusout( function() {
    var text = $(this).val();
    $(this).siblings('label').text( text );
    $(this).siblings('label').show();
    $(this).next().children('input').attr('name','tag[meta][' + text +']');
    $(this).next().children('input').attr('id','tag_meta_' + text );
    $(this).remove();
  })
  $(this).next().focus();
}

$(document).ready(function() {
  $('.edittable-label').click(edit_key);
})