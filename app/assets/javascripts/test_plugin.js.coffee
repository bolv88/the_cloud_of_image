#plugin test, test html is in public/test_plugin.html
(($) ->
    methods = 
        init: (options={}) ->
            defaults = 
            propertyName: 'value',  
            onSomeEvent: ->  

            settings = $.extend({}, defaults, options);  
            $(this).data("hehe", settings)
        get: ->
            data = $(this).data("hehe")
        alert: (str)->
            data = $(this).data("hehe")
            alert(data.pp+$(this).html())
    
    $.fn.test = (options) ->
        method = arguments[0]
        temp_arguments = arguments
        if methods[method]
            method = methods[method]
            temp_arguments = Array.prototype.slice.call(temp_arguments, 1)
        else if (typeof method == "object" ) || !method
            method = methods.init
        else
            $.error('method'+method+'not exists')

        return method.apply(this,temp_arguments)

)(jQuery);


