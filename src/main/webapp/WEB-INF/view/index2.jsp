<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>index</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="/css/lib/bootstrap.min.css">
    <script src="/js/lib/jquery-3.1.1.min.js"></script>
    <script src="/js/lib/bootstrap.min.js"></script>
    <script src="/js/lib/three.js"></script>
    <script src="/js/lib/Projector.js"></script>
    <script src="/js/lib/CanvasRenderer.js"></script>
    <script src="/js/lib/stats.min.js"></script>
    <link href="/css/index.css" type="text/css"/>
    <link href="/css/fonts/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="/js/lib/tween.min.js"></script>
    <script src="/js/lib/util.js"></script>

    <script>
        optColors=new Array();
        colors=[
            0xd87dca,
            0xbb4b83,
            0xf58b5f,
            0xf6c7a9,
            0xa4933e,
            0xa3ad47,
            0x43aa4,
            0x91dedb,
            0x8dc5c6,
            0x7feacf,
            0x3f68c6,
            0x87acf0,
            0xbe96e2,
            0xcc8cf0,
            0xa148a7
        ];
    </script>
</head>
<body class="body1">
<br/>
<div style="margin:0 auto;text-align: right;padding-right:50px;">
    <a  style="color: #66afe9;" href="http://localhost:8080" target="_blank">online demo</a>&nbsp;||
    <a  style="color: #66afe9;" href="http://localhost:8080" target="_blank">source code</a>
</div>
<br/>
<div style="margin:0 auto;width:400px;height:30px;background: #d0e9c6;text-align: center;">
    <div style="position: absolute;text-align: center;">
        <canvas id="myCanvas" width="400" height="35" style="border:1px solid #c3c3c3;">
        </canvas>
    </div>
    <div id="iconDiv" style="position: absolute;float: right;margin-left:420px;margin-top:-2px;color:#999999;z-index: 99999;">
        <i class="fa fa-arrow-circle-right fa-3x" id="enterICON" onmouseover="iconOnmouseover(this)" onmouseout="iconOnmouseout(this)" onclick="enter()"></i>&nbsp;&nbsp;
        <i class="fa fa-trash-o fa-3x" id="removeICON" onmouseover="iconOnmouseover(this)" onmouseout="iconOnmouseout(this)" onclick="remove()"></i>
    </div>
    <script type="text/javascript">
        var c=document.getElementById("myCanvas");
        var ctx=c.getContext("2d");
        ctx.fillStyle="#ffffff";
        ctx.fillRect(0,0,400,50);
    </script>
</div>
<br/>
<div class="col-xs-12 col-sm-0">
    <hr style=" height:1px;border:none;border-top:1px solid #aaaaaa;" />
</div>

