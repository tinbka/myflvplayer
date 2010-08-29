var Extensions = ['flv', 'wmv', 'avi', 'mp4', 'mov', 'mkv', 'mpg'];

function check_extension(event)
{
  [_, ext] = $('#file').val().match(/\.([\w\d]+)$/);
  $('#name2').val(name);
  if (!ext || !find(Extensions, function(i) {return i==ext}))
  {
    event.preventDefault();
    $('#error').text("Incorrect file extension: "+ext+". Must be one of "+Extensions.join(', ')+'.').show();
  }
}

function find(obj, fun)
{
  var res = null;
  $.each(obj, function(i) {if (fun(obj[i])) {res = obj[i]; return}});
  return res;
}
