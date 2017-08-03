<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE HTML>
<html lang="en">
<head>
    <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
    <title>main</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="/css/lib/bootstrap.min.css">
    <link rel="stylesheet" href="/css/main.css">
    <link rel="stylesheet" href="/css/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/lib/jquery.fileupload.css">
    <script src="/js/lib/jquery-3.1.1.min.js"></script>
    <script src="/js/lib/bootstrap.min.js"></script>
    <script src="/js/lib/three.js"></script>
    <script src="/js/lib/Projector.js"></script>
    <script src="/js/lib/CanvasRenderer.js"></script>
    <script src="/js/lib/stats.min.js"></script>
    <script src="/js/lib/maplace.min.js"></script>
    <script src="/js/lib/map.js"></script>
    <script src="/js/lib/jquery.cookie.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDzb9Bx9DLm7PlQN4do2jR-p3NcQo2g-Vg"></script>
    <script>
        window.mapFlag=0;
    </script>
</head>
<body>
<br/>
<div style="margin:0 auto;text-align: right;padding-right:50px;white-space:nowrap;color: #337ab7;font-size: 18px;">
    <a style="text-decoration:none;" href="http://localhost:8080">
        <i  class="fa fa-user-circle" id="userICON" onmouseover="iconOnmouseover(this)" onmouseout="iconOnmouseout(this)"></i>&nbsp;&nbsp;${requestScope.nick}&nbsp;&nbsp;&nbsp;&nbsp;
    </a>
    &nbsp;&nbsp;&nbsp;&nbsp;
    <a  style="" href="http://localhost:8080" target="_blank">online demo</a>&nbsp;||
    <a  style="" href="http://localhost:8080" target="_blank">source code</a>
</div>
<div class='container-fluid'>
    <div class="row" >
        <div class="col-xs-12 col-sm-0 dis bottom">
            <div class="dis col-xs-12 col-sm-0">
                <p style="color: #777777;font-size: 23px;">
                    <span onmouseleave="navOnmouseout(this)" onmouseenter="navOnmouseover(this)">主&nbsp;&nbsp;页</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span onmouseleave="navOnmouseout(this)" onmouseenter="navOnmouseover(this)">联&nbsp;&nbsp;系</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span onmouseleave="navOnmouseout(this)" onmouseenter="navOnmouseover(this)">其&nbsp;&nbsp;他</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span onmouseleave="navOnmouseout(this)" onmouseenter="navOnmouseover(this)">关&nbsp;&nbsp;于</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span onmouseleave="iconOnmouseout(this)" onmouseenter="iconOnmouseover(this)"><i class="fa fa-phone"></i></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span onmouseleave="iconOnmouseout(this)" onmouseenter="iconOnmouseover(this)"><i class="fa fa-envelope"></i></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span onmouseleave="iconOnmouseout(this)" onmouseenter="iconOnmouseover(this)" onclick="setMap()"><i class="fa fa-map-marker"></i></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span onmouseleave="iconOnmouseout(this)" onmouseenter="iconOnmouseover(this)"><i class="fa fa-bell"></i></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </p>
            </div>
        </div>
        <div class="col-xs-12 col-sm-0">
            <hr style=" height:1px;border:none;border-top:1px solid #aaaaaa;" />
        </div>
    </div>
