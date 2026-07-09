// ─── Swimming Fish for Dream Theme ───
// Matches the app's behavior: 8 fish, 5 PNG silhouettes, right-to-left with bobbing
(function() {
  'use strict';
  var container = document.getElementById('fish-container');
  if (!container) return;

  var fishFiles = ['fish1.png','fish2.png','fish3.png','fish4.png','fish5.png'];
  var count = 8;
  var fish = [];

  for (var i = 0; i < count; i++) {
    (function(idx) {
      var el = document.createElement('div');
      el.className = 'dream-fish';
      var img = document.createElement('img');
      img.src = '/assets/' + fishFiles[idx % fishFiles.length];
      img.alt = '';
      el.appendChild(img);
      container.appendChild(el);

      var state = {
        el: el,
        img: img,
        size: 0, y: 0, opacity: 0, speed: 0,
        bobFreq: 0, bobAmp: 0, progress: 0
      };

      function reset() {
        var w = window.innerWidth;
        var h = window.innerHeight;
        state.size = 25 + Math.random() * 70;
        state.y = 0.03 * h + Math.random() * 0.9 * h;
        state.opacity = 0.08 + Math.random() * 0.25;
        state.speed = 0.15 + Math.random() * 0.8;
        state.bobFreq = 1.5 + Math.random() * 4;
        state.bobAmp = 4 + Math.random() * 12;
        state.progress = Math.random();
        img.style.width = state.size + 'px';
        img.style.height = (state.size * 0.6) + 'px';
        el.style.opacity = state.opacity;
      }
      reset();
      fish.push(state);
    })(i);
  }

  function animate() {
    for (var j = 0; j < fish.length; j++) {
      var f = fish[j];
      f.progress += f.speed * 0.003;
      if (f.progress >= 1.0) {
        f.progress = 0;
        var w = window.innerWidth;
        var h = window.innerHeight;
        f.size = 25 + Math.random() * 70;
        f.y = 0.03 * h + Math.random() * 0.9 * h;
        f.opacity = 0.08 + Math.random() * 0.25;
        f.speed = 0.15 + Math.random() * 0.8;
        f.bobFreq = 1.5 + Math.random() * 4;
        f.bobAmp = 4 + Math.random() * 12;
        f.img.style.width = f.size + 'px';
        f.img.style.height = (f.size * 0.6) + 'px';
        f.el.style.opacity = f.opacity;
      }
      var w = window.innerWidth;
      var h = window.innerHeight;
      var x = w * (1.0 - f.progress) - f.size * 0.5;
      var y = f.y + Math.sin(f.progress * f.bobFreq * Math.PI * 2) * f.bobAmp;
      f.el.style.transform = 'translate3d(' + x + 'px, ' + y + 'px, 0)';
    }
    requestAnimationFrame(animate);
  }
  animate();
})();