<script>
    var container;
    var camera, scene, renderer;
    var raycaster;
    var mouse;
    opts=0;
    init();
    animate();
    function init() {
        container = document.createElement( 'div' );
        container.style.position='absolute';
        container.style.zIndex=document.getElementById("iconDiv").style.zIndex-100;
        document.body.appendChild( container );
        var info = document.createElement( 'div' );
        info.style.position = 'absolute';
        info.style.top = '10px';
        info.style.width = '100%';
        info.style.textAlign = 'center';
        container.appendChild( info );
        camera = new THREE.PerspectiveCamera( 70, window.innerWidth / window.innerHeight, 1, 10000 );
        camera.position.y = 300;
        camera.position.z = 500;
        scene = new THREE.Scene();
        var geometry = new THREE.BoxGeometry( 100, 100, 100 );
        for ( var i = 0; i < 20; i ++ ) {
            //var object = new THREE.Mesh( geometry, new THREE.MeshBasicMaterial( { color: Math.random() * 0xffffff, opacity: 0.5 } ) );
            var data=computeColor();
            var object = new THREE.Mesh( geometry, new THREE.MeshBasicMaterial( { color:colors[data.index], opacity: 0.5 } ) );
            object.position.x = Math.random() * 800 - 400;
            object.position.y = Math.random() * 800 - 400;
            object.position.z = Math.random() * 800 - 400;
            object.scale.x = Math.random() * 2 + 1;
            object.scale.y = Math.random() * 2 + 1;
            object.scale.z = Math.random() * 2 + 1;
            object.rotation.x = Math.random() * 2 * Math.PI;
            object.rotation.y = Math.random() * 2 * Math.PI;
            object.rotation.z = Math.random() * 2 * Math.PI;
            scene.add( object );
        }
        raycaster = new THREE.Raycaster();
        mouse = new THREE.Vector2();
        renderer = new THREE.CanvasRenderer();
        renderer.setClearColor( 0xf0f0f0 );
        renderer.setPixelRatio( window.devicePixelRatio );
        renderer.setSize( window.innerWidth, window.innerHeight );
        container.appendChild(renderer.domElement);
        document.addEventListener( 'mousedown', onDocumentMouseDown, false );
        document.addEventListener( 'touchstart', onDocumentTouchStart, false );
        window.addEventListener( 'resize', onWindowResize, false );
    }

    function onWindowResize() {
        camera.aspect = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();
        renderer.setSize( window.innerWidth, window.innerHeight );
    }

    function onDocumentTouchStart( event ) {
        event.preventDefault();
        event.clientX = event.touches[0].clientX;
        event.clientY = event.touches[0].clientY;
        onDocumentMouseDown( event );
    }

    function onDocumentMouseDown( event ) {
        event.preventDefault();
        mouse.x = ( event.clientX / renderer.domElement.clientWidth ) * 2 - 1;
        mouse.y = - ( event.clientY / renderer.domElement.clientHeight ) * 2 + 1;
        raycaster.setFromCamera( mouse, camera );
        var intersects = raycaster.intersectObjects( scene.children );
        if ( intersects.length > 0 ) {
            var color=intersects[0].object.material.color.getHexString();
            var index=getColorIndex(colors,color.toString(16));
            if(index>=0 && index<16) {
                opts++;
                var c=document.getElementById("myCanvas");
                var ctx=c.getContext("2d");
                ctx.fillStyle="#"+color;
                ctx.fillRect(50*(opts-1),0,50,50);
                optColors.push(index);
            }
            new TWEEN.Tween( intersects[ 0 ].object.position ).to( {
                x: Math.random() * 800 - 400,
                y: Math.random() * 800 - 400,
                z: Math.random() * 800 - 400 }, 2000 )
                .easing( TWEEN.Easing.Elastic.Out).start();
            new TWEEN.Tween( intersects[ 0 ].object.rotation ).to( {
                x: Math.random() * 2 * Math.PI,
                y: Math.random() * 2 * Math.PI,
                z: Math.random() * 2 * Math.PI }, 2000 )
                .easing( TWEEN.Easing.Elastic.Out).start();
        }
    }

    function animate() {
        requestAnimationFrame( animate );
        render();
    }

    var radius = 200;
    var theta = 0;

    function render()
    {
        TWEEN.update();
        theta += 0.1;
        camera.position.x = radius * Math.sin( THREE.Math.degToRad( theta ) );
        camera.position.y = radius * Math.sin( THREE.Math.degToRad( theta ) );
        camera.position.z = radius * Math.cos( THREE.Math.degToRad( theta ) );
        camera.lookAt( scene.position );
        renderer.render( scene, camera );
    }

    function computeColor(){
        var index=Math.floor(Math.random()*16);
        return {
            color:colors[index],
            index:index
        };
    }

    function getColorIndex(colors,color) {
        for(var i=0,len=colors.length;i<len;i++){
            if(colors[i].toString(16)==color) return i;
        }
        return -1;
    }
    
    function enter() {
        var u_nick="";
        for(var i=0,len=optColors.length;i<len;i++){
            u_nick+=optColors[i].toString(16);
        }
        var data={
            u_id:0,
            u_nick:u_nick,
            u_pwd:u_nick
        };
        $.ajax({
            url:"${pageContext.request.contextPath}"+"/user/ajaxLogin",
            data:JSON.stringify(data),
            type:'post',
            contentType:'application/json',
            dataType: 'json',
            success:function(result){
                if(result.u_id!=-1){
                    window.location.href="${pageContext.request.contextPath}"+"/user/enter?u_nick="+result.u_nick;
                }
        }});
    }
    
    function remove() {
        var c=document.getElementById("myCanvas");
        var ctx=c.getContext("2d");
        ctx.clearRect(0,0,400,50);
        ctx.fillStyle='#ffffff';
        ctx.fillRect(0,0,400,50);
        opts=0;
        optColors.splice(0,optColors.length);
    }
    
    function iconOnmouseover(obj) {
        obj.style.cursor='pointer';
        obj.style.color='#56b696';
    }

    function iconOnmouseout(obj) {
        obj.style.color='#999999';
    }
</script>
</body>
</html>
