/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var layer=layer;
// 验证码
var code;
var codeLength = 5; //验证码的长度
var checkCode = $(".code");
var codeChars = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 
'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'); //所有候选组成验证码的字符，当然也可以用中文的
var _code_color1 = ['#fffff0', '#f0ffff', '#f0fff0', '#fff0f0'];
var _code_color2 = ['#FF0033', '#006699', '#993366', '#FF9900', '#66CC66', '#FF33CC'];
function createCode() {
    code = "";
    var color1Num = Math.floor(Math.random() * 3);
    var color2Num = Math.floor(Math.random() * 5);
    for (var i = 0; i < codeLength; i++) 
    {
        var charNum = Math.floor(Math.random() * 62);
        code += codeChars[charNum];
    }
    checkCode.text(code);
    checkCode.css({'color':_code_color2[color2Num],'backgroundColor':_code_color1[color1Num]});
}
function validate(){
    var form=$(".login_form");
    var inputCode = $(".code_input");
    var flag=true;
    form.submit(function(){
        if (inputCode.val().toUpperCase() !== code.toUpperCase()) 
        {
            inputCode.val("");
            layer.msg('验证码不对哦！', {icon: 5});
            createCode();
            flag=false;
        }
        else 
        {
            flag=true;
        }
        return flag;
    });
}
$(function () {
    var nav_labels=$(".nav-slider label");
    var name_input=$(".name_input");
    var nav_slider_bar=$('.nav-slider-bar');
    var signin_misc=$(".signin-misc-wrapper");
    var login_feedback=$("#login_feedback").text();
    nav_labels.click(function () {
        $(this).addClass('active').siblings('label').removeClass('active');
        var le=($(this).index()-1)*3;
        nav_slider_bar.css({'left':le+'em'});
        if($(this).index()===3){
            name_input.attr("placeholder","管理员账号");
            signin_misc.fadeOut();
        }else{
            name_input.attr("placeholder","用户名");
            signin_misc.fadeIn();
        }
    });
    createCode();
    validate();
    checkCode.click(function(){
        createCode();
    });
    console.log(login_feedback);
    if(login_feedback==="" || login_feedback==="null"){
        login_feedback="密码默认是：123";
    }
    layer.msg(login_feedback, {
        area: ['280px'],
        offset: '50px'
    });
    
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