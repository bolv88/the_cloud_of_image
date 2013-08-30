
String.prototype.trim = function(){ return this.replace(/^\s+|\s+$/g, ''); };
function supportsHtmlStorage() {
    try {
        return 'localStorage' in window && window['localStorage'] !== null;
    } catch (e) {
        return false;
    }
}

function findNodeTags( element ) {

    var nodeNames = {};

    while ( element.parentNode ) {

        nodeNames[element.nodeName] = true;
        element = element.parentNode;

        if ( element.nodeName === 'A' ) {
            nodeNames.url = element.href;
        }
    }

    return nodeNames;
}

window.onload = function(){
    var btn, lastSelection, lastType, headerField, contentField;
    var textOptions = document.querySelector('#editor-bar');
    var urlInput = textOptions.querySelector( 'input.url' );

    var applyURL = function(url)
    {
        url = url.trim();
        rehighlightLastSelection();
        console.log("unlink, url:"+url+","+url.length);
        document.execCommand( 'unlink', false );
        if (url !== "") {

            // Insert HTTP if it doesn't exist.
            if ( !url.match("^(http|https)://") ) {

                url = "http://" + url;  
            }

            document.execCommand( 'createLink', false, url );
        }
    }
    var hideBubble = function()
    {
        console.log("hide");
        removeClass(textOptions, "active");
        addClass(textOptions, "fade");
        setTimeout(function(){
                if (hasClass(textOptions, "fade")) {
                removeClass(textOptions, "fade");
                textOptions.style.top = '-999px';
                textOptions.style.left = '-999px';
                }
                console.log("hide bubble");
                }, 200);
    }

    var checkTextHighlighting = function(event)
    {
        var selection = window.getSelection();


        console.log("isCollapsed: " + selection.isCollapsed);
        console.log("classname: "+event.target.className);

        if ( event && event.target && (hasClass(event.target, "url") ||
                    hasClass(event.target, "A") ||
                    hasClass(event.target.parentNode, "ui-inputs")) ) {

            console.log("url , return");
            return;
        }

        if (selection && !selection.isCollapsed) {
            removeClass(textOptions, "fade");
            var nodeTags = findNodeTags(selection.focusNode);
            var btns = ["B", "A", "BLOCKQUOTE", "I"];
            for (var i in btns) {
                i = btns[i];
                var btn = document.querySelector("."+i);

                btn.className = "btn "+i;
            }
            for (var k in nodeTags) {
                try{
                    //console.log("checking: "+k);
                    var btn = document.querySelector("."+k);
                    if (btn) {
                        btn.className = "btn "+k +" active";
                    }
                }catch(e){
                    console.log(e);
                }
            }

            console.log("update position");
            updateBubblePosition();

        } else if(lastType === false) {

            hideBubble();
        }
        lastType = selection.isCollapsed;
    }

    function updateBubblePosition() {

        var selection = window.getSelection();
        var range = selection.getRangeAt(0);
        var boundary = range.getBoundingClientRect();

        textOptions.style.top = boundary.top - 5 + window.pageYOffset + "px";
        textOptions.style.left = (boundary.left + boundary.right)/2 + "px";
        //textOptions.style.left = (boundary.left + boundary.right)/2-textOptions.offsetWidth/2 + "px";
        //textOptions.style.left = (boundary.left) + "px";

        addClass(textOptions, "active");
    }

    var saveState = function(event)
    {
        localStorage[ 'header' ] = headerField.innerHTML;
        localStorage[ 'content' ] = contentField.innerHTML;
    };
    var loadState = function() {

        if ( localStorage[ 'header' ] ) {
            headerField.innerHTML = localStorage[ 'header' ];
        }

        if ( localStorage[ 'content' ] ) {
            contentField.innerHTML = localStorage[ 'content' ];
        }
    }

    var init = function()
    {
        var range = document.createRange();
        var selection = window.getSelection();
        headerField = document.querySelector( '.art h2' );
        contentField = document.querySelector( '.art .content' );
        range.setStart(headerField, 0); //1,结尾 0, 开头
        //range.setStartBefore(headerField);
        selection.removeAllRanges();
        selection.addRange(range);

    }

    var hasNode = function(nodeList, name )
    {
        return !!nodeList[ name ];
    }
    var hasClass = function(node, className) {
        if (!node || !node.className) {
            return false;
        }
        var classes = node.className.split(" ");
        for ( var i in classes) {
            if (classes[i] == className) {
                return true;
            }
        }
        return false;
    }
    var removeClass = function(node, className) {
        var classes = node.className.split(" ");
        var newClasses = [];
        for ( var i in classes) {
            if (classes[i] != className) {
                newClasses.push(classes[i]);
            }
        }
        node.className = newClasses.join(" ");
    }
    var addClass = function(node, className) {
        var classes = node.className.split(" ");
        var newClasses = [];
        for ( var i in classes) {
            if (classes[i] != className) {
                newClasses.push(classes[i]);
            }
        }
        newClasses.push(className);
        node.className = newClasses.join(" ");
    }
    var focusContent = function()
    {
        //contentField.focus();
    };

    init();	


    function rehighlightLastSelection() {
        var sel = window.getSelection();
        sel.removeAllRanges();
        sel.addRange( lastSelection );
    }

    urlInput.onblur = function(){
        console.log("blur");
        removeClass(textOptions, "url_model");
        applyURL( urlInput.value );
        urlInput.value = '';
        focusContent();
    };
    urlInput.onkeydown = function(event){

        if ( event.keyCode === 13 ) {
            event.preventDefault();
            urlInput.blur();
        }
    }

    /*
       btn = document.querySelector("#btn-test");
       btn.onclick = function()
       {
       var selection = window.getSelection();
       if (selection && !selection.isCollapsed) {
       var nodeTags = findNodeTags(selection.focusNode);
       }
       }
       */


    
    var setup_simple_btn_bind = function() {

        //bold, 粗体
        btn = document.querySelector('#btn-bold');
        btn.onclick = function(evt)
        {
            document.execCommand( 'bold', false );
        }

        //italic , 斜体
        btn = document.querySelector("#btn-italic");
        btn.onclick = function()
        {
            document.execCommand( 'italic', false );
            focusContent();
        }
        
        //block , 引用
        btn = document.querySelector("#btn-block");
        btn.onclick = function()
        {
            var selection = window.getSelection();
            var nodeTags = findNodeTags(selection.focusNode);
            if (!!nodeTags['BLOCKQUOTE']) {
                document.execCommand( 'formatBlock', false, 'p' );
                document.execCommand( 'outdent' );
            } else {
                document.execCommand( 'formatBlock', false, 'blockquote' );
            }
            focusContent();
        }

        btn = document.querySelector('#btn-url');
        btn.onmousedown = function(event)
        {
            console.log("url  mousedown");
            if (hasClass(textOptions, "url_model")) {
                removeClass(textOptions, "url_model");
                focusContent();
            } else {
                var nodes = findNodeTags(window.getSelection().focusNode);
                if (hasNode(nodes, "A")) {
                    urlInput.value = nodes.url;
                } else {
                    document.execCommand( 'createLink', false, "/" );
                }
                addClass(textOptions, "url_model");
                console.log("add url model");
                //防止选中的文字消失 
                setTimeout(function(){

                        var now_select = window.getSelection().getRangeAt(0);
                        /*
                           if (now_select.startOffset!=now_select.endOffset) {
                           }
                           */
                        lastSelection = now_select;

                        urlInput.focus();
                        lastType = false;
                        }, 100);

            }
            //移除 url link
            //document.execCommand( 'unlink', false );
            //document.execCommand( 'createLink', false, "http://www.okbuy.com" );

        }


    }
    setup_simple_btn_bind();

    var setup_document_bind = function() {
        //document
        if (supportsHtmlStorage()) {
            document.onmouseup = function( event ) {

                setTimeout( function() {
                        console.log("mouseup");
                        checkTextHighlighting( event );
                        saveState();
                        }, 1);

            };
            document.onkeyup = function(event)
            {
                console.log("keyup");
                checkTextHighlighting(event);
                saveState();
            }
            loadState();
        } else {
            document.onmouseup = function( event ) {

                setTimeout( function() {
                        console.log("mouseup");
                        checkTextHighlighting( event );
                        }, 1);
            };
            document.onkeyup = function(event)
            {
                console.log("keyup");
                checkTextHighlighting(event);
            }
        }
        document.onmousedown = function(event){
            console.log("mousedown");
            checkTextHighlighting(event);

            if (hasClass(event.target,"btn")) {
                var evt = event;
                if (evt.returnValue) {
                    evt.returnValue = false;
                } else if (evt.preventDefault) {
                    evt.preventDefault( );
                    evt.stopPropagation();
                } else {
                    return false;
                }
            }
        }
    }

    setup_document_bind();
}

