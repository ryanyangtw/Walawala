
$(document).ready(function(){
  $("div.pagination").find("a").attr("href", function( i, val ) {
    path_with_hash_tag = "#" + val;
    return path_with_hash_tag;
  });
});