</div>
<div class='container-fluid back'>
    <div class="row" >
        <video id="video" autoplay style="display:none">
            <source src="/media/static/sintel.mp4" type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"'>
            <source src="/media/static/sintel.ogv" type='video/ogg; codecs="theora, vorbis"'>
        </video>
        <script>
            var AMOUNT = 100;
            var container;
            var camera, scene, renderer;
            var video, image, imageContext,
                imageReflection, imageReflectionContext, imageReflectionGradient,
                texture, textureReflection;
            var mesh;
            var mouseX = 0;
            var mouseY = 0;
            var windowHalfX = window.innerWidth / 2;
            var windowHalfY = window.innerHeight / 2;
            init();
            animate();
            function init() {
                container = document.createElement( 'div' );
                container.id='canvasContainer';
                var info = document.createElement( 'div' );
                info.style.position = 'absolute';
                info.style.top = '250px';
                info.style.width = '100%';
                info.style.textAlign = 'center';
                info.innerHTML = '<p style="color:#777777;font-size:20px;" >' +
                    '<span onmouseleave="navOnmouseout(this)" onmouseenter="navOnmouseover(this)">热&nbsp;门</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' +
                    '<span onmouseleave="navOnmouseout(this)" onmouseenter="navOnmouseover(this)">最&nbsp;新</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' +
                    '<span onmouseleave="navOnmouseout(this)" onmouseenter="navOnmouseover(this)">分&nbsp;类</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' +
                    '<span onmouseleave="navOnmouseout(this)" onmouseenter="navOnmouseover(this)">我&nbsp;的</span></p><p>' +
                    '<span onmouseleave="iconOnmouseout(this)" onmouseenter="iconOnmouseover(this)"><i class="fa fa-share-alt"></i></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ' +
                    '<span onmouseleave="iconOnmouseout(this)" onmouseenter="iconOnmouseover(this)"><i class="fa fa-thumbs-up"></i></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ' +
                    '<span onmouseleave="iconOnmouseout(this)" onmouseenter="iconOnmouseover(this)"><i class="fa fa-comment"></i></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ' +
                    '<span onmouseleave="iconOnmouseout(this)" onmouseenter="iconOnmouseover(this)"><i class="fa fa-refresh"></i></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' +
                    '<span onmouseleave="iconOnmouseout(this)" onmouseenter="iconOnmouseover(this)"><i class="fa fa-heart-o"></i></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
                    '<span onmouseleave="iconOnmouseout(this)" onmouseenter="iconOnmouseover(this)" onclick="setUpload()"><i class="fa fa-upload"></i></span></p>';
                container.appendChild( info );
                document.body.appendChild( container );
                camera = new THREE.PerspectiveCamera( 45*0.8, window.innerWidth / window.innerHeight, 1, 10000 );
                camera.position.z = 1000;
                scene = new THREE.Scene();
                video = document.getElementById( 'video' );
                image = document.createElement( 'canvas' );
                image.width = 480;
                image.height = 204;
                imageContext = image.getContext( '2d' );
                imageContext.fillStyle = '#000000';
                imageContext.fillRect( 0, 0, 480, 204 );
                texture = new THREE.Texture( image );
                var material = new THREE.MeshBasicMaterial( { map: texture, overdraw: 0.5 } );
                imageReflection = document.createElement( 'canvas' );
                imageReflection.width = 480;
                imageReflection.height = 204;
                imageReflectionContext = imageReflection.getContext( '2d' );
                imageReflectionContext.fillStyle = '#000000';
                imageReflectionContext.fillRect( 0, 0, 480, 204 );
                imageReflectionGradient = imageReflectionContext.createLinearGradient( 0, 0, 0, 204 );
                imageReflectionGradient.addColorStop( 0.2, 'rgba(240, 240, 240, 1)' );
                imageReflectionGradient.addColorStop( 1, 'rgba(240, 240, 240, 0.8)' );
                textureReflection = new THREE.Texture( imageReflection );
                var materialReflection = new THREE.MeshBasicMaterial( { map: textureReflection, side: THREE.BackSide, overdraw: 0.5 } );
                var plane = new THREE.PlaneGeometry( 480, 204, 4, 4 );
                mesh = new THREE.Mesh( plane, material );
                mesh.scale.x = mesh.scale.y = mesh.scale.z = 1.5;
                scene.add(mesh);
                mesh = new THREE.Mesh( plane, materialReflection );
                mesh.position.y = -306;
                mesh.rotation.x = - Math.PI;
                mesh.scale.x = mesh.scale.y = mesh.scale.z = 1.5;
                scene.add( mesh );
                var separation = 150;
                var amountx = 10;
                var amounty = 10;
                var PI2 = Math.PI * 2;
                var material = new THREE.SpriteCanvasMaterial( {
                    color: 0x0808080,
                    program: function ( context ) {
                        context.beginPath();
                        context.arc( 0, 0, 0.5, 0, PI2, true );
                        context.fill();
                    }
                } );
                for ( var ix = 0; ix < amountx; ix++ ) {
                    for ( var iy = 0; iy < amounty; iy++ ) {
                        particle = new THREE.Sprite( material );
                        particle.position.x = ix * separation - ( ( amountx * separation ) / 2 );
                        particle.position.y = -153;
                        particle.position.z = iy * separation - ( ( amounty * separation ) / 2 );
                        particle.scale.x = particle.scale.y = 2;
                        scene.add( particle );
                    }
                }
                renderer = new THREE.CanvasRenderer();
                renderer.setClearColor( 0xf0f0f0 );
                renderer.setPixelRatio( window.devicePixelRatio );
                renderer.setSize( window.innerWidth, window.innerHeight);
                container.appendChild( renderer.domElement );
                document.addEventListener( 'mousemove', onDocumentMouseMove, false );
                window.addEventListener( 'resize', onWindowResize, false );
            }

            function onWindowResize() {
                windowHalfX = window.innerWidth / 2;
                windowHalfY = window.innerHeight / 2;
                camera.aspect = window.innerWidth / window.innerHeight;
                camera.updateProjectionMatrix();
                renderer.setSize( window.innerWidth, window.innerHeight );
            }

            function onDocumentMouseMove( event ) {
                mouseX = ( event.clientX - windowHalfX );
                mouseY = ( event.clientY - windowHalfY ) * 0.2;
            }

            function animate() {
                requestAnimationFrame( animate );
                render();
            }

            function render() {
                camera.position.x += ( mouseX - camera.position.x ) * 0.05;
                camera.position.y += ( - mouseY - camera.position.y ) * 0.05;
                camera.lookAt( scene.position );
                if ( video.readyState === video.HAVE_ENOUGH_DATA ) {
                    imageContext.drawImage( video, 0, 0 );
                    if ( texture ) texture.needsUpdate = true;
                    if ( textureReflection ) textureReflection.needsUpdate = true;
                }
                imageReflectionContext.drawImage( image, 0, 0 );
                imageReflectionContext.fillStyle = imageReflectionGradient;
                imageReflectionContext.fillRect( 0, 0, 480, 204 );
                renderer.render( scene, camera );
            }
        </script>
    </div>
