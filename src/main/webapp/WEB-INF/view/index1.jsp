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
</head>
<body class="body1">
<br/>
<div style="margin:0 auto;text-align: right;padding-right:50px;">
        <a  style="color: #66afe9;" href="http://localhost:8080" target="_blank">online demo</a> &nbsp;&nbsp;|| &nbsp;&nbsp;
        <a  style="color: #66afe9;" href="http://localhost:8080" target="_blank">source code</a>
</div>
<br/>
<div style="margin:0 auto;width:400px;height:30px;background: #d0e9c6;text-align: center;">
    <div style="position: absolute;text-align: center;">
        <canvas id="myCanvas" width="400" height="35" style="border:1px solid #c3c3c3;">
        </canvas>
    </div>
    <div style="position: absolute;float: right;margin-left:420px;margin-top:-2px;"><i class="fa fa-arrow-circle-right fa-3x"></i></div>
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
    var PI2 = Math.PI * 2;
    var programFill = function ( context ) {
        context.beginPath();
        context.arc( 0, 0, 0.5, 0, PI2, true );
        context.fill();
    };
    var programStroke = function ( context ) {
        context.lineWidth = 0.025;
        context.beginPath();
        context.arc( 0, 0, 0.5, 0, PI2, true );
        context.stroke();
    };
    var INTERSECTED;
    init();
    animate();
    function init() {
        container = document.createElement( 'div' );
        document.body.appendChild( container );
        var info = document.createElement( 'div' );
        info.style.position = 'absolute';
        info.style.top = '10px';
        info.style.width = '100%';
        info.style.textAlign = 'center';
        container.appendChild( info );
        camera = new THREE.PerspectiveCamera( 70, window.innerWidth / window.innerHeight, 1, 10000 );
        camera.position.set( 0, 300, 500 );
        scene = new THREE.Scene();
        for ( var i = 0; i < 100; i ++ ) {
            var particle = new THREE.Sprite( new THREE.SpriteCanvasMaterial( { color: Math.random() * 0x808080 + 0x808080, program: programStroke } ) );
            particle.position.x = Math.random() * 800 - 400;
            particle.position.y = Math.random() * 800 - 400;
            particle.position.z = Math.random() * 800 - 400;
            particle.scale.x = particle.scale.y = Math.random() * 20 + 20;
            scene.add( particle );
        }
        raycaster = new THREE.Raycaster();
        mouse = new THREE.Vector2();
        renderer = new THREE.CanvasRenderer();
        renderer.setClearColor( 0xf0f0f0 );
        renderer.setPixelRatio( window.devicePixelRatio );
        renderer.setSize( window.innerWidth, window.innerHeight );
        container.appendChild( renderer.domElement );
        document.addEventListener( 'mousemove', onDocumentMouseMove, false );
        window.addEventListener( 'resize', onWindowResize, false );
    }

    function onWindowResize() {
        camera.aspect = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();
        renderer.setSize( window.innerWidth, window.innerHeight );
    }

    function onDocumentMouseMove( event ) {
        event.preventDefault();
        mouse.x = ( event.clientX / window.innerWidth ) * 2 - 1;
        mouse.y = - ( event.clientY / window.innerHeight ) * 2 + 1;
    }

    function animate() {
        requestAnimationFrame( animate );
        render();
    }

    var radius = 600;
    var theta = 0;

    function render() {
        theta += 0.1;
        camera.position.x = radius * Math.sin( THREE.Math.degToRad( theta ) );
        camera.position.y = radius * Math.sin( THREE.Math.degToRad( theta ) );
        camera.position.z = radius * Math.cos( THREE.Math.degToRad( theta ) );
        camera.lookAt( scene.position );
        camera.updateMatrixWorld();
        raycaster.setFromCamera( mouse, camera );
        var intersects = raycaster.intersectObjects( scene.children );
        if ( intersects.length > 0 ) {
            if ( INTERSECTED != intersects[ 0 ].object ) {
                if ( INTERSECTED ) INTERSECTED.material.program = programStroke;
                INTERSECTED = intersects[ 0 ].object;
                INTERSECTED.material.program = programFill;
            }
        } else {
            if ( INTERSECTED ) INTERSECTED.material.program = programStroke;
            INTERSECTED = null;
        }
        renderer.render( scene, camera );
    }
</script>
</body>
</html>
