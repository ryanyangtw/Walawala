$(function()
{
  $('input[type=file]').change( function()
  {
    var filename = $(this).val().split('/').pop().split('\\').pop();
    $('div.div_filename').html(filename);
  });
});
// $('input[type=file]').val().split('/').pop().split('\\').pop();