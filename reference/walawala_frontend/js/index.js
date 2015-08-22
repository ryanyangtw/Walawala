// JavaScript Document
(function ($){

    $.fn.MainDataInIt = function () {
        $.Body.DefineIndexOf();
        $.Body.DefineLen();
        $.Body.EventInIt();
        $.Body.HashControl();
    }
    $.fn.DefineLen = function () {
        String.prototype.len = function(){ return this.replace(/[^\x00-\xff]/g,"rr").length; }
    }
    $.fn.DefineIndexOf = function () {
        if (!Array.prototype.indexOf) {
            Array.prototype.indexOf = function (elt /*, from*/) {
                var len = this.length >>> 0;

                var from = Number(arguments[1]) || 0;
                from = (from < 0)
                     ? Math.ceil(from)
                     : Math.floor(from);
                if (from < 0)
                    from += len;

                for (; from < len; from++) {
                    if (from in this &&
                        this[from] === elt)
                        return from;
                }
                return -1;
            };
        }
    }
    $.fn.ResizeInIt = function () {
        var b_h = 0;
        function resizing () {
            b_h = $.Body.height();
            $.main_frame.css({'height': (b_h)+'px'});
        }
        $.Window.bind('resize',resizing).trigger('resize');
    }
    $.fn.HashControl = function () {
        var fadeTime = 500;
        $.Window.bind(
            'hashchange',
            function () {
                $.loading.show();
                $.main_frame.html('');
                switch(window.location.hash){
                    case "#home":
                        $.Body.find('.user_account_not_login').addClass('hide');
                        $.Body.find('.user_account').removeClass('hide');
                        $.Body.find('.main').removeClass().addClass('main absolute');    
                        $.main_frame.load('home_logged.html',function(){
                            $.loading.fadeOut(fadeTime);
                        });
                    break;
                    case "#upload":
                        $.Body.find('.main').removeClass().addClass('purple main absolute');
                        $.Body.find('.main_frame').css("top","53px").removeClass().addClass('relative purple_frame main_frame');
                        $.main_frame.load('upload.html',function(){
                            $.loading.fadeOut(fadeTime);

                        });
                    break;
                    case "#category":
                        $.Body.find('.main_frame').css("top","53px").removeClass().addClass('relative  main_frame');
                        $.Body.find('.main').removeClass().addClass('main absolute');
                        $.main_frame.load('category.html',function(){
                            $.loading.fadeOut(fadeTime);
                        });
                    break;
                    case "#add":
                        $.Body.find('.main_frame').css("top","53px").removeClass().addClass('relative purple_frame main_frame');
                        $.Body.find('.main').removeClass().addClass('purple main absolute');
                        $.main_frame.load('add.html',function(){
                            $.loading.fadeOut(fadeTime);
                        });
                    break;
                    // case "#edit":

                        // $.main_frame.load('edit.html',function(){
                            // $.loading.fadeOut(fadeTime);
                        // });
                    break;
                    case "#program":
                        $.Body.find('.main_frame ').css("top","53px").removeClass().addClass('relative  main_frame');
                        $.Body.find('.main').removeClass().addClass('main absolute');

                        $.main_frame.load('program.html',function(){
                            $.loading.fadeOut(fadeTime);
                        });
                    break;
                    case "#cate1":
                        $.Body.find('.main_frame ').css("top","53px").removeClass().addClass('relative  main_frame');
                        $.Body.find('.main').removeClass().addClass('main absolute');
                        $.main_frame.load('cate1.html',function(){
                            $.loading.fadeOut(fadeTime);
                        });
                    break;
                    case "#login":
                        $.Body.find('.main_frame ').css("top","53px").removeClass().addClass('relative green_frame main_frame');
                        $.Body.find('.main').removeClass().addClass('green main absolute');
                        $.main_frame.load('login.html',function(){
                            $.loading.fadeOut(fadeTime);
                        });
                    break;
                    case "#upload_program":
                        $.Body.find('.main_frame ').css("top","53px").removeClass().addClass('relative purple_frame main_frame');
                        $.Body.find('.main').removeClass().addClass('purple main absolute');
                        $.main_frame.load('upload_program.html',function(){
                            $.loading.fadeOut(fadeTime);
                        });
                    break;
                    case "#edit_program":
                        $.Body.find('.main_frame ').css("top","53px").removeClass().addClass('relative purple_frame main_frame');
                        $.Body.find('.main').removeClass().addClass('purple main absolute');
                        $.main_frame.load('edit_program.html',function(){
                            $.loading.fadeOut(fadeTime);
                        });
                    break;
                    case "#upload_episode":
                        $.Body.find('.main_frame ').css("top","53px").removeClass().addClass('relative purple_frame main_frame');
                        $.Body.find('.main').removeClass().addClass('purple main absolute');
                        $.main_frame.load('upload_episode.html',function(){
                            $.loading.fadeOut(fadeTime);
                        });
                    break;
                    case "#edit_episode":
                        $.Body.find('.main_frame ').css("top","53px").removeClass().addClass('relative purple_frame main_frame');
                        $.Body.find('.main').removeClass().addClass('purple main absolute');
                        $.main_frame.load('edit_episode.html',function(){
                            $.loading.fadeOut(fadeTime);
                        });
                    break;
                    case "#search":
                        $.Body.find('.main_frame ').css("top","53px").removeClass().addClass('relative red_frame main_frame');
                        $.Body.find('.main').removeClass().addClass('red main absolute');
                        $.main_frame.load('search.html',function(){
                            $.loading.fadeOut(fadeTime);
                        });
                    break;
                    case "#setting":
                        $.Body.find('.main_frame ').css("top","53px").removeClass().addClass('relative green_frame main_frame');
                        $.Body.find('.main').removeClass().addClass('green main absolute');
                        $.main_frame.load('setting.html',function(){
                            $.loading.fadeOut(fadeTime);
                        });
                    break;
                    case "#sign_up":
                        $.Body.find('.main_frame ').css("top","53px").removeClass().addClass('relative green_frame main_frame');
                        $.Body.find('.main').removeClass().addClass('green main absolute');
                        $.main_frame.load('sign_up.html',function(){
                            $.loading.fadeOut(fadeTime);
                        });
                    break;
                    case "#reset_password":
                        $.Body.find('.main_frame ').css("top","53px").removeClass().addClass('relative green_frame main_frame');
                        $.Body.find('.main').removeClass().addClass('green main absolute');    
                        $.main_frame.load('reset_password.html',function(){
                            $.loading.fadeOut(fadeTime);
                        });
                    break;
                    case "#new_password":
                        $.Body.find('.main_frame ').css("top","53px").removeClass().addClass('relative green_frame main_frame');
                        $.Body.find('.main').removeClass().addClass('green main absolute');
                        $.main_frame.load('new_password.html',function(){
                            $.loading.fadeOut(fadeTime);
                        });
                    break;
                    case "#email_hint":
                        $.Body.find('.main_frame ').css("top","53px").removeClass().addClass('relative green_frame main_frame');
                        $.Body.find('.main').removeClass().addClass('green main absolute');
                        $.main_frame.load('email_hint.html',function(){
                            $.loading.fadeOut(fadeTime);
                        });
                    break;
                    case "#password_hint":
                        $.Body.find('.main_frame ').css("top","53px").removeClass().addClass('relative green_frame main_frame');
                        $.Body.find('.main').removeClass().addClass('green main absolute');
                        $.main_frame.load('password_hint.html',function(){
                            $.loading.fadeOut(fadeTime);
                        });
                    break;
                    default:
                        // $.Body.find('.main').removeClass().addClass('unlogged main absolute');
                        // $.Body.find('.main_frame').css("top","0px");
                        // $.main_frame.load('home_unlogged.html',function(){
                        //     $.loading.fadeOut(fadeTime);
                        // });
                        /*$.main_frame.load('home.html',function(){
                            $.loading.fadeOut(fadeTime);
                        });*/
                }
            }
        ).trigger('hashchange');
    }
    $.fn.EventInIt = function () {
        $.Body.PlayerInIt();
        $.Body.find('li.main_search').click(
            function(){
                $(this).addClass('active_search');
            }
        );
        $.Body.find('.main_search_btn').click(
            function(){
                window.location.hash = "#search";
            }
        );
        $.Body.find('.user_account').click(
            function(){
                if($(this).hasClass('user_account_in')){
                    $.login_menu.fadeIn(100);
                }
            }
        );
        /*$.Body.click(
            function(event){
                if($(event.target).parentsUntil($.Body,'.user_account').length==0){
                    $.login_menu.fadeOut(100);
                }
            }
        );*/
        $.login_menu.hover(
            function(){

            },
            function(){
                $.login_menu.fadeOut(100);
            }
        );
        $.main_frame.on('click','div.h_l_follow',function(){
            switch(true){
                case ($(this).parent().hasClass('to_f')):
                    $(this).parent().removeClass('to_f').addClass('cancel_f');
                break;
                case ($(this).parent().hasClass('cancel_f')):
                    $(this).parent().removeClass('cancel_f').addClass('to_f');
                break;
            }
            
        });


        $.main_frame.on('click','div.h_l_item_btn',function(){
            switch(true){
                case ($(this).parent().hasClass('state_0')):
                    $(this).parent().removeClass('state_0').addClass('state_1');
                break;
                case ($(this).parent().hasClass('state_1')):
                    $(this).parent().removeClass('state_1').addClass('state_0');
                break;
            }
        });
        $.main_frame.on('click','div.h_l_item_name',function(){
            $.h_l_pop.fadeIn(200);
        });
        $.Body.find('div.pop_box_bg,div.pop_close').click(
            function(){
                $(this).parentsUntil($.Body,'.pop_box').fadeOut(300);
            }
        );
        $.Body.find('div.h_l_pop_more').click(
            function(){
                $.h_l_pop.fadeOut(300);
            }
        );
        

        $.main_frame.on('click','div.cate_item',function(){
            window.location.hash = 'cate1';
        });
        
        $.main_frame.on('click','div.p_g_subscribe',function(){
            switch(true){
                case ($(this).hasClass('p_g_candisorder')):
                    $(this).removeClass('p_g_candisorder').addClass('p_g_canorder');
                    break;
                case ($(this).hasClass('p_g_canorder')):
                    $(this).removeClass('p_g_canorder').addClass('p_g_candisorder');
                    break;
            }
        });


        $.main_frame.on('click','div.p_g_more',function(){
            switch(true){
                case ($(this).parentsUntil($.main_frame,'.p_g_item').hasClass('p_g_more_active')):
                    $(this).parentsUntil($.main_frame,'.p_g_item').removeClass('p_g_more_active');
                    break;
                case (!$(this).parentsUntil($.main_frame,'.p_g_item').hasClass('p_g_more_active')):
                    $(this).parentsUntil($.main_frame,'.p_g_item').addClass('p_g_more_active');
                    break;
            }
        });
        $.main_frame.on('keydown','.p_g_reply_typecontent',function(e){
            if(e.keyCode == 13){
                e.preventDefault();
            }
        });
        /*
        $.main_frame.on('keyup','.p_g_reply_typecontent',function(e){
            if(e.keyCode == 13){
                if($(this).get(0).value !==''){
                    alert('send');
                }
            } else {
                $(this).css({'height': 19+'px'});
                if($(this).prop('scrollHeight') > 25 && $(this).prop('scrollHeight') <= 100){
                    $(this).css({'height': $(this).prop('scrollHeight')+'px','overflow':'hidden'});
                } else if($(this).prop('scrollHeight') > 100){ 
                    $(this).css({'height': 100+'px','overflow-y':'scroll'});
                } 
            }
        });*/
        $.main_frame.on('focus','.p_g_reply_typecontent',function(e){
            if($(this).get(0).value == '留言......') {
                $(this).get(0).value = '';
                $(this).css({'color':'#666666'});
            }
        });
        
        $.main_frame.on('blur','.p_g_reply_typecontent',function(e){
            if($(this).get(0).value == '') {
                $(this).get(0).value = '留言......';
                $(this).css({'color':'#999999'});
            }
        });
        $.main_frame.on('click','.p_g_reply_submit',function(e){
            alert('留言');
        });

        $.main_frame.on('click','.p_g_share',function(e){
            alert('分享');
        });
        $.main_frame.on('click','div.s_follow',function(){
            if($(this).parentsUntil($.Body,'.search_item').hasClass('s_followed')){
                $(this).parentsUntil($.Body,'.search_item').removeClass('s_followed');
            } else {
                $(this).parentsUntil($.Body,'.search_item').addClass('s_followed');
            }
        });

        $.main_frame.on('click','div.s_c_i_follow',function(){
            if($(this).parentsUntil($.Body,'.s_c_i').hasClass('s_c_i_followed')){
                $(this).parentsUntil($.Body,'.s_c_i').removeClass('s_c_i_followed');
            } else {
                $(this).parentsUntil($.Body,'.s_c_i').addClass('s_c_i_followed');
            }
        });
        $.main_frame.on('click','div.setting_passord_btn',function(){
            $.c_p_pop.fadeIn(200);
        });
        $.main_frame.on('click','div.c_p_submit',function(){
            alert('更改成功！！');
            $.c_p_pop.fadeOut(200);
        });
        $.main_frame.on('click','div.r_p_btn',function(){
            alert('送出！！');
        });
        $.main_frame.on('click','div.h_l_share',function(){
            alert('分享??');
        });
        $.main_frame.on('click','div.e_p_delete',function(){
            alert('刪除??');
        });
        $.main_frame.on('click','div.e_p_complete',function(){
            alert('完成??');
        });
        $.main_frame.on('click','div.e_p_complete_go',function(){
            alert('完成，前往上傳集??');
        });
        $.main_frame.on('click','div.e_e_complete',function(){
            alert('上傳新ㄧ集，完成');
        });
        $.main_frame.on('click','div.u_p_complete',function(){
            alert('建立新節目，完成');
        });
        $.main_frame.on('click','div.u_p_complete_go',function(){
            alert('建立新節目，完成，前往上傳集');
        });
        $.main_frame.on('click','div.l_fb',function(){
            alert('facebook 登入');
        });
        $.main_frame.on('click','div.l_submit',function(){
            alert('登入');
        });
        $.main_frame.on('click','div.s_u_submit',function(){
            alert('註冊');
            /*
             $.ajax({
                url: URLs,
                data: $('#sentToBack').serialize(),
                type:"POST",
                dataType:'text',

                success: function(msg){
                    alert(msg);
                },

                 error:function(xhr, ajaxOptions, thrownError){ 
                    alert(xhr.status); 
                    alert(thrownError); 
                 }
            });*/
        });
        $.main_frame.on('click','div.u_episode_unit_more',function(){
            alert('展開20集!!');
            for(var i = 0; i < 20; i ++) {
                $(this).parentsUntil($.Body,'.u_unit').find('.u_edit_box').append('<a href="#edit_episode"><div class="u_episode_unit"><div class="u_episode_unit_"><img src="images/upload/u_episode_unit.png"/> 1.集名稱 episode title<div class="u_episode_unit_time">2014/02/03</div><div class="u_episode_word">修改此集</div></div></div></a>');
            }
        });
    }
    $.fn.PlayerInIt = function () {
        $.playing_btn = $.Body.find('div.playing_btn');
        $.main_player = $.Body.find('div.main_player');
        $.time_bar = $.Body.find('div.time_bar');
        $.time_line = $.Body.find('div.time_line');
        $.time_line_bar = $.Body.find('div.time_line_bar');
        $.volume_sec = $.Body.find('div.volume_sec');
        $.volume_btn = $.Body.find('div.volume_btn');
        $.volumn_drag_body = $.Body.find('div.volume_drag_body');
        $.volumn_color = $.Body.find('div.volume_color');
        $.player_info_name = $.Body.find('div.player_info_name');
        $.player_info_time = $.Body.find('div.player_info_time');



        function showMsg(msg)
        {
            var ww = $(document).width(),
                wh = $(document).height();
            var dmsg = $('#msg');
            dmsg.text(msg);
            dmsg.fadeIn(500,function(){
                $(this).fadeOut(1000);
            });
        }
        function  setMusicClass(song)
        {
            if(song!= null)
            {
                $.player_info_name.text(song.name);
                $.main_player.addClass('state_in_playing');  
            }
        }
        var Player = {
            audioObj: null,
            currentId: -1,
            playList:[],
            init:function () {
                var aObj = $("#player_audio");
                this.audioObj = aObj[0];
            },
            clearList:function(){
                this.playList.length = 0;
                this.currentId = -1;
            },
            add:function(name,url)
            {
                this.playList.push({'name':name,'url':url});
            },
            remove:function(name)
            {
                delete this.playList[name];
            },
            play:function(index)
            {
                var song = null;
                if( (song = this.playList[index]) != null )
                {
                    if(this.audioObj.readyState == 4 && this.currentId == index){
                        this.audioObj.play();
                    }
                    else 
                    {
                        this.currentId = index;
                        this.stop();
                        this.audioObj.src = song.url;
                        $(this.audioObj).bind('canplaythrough',function(){
                            this.play();
                        });
                    }
                }
                return song;
            },
            stop:function ()
            {
                this.audioObj.pause();
            },
            isEmptyPlayList:function () 
            {
                return this.playList.length == 0;
            },
            playStep:function(step)
            {
                if(this.isEmptyPlayList())
                {
                    return null;
                }
                if(this.currentId == null)
                {
                    return this.playList[0];
                }
                else 
                {
                    var id = this.currentId;
                    if(step == 1)
                    {
                        id=(id<this.playList.length-1)?id+1:0;
                    }
                    else if (step == -1)
                    {
                        id=(id>0)?id-1:this.playList.length-1;
                    }
                    return this.play(id);
                }
            },
            playNext:function ()
            {
                return this.playStep(1);
            },
            playPri:function ()
            {
                return this.playStep(-1);
            }
        }


        Player.add('蘇打綠 sodagreen -【無眠】','sodagreen.mp3');
        if(!Player.isEmptyPlayList())
        {
            Player.currentId = 0;
        }
        bindPlayer();
        Player.audioObj.volume = 0.5;
        bindPlayerError();
        bindProgress();

        $.volume_btn.click(
            function(e){ 
                e.stopPropagation();
                $.volume_sec.toggleClass('volume_active');
            }
        );
        $.Body.click(
            function(){
                $.volume_sec.removeClass('volume_active');
            }
        );
        $.volumn_drag_body.draggable(
            { 
                start:  function() { dragToDataStart() }, 
                drag:   function() { dragToDataNow() }, 
                stop:   function() { dragToDataEnd() }, 
                containment: "parent",
                axis: "y"
            }
        );
        function dragToDataStart () {

        }
        function dragToDataNow () {
            $.volumn_color.css({'height': (34-parseInt($.volumn_drag_body.css('top')))+'px'});
            Player.audioObj.volume = (34-parseInt($.volumn_drag_body.css('top')))/34;
        }
        function dragToDataEnd () {
            
        }
        function playMusic (index)
        {
            var song = Player.play(index);
            setMusicClass(song);
            showMsg(song.name);
        }
        function pause()
        {
            Player.stop();
            $.main_player.removeClass('state_in_playing');
        }
        function stop()
        {
            //Player.audioObj.currentTime = 0;
            Player.stop();
            $.main_player.removeClass('state_in_playing');
        }
        function bindPlayerError()
        {
            var audio = $(Player.audioObj);
            var errMsg = ['資料讀取失敗','網路故障','解碼失敗','不支援的格式'];
            audio.bind('error',function(){
                showMsg(errMsg[this.error.code-1]);
            });
        }
        function bindProgress()
        {
            var audio = $(Player.audioObj);
            $.time_bar.bind('mousedown',function(e){
                var srcEle = e.target;
                e.preventDefault();
                if(srcEle.id=='time_line_bar')
                {
                    var x = e.pageX;
                    var pX = $.time_line_bar.position().left;
                    var pWidth = $.time_bar.width();
                    $(document).bind('mousemove',function(e){
                        if(!audio[0].paused)
                        {
                            e.preventDefault();
                            var xOff = e.pageX-x;
                            var nX = (pX+xOff);
                            nX = (nX<=0)?0:nX;
                            if(nX>=pWidth)
                            {
                                whenEnd();
                            }
                            else
                            {
                                $.time_line.css({'width': nX});
                                audio[0].currentTime = audio[0].duration*(nX/pWidth);
                            }
                        }
                    });
                    $(document).bind('mouseup mouseleave',function(e){
                        $(document).unbind('mousemove');
                    });
                } 
                else if(srcEle.id=='player_info_filter')
                {   
                    if(Player.audioObj.paused)
                    {
                    } 
                    else 
                    {
                        var x = e.pageX;
                        var pX = $.time_line_bar.position().left;
                        var pWidth = $.time_bar.width();
                        var xOff = e.pageX-($.time_line_bar.offset().left+10);
                        var nX = (pX+xOff);
                        nX = (nX<=0)?0:nX;
                        nX = (nX>pWidth)?pWidth:nX;
                        $.time_line.css({'width': nX});
                        audio[0].currentTime = audio[0].duration*(nX/pWidth);
                    }
                }
            });
            audio.bind('timeupdate',function(){
                var cTime = this.currentTime, tTime = this.duration;
                setCurrTime(cTime,tTime);
            });
            audio.bind('ended',whenEnd);
            function whenEnd () 
            {   
                var tTime = audio[0].duration;
                stop();
                setCurrTime(0,tTime);
            }
        }
        function setCurrTime(cTime,tTime)
        {
            var per = (tTime<=0)?0:cTime/tTime;
            var pPos = $.time_bar.width()*per;
            $.time_line_bar.css({'left':pPos});
            $.time_line.width(pPos);
            var h = '',
                m = '',
                s = '';
            h = Math.floor(cTime/3600);
            m = Math.floor( (cTime%3600)/60);
            s = Math.floor(cTime%60);
            if(h<10)
            {
                h='0'+h;
            }
            else if (h>60)
            {
                h='00';
            }
            if(m<10)
            {
                m='0'+m;
            }
            if(s<10)
            {
                s='0'+s;
            }
            $.player_info_time.html( h+':'+m+':'+s );
        }
        function bindPlayer()
        {
            Player.init();
            $.playing_btn.click(
                function(){
                    if(Player.isEmptyPlayList())
                    {
                        showMsg("請新增歌曲");
                        return;
                    }
                    if(Player.audioObj.paused)
                    {
                        playMusic(Player.currentId);
                    }
                    else
                    {
                        pause();
                    }
                }
            );
            /*
            $('#next').click(function(){
                var song = Player.playNext();
                setMusicClass(song);
            });
            $('#pri').click(function(){
                var song = Player.playPri();
                setMusicClass(song);
            });
            */
        }
    }
    $.fn.ComCss = function (property) {
        var _self = $(this);
            _self['propObj'] = {};
        for(x in property){ 
            _self.propObj['-webkit-'+x] = property[x];
            _self.propObj['-moz-'+x] = property[x];
            _self.propObj['-ms-'+x] = property[x];
            _self.propObj[x] = property[x];
        }
        _self.css(_self.propObj);
        /*for(x in _self.propObj){ 
            delete _self.propObj[x];
        }*/
        delete _self.propObj;
        property = null;
        _self = null;      
    }
})(jQuery);
	
$(function(){
	$.Body =$('body');	
	$.Window = $(window);
    $.loading = $.Body.find('div.loading');
    $.main_frame = $.Body.find('div.main_frame');
    $.h_l_pop = $.Body.find('div.h_l_pop');
    $.c_p_pop = $.Body.find('div.c_p_pop');
    $.login_menu = $.Body.find('.login_menu');
    $.Body.ResizeInIt();
    $.Body.MainDataInIt();
});





