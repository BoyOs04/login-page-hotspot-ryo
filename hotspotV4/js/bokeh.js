/* =========================================================
   V4 PIXEL GRID BACKGROUND
   Canvas2D outline-only blocks.
   Flat 2D, no fill, no gradients, no 3D.
========================================================= */

(() => {
  'use strict';

  const CONFIG = {
    minSize: 28,
    maxSize: 92,
    minGap: 18,
    targetFPS: 30,
    maxPixelRatio: 1.25,
    countDesktop: 34,
    countMobile: 22,
    drift: 0.16,
    pointerRadius: 180,
    pointerStrength: 8
  };

  let canvas = null;
  let ctx = null;
  let width = 0;
  let height = 0;
  let dpr = 1;
  let lastFrame = 0;
  let pointerX = 0;
  let pointerY = 0;

  const blocks = [];
  const frameInterval = 1000 / CONFIG.targetFPS;

  function random(min, max) {
    return Math.random() * (max - min) + min;
  }

  function countForViewport() {
    return width < 600 ? CONFIG.countMobile : CONFIG.countDesktop;
  }

  function createBlock() {
    const size = Math.round(random(CONFIG.minSize, CONFIG.maxSize) / 4) * 4;
    return {
      x: random(-20, width + 20),
      y: random(-20, height + 20),
      size,
      vx: random(-CONFIG.drift, CONFIG.drift),
      vy: random(-CONFIG.drift, CONFIG.drift),
      phase: random(0, Math.PI * 2),
      alpha: random(0.09, 0.20),
      widthPulse: random(0.92, 1.08),
      offsetX: 0,
      offsetY: 0
    };
  }

  function rebuildBlocks() {
    blocks.length = 0;
    for (let i = 0; i < countForViewport(); i++) {
      blocks.push(createBlock());
    }
  }

  function resize() {
    width = window.innerWidth;
    height = window.innerHeight;
    dpr = Math.min(window.devicePixelRatio || 1, CONFIG.maxPixelRatio);

    canvas.width = Math.max(1, Math.round(width * dpr));
    canvas.height = Math.max(1, Math.round(height * dpr));
    canvas.style.width = '100vw';
    canvas.style.height = '100vh';

    ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
    pointerX = width / 2;
    pointerY = height / 2;
    rebuildBlocks();
  }

  function drawBlock(block, time) {
    const pulse = 1 + Math.sin(time * 0.0008 + block.phase) * 0.035;
    const size = block.size * pulse;
    const x = Math.round(block.x + block.offsetX);
    const y = Math.round(block.y + block.offsetY);

    ctx.strokeStyle = `rgba(72,28,40,${block.alpha})`;
    ctx.lineWidth = 1;
    ctx.strokeRect(x + 0.5, y + 0.5, Math.round(size), Math.round(size));

    /* One tiny pixel notch keeps the blocks irregular, like a game-world grid. */
    ctx.fillStyle = `rgba(72,28,40,${block.alpha * 0.85})`;
    const pixel = 3;
    const side = Math.floor((size - pixel) / 2);
    if (side > 4) {
      if ((block.phase * 10) % 2 > 1) {
        ctx.fillRect(x + side, y + 0.5, pixel, 1);
      } else {
        ctx.fillRect(x + 0.5, y + side, 1, pixel);
      }
    }
  }

  function animate(time) {
    requestAnimationFrame(animate);

    if (time - lastFrame < frameInterval) return;
    lastFrame = time;

    ctx.clearRect(0, 0, width, height);

    const seconds = time * 0.001;

    for (const block of blocks) {
      block.x += block.vx;
      block.y += block.vy;

      const dx = block.x + block.size / 2 - pointerX;
      const dy = block.y + block.size / 2 - pointerY;
      const distance = Math.hypot(dx, dy);

      let targetX = 0;
      let targetY = 0;

      if (distance > 0 && distance < CONFIG.pointerRadius) {
        const force = (1 - distance / CONFIG.pointerRadius) * CONFIG.pointerStrength;
        targetX = (dx / distance) * force;
        targetY = (dy / distance) * force;
      }

      block.offsetX += (targetX - block.offsetX) * 0.06;
      block.offsetY += (targetY - block.offsetY) * 0.06;

      if (block.x < -block.size - CONFIG.minGap) block.x = width + CONFIG.minGap;
      if (block.x > width + CONFIG.minGap) block.x = -block.size;
      if (block.y < -block.size - CONFIG.minGap) block.y = height + CONFIG.minGap;
      if (block.y > height + CONFIG.minGap) block.y = -block.size;

      drawBlock(block, time);
    }
  }

  function init() {
    canvas =
      document.getElementById('bgCanvas') ||
      document.querySelector('#bgCanvas-container canvas');

    if (!canvas) {
      const container = document.getElementById('bgCanvas-container');
      if (!container) return;
      canvas = document.createElement('canvas');
      canvas.id = 'bgCanvas';
      container.appendChild(canvas);
    }

    ctx = canvas.getContext('2d', {
      alpha: true,
      desynchronized: true
    });

    if (!ctx) return;

    canvas.style.position = 'fixed';
    canvas.style.inset = '0';
    canvas.style.zIndex = '0';
    canvas.style.pointerEvents = 'none';
    canvas.style.display = 'block';
    canvas.style.opacity = '1';
    canvas.setAttribute('aria-hidden', 'true');

    resize();

    window.addEventListener('resize', resize, { passive: true });
    window.addEventListener('pointermove', event => {
      pointerX = event.clientX;
      pointerY = event.clientY;
    }, { passive: true });

    window.addEventListener('touchmove', event => {
      const touch = event.touches && event.touches[0];
      if (touch) {
        pointerX = touch.clientX;
        pointerY = touch.clientY;
      }
    }, { passive: true });

    requestAnimationFrame(animate);
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init, { once: true });
  } else {
    init();
  }
})();
