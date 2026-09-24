/* =========================================================
   bokeh.js - Interactive 2D Bokeh Background
   Engine: Canvas2D
   - reliable on GitHub Pages + MikroTik captive portal
   - transparent layer between background and UI
   - soft shadow
   - random drifting movement
   - pointer/touch interaction
   - lightweight for mobile
========================================================= */

(() => {
  'use strict';

  const CONFIG = {
    particleCount: 24,
    minSize: 88,
    maxSize: 220,
    minSpeedX: -0.34,
    maxSpeedX: 0.34,
    minSpeedY: -0.28,
    maxSpeedY: 0.28,
    targetFPS: 30,
    maxPixelRatio: 1.35,
    interactionRadius: 210,
    interactionStrength: 22,
    interactionEase: 0.075,
    pulseAmount: 0.045,
    wrapPadding: 260
  };

  let canvas = null;
  let ctx = null;
  let width = window.innerWidth;
  let height = window.innerHeight;
  let dpr = Math.min(window.devicePixelRatio || 1, CONFIG.maxPixelRatio);

  let pointerX = width / 2;
  let pointerY = height / 2;
  let lastFrame = 0;
  let running = true;

  const frameInterval = 1000 / CONFIG.targetFPS;

  function getCanvas() {
    const existing = document.getElementById('bgCanvas');
    if (existing) return existing;

    const container = document.getElementById('bgCanvas-container');

    if (container) {
      const created = document.createElement('canvas');
      created.id = 'bgCanvas';
      container.appendChild(created);
      return created;
    }

    const created = document.createElement('canvas');
    created.id = 'bgCanvas';
    document.body.prepend(created);
    return created;
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
  }

  function random(min, max) {
    return Math.random() * (max - min) + min;
  }

  function createParticle() {
    const centerX = width / 2;
    const centerY = height / 2;
    const radius = Math.min(width, height) * 0.70;

    let x;
    let y;

    if (Math.random() < 0.82) {
      const angle = random(0, Math.PI * 2);
      const distance = Math.pow(Math.random(), 1.7) * radius;
      x = centerX + Math.cos(angle) * distance;
      y = centerY + Math.sin(angle) * distance;
    } else {
      x = random(-CONFIG.wrapPadding, width + CONFIG.wrapPadding);
      y = random(-CONFIG.wrapPadding, height + CONFIG.wrapPadding);
    }

    return {
      x,
      y,
      size: random(CONFIG.minSize, CONFIG.maxSize),
      vx: random(CONFIG.minSpeedX, CONFIG.maxSpeedX),
      vy: random(CONFIG.minSpeedY, CONFIG.maxSpeedY),
      driftX: random(0.25, 0.75),
      driftY: random(0.20, 0.65),
      phaseX: random(0, Math.PI * 2),
      phaseY: random(0, Math.PI * 2),
      pulsePhase: random(0, Math.PI * 2),
      baseAlpha: random(0.22, 0.48),
      interactionX: 0,
      interactionY: 0
    };
  }

  function createParticles() {
    return Array.from(
      { length: CONFIG.particleCount },
      createParticle
    );
  }

  function drawParticle(particle, time) {
    const pulse =
      1 +
      Math.sin(time * 0.0012 + particle.pulsePhase) *
      CONFIG.pulseAmount;

    const size = particle.size * pulse;
    const radius = size * 0.50;

    const dx = particle.x - pointerX;
    const dy = particle.y - pointerY;
    const distance = Math.hypot(dx, dy);

    let targetX = 0;
    let targetY = 0;

    if (distance > 0 && distance < CONFIG.interactionRadius) {
      const force =
        (1 - distance / CONFIG.interactionRadius) *
        CONFIG.interactionStrength;

      targetX = (dx / distance) * force;
      targetY = (dy / distance) * force;
    }

    particle.interactionX +=
      (targetX - particle.interactionX) *
      CONFIG.interactionEase;

    particle.interactionY +=
      (targetY - particle.interactionY) *
      CONFIG.interactionEase;

    const x = particle.x + particle.interactionX;
    const y = particle.y + particle.interactionY;

    // Thin warm shadow.
    const shadowGradient = ctx.createRadialGradient(
      x + 6,
      y + 8,
      0,
      x + 6,
      y + 8,
      radius
    );

    shadowGradient.addColorStop(
      0,
      'rgba(72,28,40,0.08)'
    );
    shadowGradient.addColorStop(
      0.45,
      'rgba(72,28,40,0.045)'
    );
    shadowGradient.addColorStop(
      0.75,
      'rgba(72,28,40,0.018)'
    );
    shadowGradient.addColorStop(
      1,
      'rgba(72,28,40,0)'
    );

    ctx.fillStyle = shadowGradient;
    ctx.beginPath();
    ctx.arc(x + 6, y + 8, radius, 0, Math.PI * 2);
    ctx.fill();

    // Main soft bokeh.
    const glowGradient = ctx.createRadialGradient(
      x,
      y,
      0,
      x,
      y,
      radius
    );

    const alpha = particle.baseAlpha;

    glowGradient.addColorStop(
      0,
      `rgba(255,255,255,${Math.min(alpha + 0.20, 0.80)})`
    );
    glowGradient.addColorStop(
      0.22,
      `rgba(255,255,255,${alpha})`
    );
    glowGradient.addColorStop(
      0.46,
      'rgba(255,255,255,0.13)'
    );
    glowGradient.addColorStop(
      0.68,
      'rgba(255,255,255,0.045)'
    );
    glowGradient.addColorStop(
      1,
      'rgba(255,255,255,0)'
    );

    ctx.fillStyle = glowGradient;
    ctx.beginPath();
    ctx.arc(x, y, radius, 0, Math.PI * 2);
    ctx.fill();
  }

  const particles = createParticles();

  function animate(time) {
    if (!running) return;

    requestAnimationFrame(animate);

    if (time - lastFrame < frameInterval) {
      return;
    }

    const delta =
      Math.min(
        ((time - lastFrame) || frameInterval) / frameInterval,
        2
      );

    lastFrame = time;

    ctx.clearRect(0, 0, width, height);

    const seconds = time * 0.001;

    for (const particle of particles) {
      particle.x += particle.vx * delta;
      particle.y += particle.vy * delta;

      // Non-linear drift so particles do not move in straight lines.
      particle.x +=
        Math.sin(seconds * particle.driftX + particle.phaseX) *
        0.28 *
        delta;

      particle.y +=
        Math.cos(seconds * particle.driftY + particle.phaseY) *
        0.24 *
        delta;

      const pad = particle.size + CONFIG.wrapPadding;

      if (particle.x < -pad) particle.x = width + pad;
      if (particle.x > width + pad) particle.x = -pad;
      if (particle.y < -pad) particle.y = height + pad;
      if (particle.y > height + pad) particle.y = -pad;

      drawParticle(particle, time);
    }
  }

  function setPointer(x, y) {
    pointerX = x;
    pointerY = y;
  }

  function init() {
    canvas = getCanvas();

    ctx = canvas.getContext('2d', {
      alpha: true,
      desynchronized: true
    });

    if (!ctx) {
      console.warn('Canvas2D tidak tersedia.');
      return;
    }

    canvas.style.position = 'fixed';
    canvas.style.inset = '0';
    canvas.style.zIndex = '1';
    canvas.style.pointerEvents = 'none';
    canvas.style.display = 'block';
    canvas.style.opacity = '1';
    canvas.setAttribute('aria-hidden', 'true');

    resize();

    window.addEventListener('resize', resize, { passive: true });

    window.addEventListener(
      'pointermove',
      event => setPointer(event.clientX, event.clientY),
      { passive: true }
    );

    window.addEventListener(
      'touchmove',
      event => {
        const touch = event.touches && event.touches[0];
        if (touch) setPointer(touch.clientX, touch.clientY);
      },
      { passive: true }
    );

    window.addEventListener(
      'mouseleave',
      () => setPointer(width / 2, height / 2),
      { passive: true }
    );

    requestAnimationFrame(animate);
  }

  window.addEventListener('beforeunload', () => {
    running = false;
  }, { once: true });

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init, { once: true });
  } else {
    init();
  }
})();
