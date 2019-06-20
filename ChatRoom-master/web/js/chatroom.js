/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var layer=layer;
$(function(){
    var promt=$("#none").text();
    var first=$("#none2").text();
    var change_feedback=$("#none3").text();
    if(first==="1"){
        layer.msg(promt, {
            area: ['280px','50px']
        });
    }else if(change_feedback!=="" && change_feedback!=="null"){
        layer.msg(change_feedback, {
            area: ['280px','50px']
        });
    };
    var send_btn=$("#send_meg");
    var my_meg_input=$("textarea");
    send_btn.click(function(){
        if(my_meg_input.val()===""){
            layer.msg('消息不能为空哦', {icon: 5});
        }
    });
    function enter_sub(){//回车发送消息
        my_meg_input.keydown(function(e){
            if (e.keyCode===13){
                send_btn.click();
                return false;
            }
        });
    };
    enter_sub();//默认聚焦触发
    my_meg_input.focus(enter_sub());
//    在线成员设置随机头像
    var head_urls=['./js/theme/default/head_1.png', './js/theme/default/head_2.png', './js/theme/default/head_3.png', './js/theme/default/head_4.png','./js/theme/default/head_5.png'];
    var member_lis=$(".member_li");
    for(var i=0;i<member_lis.length;i++){
        var head_url_num = Math.floor(Math.random() * 4);
        var url_temp=head_urls[head_url_num];
        if(member_lis.eq(i).css("background-image")==="none"){
            member_lis.eq(i).css("background-image","url("+url_temp+")");
        }
    }
    var ModalEffects = (function() {//弹出框
        function init() {
            var overlay = $('.md-overlay');
            var close=$(".md-close");
            $('.md-trigger' ).click(function() {
                var modal_num=$(this).attr( 'data-modal' );
                var modal = $('#'+modal_num);
                function removeModal() {
                    modal.removeClass('md-show');
                }
                modal.addClass('md-show');
                overlay.click(function () {
                    removeModal();
                });
                close.click(function() {
                    removeModal();
                });
            });
        };
        init();
    })();
});