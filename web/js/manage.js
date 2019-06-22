/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var layer=layer;
$(function(){
    var form=$(".md-content form");
    var userid_inp=$("#userid");
    var username_inp=$("#username");
    var userpass_inp=$("#userpass");
    var ModalEffects = (function() {//弹出框
        function init() {
            var overlay = $('.md-overlay');
            var close=$(".md-close");
            var h3=$(".md-content h3");
            $('.md-trigger' ).click(function() {
                var modal_num=$(this).attr( 'data-modal' );
                var modal = $('#'+modal_num);
                var option=$(this).attr( 'option' );
                var userid=$(this).attr( 'user-id' );
                var username=$(this).attr( 'user-name' );
                var userpass=$(this).attr( 'user-pass' );
                if(option==="modify"){
                    $("#userid_wrap").css('display','none');
                    //动态更改弹出框的标题和form的接受文件
                    h3.text("修改用户信息");
                    form.attr("action",'changeUser.jsp');
                    //自动填入信息
                    userid_inp.val(userid);
                    username_inp.val(username);
                    userpass_inp.val(userpass);
                }else if(option==="new"){
                    $("#userid_wrap").css('display','none');
                    h3.text("录入用户信息");
                    form.attr("action",'NewUser.jsp');
                    userid_inp.val("");
                    username_inp.val("");
                    userpass_inp.val("");
                }else{
                    $("#userid_wrap").css('display','block');
                    h3.text("多条件查询");
                    form.attr("action",'query.jsp');
                    userid_inp.val("");
                    username_inp.val("");
                    userpass_inp.val("");
                }
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
    form.submit(function(){
        var flag=true;
        if(userid_inp.val()==="" && username_inp.val()==="" && userpass_inp.val()===""){
            flag=false;
            layer.msg("不能全为空！", {
                area: ['280px'],
                offset: '50px'
            });
        }
        return flag;
    });
    var manage_op_feedback=$("#manage_op_feedback").text();
    if(manage_op_feedback!=="null" && manage_op_feedback!==""){
        layer.msg(manage_op_feedback, {
                area: ['280px','50px'],
                offset: '50px'
            });
    }
});