</div>

<br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/>
<div class="container-fluid gradM">
    <div class="row">
        <div class="col-xs-12 col-sm-0">
            <br/><br/><br/><br/><br/><br/><br/><br/><br/>
        </div>
    </div>
</div>

<script>
    function navOnmouseover(obj) {
        obj.style.cursor='pointer';
        obj.style.color='#56b696';
        obj.style.fontWeight=900;
    }

    function navOnmouseout(obj) {
        obj.style.color='#777777';
        obj.style.fontWeight=100;
    }

    function iconOnmouseover(obj) {
        obj.style.cursor='pointer';
        obj.style.color='#56b696';
    }

    function iconOnmouseout(obj) {
        obj.style.color='#337ab7';
    }
</script>
<script>
    function createMap() {
        var canvasContainer=document.getElementById('canvasContainer');
        var mapContainer=document.createElement('div');
        mapContainer.style.position='absolute';
        mapContainer.style.width=window.innerWidth+"px";
        mapContainer.style.height=window.innerHeight+"px";
        mapContainer.style.top=-window.innerHeight+"px";
        mapContainer.style.textAlign='center';
        mapContainer.id='mapContainerID';
        mapContainer.style.margin='0 auto';
        canvasContainer.appendChild(mapContainer);
        new Maplace({
            locations: LocsA,
            map_div: '#mapContainerID',
            controls_title: 'Choose a location:',
            listeners: {
                click: function(map, event) {
                }
            }
        }).Load();
        return mapContainer;
    }
    window.mapContainer=createMap();
    window.mapContainer.style.display='none';

    function setMap() {
        window.mapFlag++;
        if(window.mapFlag%2==0){window.mapContainer.style.display='none';}
        else window.mapContainer.style.display='block';
    }
</script>
<script src="/js/lib/jquery-ui.min.js"></script>
<script src="/js/lib/load-image.all.min.js"></script>
<script src="/js/lib/canvas-to-blob.min.js"></script>
<script src="/js/lib/jquery.iframe-transport.js"></script>
<script src="/js/lib/jquery.fileupload.js"></script>
<script src="/js/lib/jquery.fileupload-process.js"></script>
<script src="/js/lib/jquery.fileupload-image.js"></script>
<script src="/js/lib/jquery.fileupload-audio.js"></script>
<script src="/js/lib/jquery.fileupload-video.js"></script>
<script src="/js/lib/jquery.fileupload-validate.js"></script>
<script>
    function createUploadContainer() {
        var canvasContainer=document.getElementById('canvasContainer');
        var uploadContainer=document.createElement('div');
        uploadContainer.id='uploadContainerID';
        uploadContainer.style.position='fixed';
        uploadContainer.style.width=window.innerWidth+"px";
        uploadContainer.style.top='250px';
        uploadContainer.style.background='#e5e3df';
        uploadContainer.style.color='#337ab7';
        $.get("${pageContext.request.contextPath}/view/static/upload.html",function(data){
            $("#uploadContainerID").html(data);
        });
        canvasContainer.appendChild(uploadContainer);
        return uploadContainer;
    }
    function setUpload() {
        var uploadContainer=createUploadContainer();
    }
</script>
</body>
</html>
