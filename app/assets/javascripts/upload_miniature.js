
 // Change Default Label Of Input Type="File" Button Element 


$(document).ready(function(){

  $("#myFileButton").on("click", function() {
    $('#myFileInput').trigger('click');
  });


  var preview = $(".upload-preview img");

  $(".file").change(function(event){
     var input = $(event.currentTarget);
     var file = input[0].files[0];
     var reader = new FileReader();
     reader.onload = function(e){
         image_base64 = e.target.result;
         preview.attr("src", image_base64);
     };
     reader.readAsDataURL(file);
  });
});

