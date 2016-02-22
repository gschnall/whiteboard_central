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
var colors = ['black','white','red','blue','yellow','green', 'purple']

for(var i=0,n=colors.length;i<n;i++){
  var swatch = document.createElement('div');
  swatch.className = 'swatch';
  swatch.style.backgroundColor = colors[i];
  swatch.addEventListener('click',setSwatch);
  document.getElementById('colors').appendChild(swatch);
}

function setColor(color)
{
  context.fillStyle = color;
  context.strokeStyle = color;
  var active = document.getElementsByClassName('active')[0];
  if(active){
    active.className = 'swatch';
  }
}

function setSwatch(e){
  var swatch = e.target;
  setColor(swatch.style.backgroundColor);
  swatch.className += ' active';
}

setSwatch({target: document.getElementsByClassName('swatch')[0]});

//save
var saveButton = document.getElementById('save');

saveButton.addEventListener('click',saveImage);
function saveImage(){
  var data = canvas.toDataURL();
  window.open(data,'_blank','location=0, menubar=0');
}

var clearButton = document.getElementById('clear');
clearButton.addEventListener('click',clearIm);
function clearIm(){
  location.reload();
}

