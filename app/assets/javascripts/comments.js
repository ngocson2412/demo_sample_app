var loadFile1 = function(event) {  
  var output = document.getElementById('image-preview1');
  output.src = URL.createObjectURL(event.target.files[0]);
};