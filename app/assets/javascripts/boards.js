//= require jquery
//= require jquery_ujs

var canvas = document.getElementById('canvas');
var context= canvas.getContext('2d');
var radius = 10;
var dragging = false;

canvas.width = window.innerWidth;
canvas.height = window.innerHeight;
context.lineWidth = 2*radius;

var putPoint = function(e){
  if(dragging)
  {
  context.lineTo(e.clientX,e.clientY);
  context.stroke();
  context.beginPath();
  context.arc(e.clientX, e.clientY, radius, 0, Math.PI*2);
  context.fill();
  context.beginPath();
  context.moveTo(e.clientX,e.clientY)
  }
}

var engage = function(e){
  dragging = true;
  putPoint(e);
}

var disengage = function(){
  dragging = false;
  context.beginPath();
}
canvas.addEventListener('mousedown',engage);
canvas.addEventListener('mousemove', putPoint);
canvas.addEventListener('mouseup',disengage);

//radius
var setRadius = function(newRadius){
  if(newRadius < minRad)
    newRadius = minRad;
  else if(newRadius > maxRad)
    newRadius = maxRad
  radius = newRadius;
  context.lineWidth = 2*radius;
  radSpan.innerHTML = radius;
}


var minRad = 2,
  maxRad = 100,
  defaultRad = 10,
  interval = 2,
  radSpan = document.getElementById('radval'),
  decRad = document.getElementById('decrad'),
  incRad = document.getElementById('incrad');
decRad.addEventListener('click',function(){
  setRadius(radius - interval)
});

incRad.addEventListener('click',function(){
  setRadius(radius + interval)
});
setRadius(defaultRad);

//color
function setColor(color)
{
  context.fillStyle = color;
  context.strokeStyle = color;
  var active = document.getElementsByClassName('active')[0];
  if(active){
    active.className = 'swatch';
  }
}



// ---SAVE FUNCTIONALITY HERE---

    // Convert dataURL to Blob Object
function dataURLtoBlob(dataURL) {
    // Decode the dataURL
    var binary = atob(dataURL.split(',')[1]);
    // Create 8-bit unsigned array
    var array = [];
    for(var i = 0; i < binary.length; i++) {
        array.push(binary.charCodeAt(i));
    }
    // Return our Blob object
    return new Blob([new Uint8Array(array)], {type: 'image/png'});
}

var saveButton = document.getElementById('save');

saveButton.addEventListener('click',saveImage);

function saveImage(){
  console.log('sending..')
  var arr = String(window.location.href).split('/')
  var check_path = arr[arr.length -1]

  var dataURL = canvas.toDataURL('image/png');
  //window.open(dataURL,'_blank','location=0, menubar=0');
   // Get our file
  var file= dataURLtoBlob(dataURL);
    // Create new form data
  var fd = new FormData();
    // Append our Canvas image file to the form data
  fd.append("image", file);
    // And send it
  if(check_path == "edit" ){
    $.ajax({
       url: "/boards/" + String(arr[arr.length -2]) + "/",
       type: "PATCH",
       data: fd,
       processData: false,
       contentType: false,
    });
    confirm("Board Saved!")
  }
  else{
    $.ajax({
       url: "/boards/",
       type: "POST",
       data: fd,
       processData: false,
       contentType: false,
    });
    confirm("Board Created")
    context.clearRect(0, 0, canvas.width, canvas.height);
  }
}


var clearButton = document.getElementById('clear');
clearButton.addEventListener('click',clearIm);
function clearIm(){
  location.reload();
}

//IMAGE UPLOADER
function el(id){return document.getElementById(id);}

var canvas  = el("canvas");
var context = canvas.getContext("2d");

function readImage() {
    if ( this.files && this.files[0] ) {
        var FR= new FileReader();
        FR.onload = function(e) {
           var img = new Image();
           img.onload = function() {
             context.drawImage(img, 0, 0);
           };
           img.src = e.target.result;
        };
        FR.readAsDataURL( this.files[0] );
    }
}
  //Insert Picture into Canvas
  var image_id = document.getElementById('image_to_canvas')
  if (image_id) {
    var canvas = document.getElementById('canvas')
    var context = canvas.getContext('2d')
    context.drawImage(image_id,0,0);
    $('#image_to_canvas').hide()
  }

el("fileUpload").addEventListener("change", readImage, false);

//HIDE COLOR PICKER
$(document).ready(function(){

  $('#eraser').click(function(){
    setColor('white');
  });

  $('.simple_color_kitchen_sink').simpleColor({
    boxHeight: 40,
    cellWidth: 20,
    cellHeight: 20,
    chooserCSS: {  'border': '1px solid #660033' },
    displayCSS: { 'margin-top': '-10px','border': '2px solid white' },
    displayColorCode: true,
    livePreview: true,
    onSelect: function(hex, element) {
      setColor('#'+hex);
      console.log(hex)
    },
  });

  //Insert Picture into Canvas
  var image_id = document.getElementById('image_to_canvas')
  if (image_id) {
    var canvas = document.getElementById('canvas')
    var context = canvas.getContext('2d')
    context.drawImage(image_id,0,0);
    $('#image_to_canvas').hide()
  }

});
