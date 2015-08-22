$(document).ready(function(){
            $("div.volume").on('click',function(){
                $('.volumeControl').fadeToggle(100);
            });


           $(".main_frame").on('click','.songPlay_btn',function(){
                if ($(this).parents('.p_g_player_box').find('.updateProgress').hasClass('hide')){
                $(this).parents('.main_frame').find('.updateProgress').addClass('hide')    
                $(this).parents('.p_g_player_box').find('.updateProgress').removeClass('hide');
               } else {

                //$(this).parents('.p_g_player_box').find('.updateProgress').addClass('hide');
               }      
           });

             $(".main_frame").on('click','li',function(){

                // 取得這個頁面li 裡面的data-src  包成array
                //var dataSrc = $(this).parents.find('li').attr('data-src'); 
                // 取得這個頁面li 的數量
                // 根據數量幾個塞幾個li 進 index.html裡面
                // 塞li 各自的data-src 進 index.html裡面的 li
                // http://stackoverflow.com/questions/7055053/jquery-select-attributes-into-an-array
            
                // var dataSrc =  $(this).parent('.add_play_list');
                // var addPlayList = dataSrc.html();

                var parent_div = $(this).parent('.div_episode');
                var div_array = parent_div.nextAll("div.div_episode").andSelf();
                
                var li_array = [];
                for (i = 0; i < div_array.length; i++) {
                  li_array.push($(div_array[i]).find("li.li_episode"));
                }

                // for (i = 0; i < li_array.length; i++) {
                //   console.log(li_array[i]);
                // }


                $('#playListContainer>li').remove();
                // $('#playListContainer').append(addPlayList);
                // alert($('.main_frame').find('.add_play_list').html());
                // $('#playListContainer').append($('.main_frame').find('.add_play_list').html());

                for (i = 0; i < li_array.length; i++) {
                  li_array[i].clone().appendTo('#playListContainer');
                  // $('#playListContainer').append(li_array[i]);
                }
                
                $("#playListContainer").audioControls({
                autoPlay : false,
                timer: 'increment',
                buffer: false,
                onAudioChange : function(response){
                    $('.songPlay').text(response.title + ' ...');
                },
                onVolumeChange : function(vol){
                    var obj = $('.volume');
                    if(vol <= 0){
                        obj.attr('class','volume mute');
                    } else if(vol <= 33){
                        obj.attr('class','volume volume1');
                    } else if(vol > 33 && vol <= 66){
                        obj.attr('class','volume volume2');
                    } else if(vol > 66){
                        obj.attr('class','volume volume3');
                    } else {
                        obj.attr('class','volume volume1');
                    }
                }
            });

                 
           });

            $("#playListContainer").audioControls({
                autoPlay : false,
                timer: 'increment',
                buffer: false,
                onAudioChange : function(response){
                    $('.songPlay').text(response.title + ' ...');
                },
                onVolumeChange : function(vol){
                    var obj = $('.volume');
                    if(vol <= 0){
                        obj.attr('class','volume mute');
                    } else if(vol <= 33){
                        obj.attr('class','volume volume1');
                    } else if(vol > 33 && vol <= 66){
                        obj.attr('class','volume volume2');
                    } else if(vol > 66){
                        obj.attr('class','volume volume3');
                    } else {
                        obj.attr('class','volume volume1');
                    }
                }
            });
        });