// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults



(function($) {

    $(document).ready(function(){

        $('a.new_investment').live('click', function (e){
            var x = (jQuery('.specific_investment').filter(':first')).clone();
            x = x.html();
            var new_id = new Date().getTime();
            //TODO better handling; refactor
            var regexp = new RegExp("\\[0\\]", "g");
            var replaced  = x.replace(regexp, "["+new_id+"]");
            regexp = new RegExp("_0", "g");
            replaced  = replaced.replace(regexp, "_"+new_id+"_");
            regexp = new RegExp("display: none;", "g");
            replaced = replaced.replace(regexp, "");
            replaced = '<p class="specific_investment">' + replaced + '</p>'
            var el = jQuery(replaced);
            el.appendTo('#new_investments');
            jQuery('.specific_investment').filter(':last').find('input').attr('value', '');
            e.preventDefault();
        });

        $('.delete_investment').live('click', function (e){
            $(this).prev("input[type=hidden]").val("1");
            $(this).closest(".specific_investment").hide();
            return false;
        });

        //changing select to textfield for new banks
        $('select').live('change',function (e){
            v = $(this).val();
            if (v == "-1") {
                n = $(this).attr('name');
               $(this).replaceWith(jQuery('<input name="'+n+'" size="30" type="text">'));
            }
        });
    });
})(jQuery);

