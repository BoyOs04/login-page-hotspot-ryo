/* =========================================================
   bokeh.js - Interactive 2D Bokeh Background
   Engine: Three.js r180 + Canvas2D fallback
   Tujuan:
   - bokeh lebih terlihat pada background terang
   - bayangan tipis di sekitar setiap bokeh
   - gerakan random / drifting
   - interaksi mouse + touch
   - tetap ringan untuk captive portal/mobile
========================================================= */

import * as THREE from './three.module.min.js';

(() => {
  'use strict';

  const CONFIG = {
    particleCount: 26,
    minSize: 90,
    maxSize: 250,
    minSpeedX: -0.65,
    maxSpeedX: 0.65,
    minSpeedY: -0.55,
    maxSpeedY: 0.55,
    targetFPS: 30,
    maxPixelRatio: 1.35,
    parallaxEase: 0.07,
    interactionRadius: 220,
    interactionStrength: 28,
    interactionEase: 0.07,
    pulseAmount: 0.055,
    wrapPadding: 280
  };

  let renderer = null;
  let scene = null;
  let camera = null;
  let canvas = null;
  let bokehs = [];

  let width = window.innerWidth;
  let height = window.innerHeight;

  let inputX = width / 2;
  let inputY = height / 2;
  let parallaxX = 0;
  let parallaxY = 0;
  let lastFrameTime = 0;
  let fallbackRunning = false;

  const frameInterval = 1000 / CONFIG.targetFPS;

  function getCanvas() {
    const existing = document.getElementById('bgCanvas');

    if (existing) {
      return existing;
    }

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

  function getCssColor(variable, fallback) {
    const value = getComputedStyle(document.documentElement)
      .getPropertyValue(variable)
      .trim();

    return /^#[0-9a-fA-F]{6}$/.test(value) ? value : fallback;
  }

  function createBokehTexture() {
    const size = 160;
    const textureCanvas = document.createElement('canvas');

    textureCanvas.width = size;
    textureCanvas.height = size;

    const ctx = textureCanvas.getContext('2d');
    const center = size / 2;

    const gradient = ctx.createRadialGradient(
      center,
      center,
      0,
      center,
      center,
      center
    );

    /*
     * Inti terang + pinggir yang benar-benar transparan.
     * Bayangan dibuat sebagai sprite kedua agar bokeh tetap
     * terlihat jelas di atas background warna cream/wheat.
     */
    gradient.addColorStop(0, 'rgba(255,255,255,0.95)');
    gradient.addColorStop(0.20, 'rgba(255,255,255,0.78)');
    gradient.addColorStop(0.42, 'rgba(255,255,255,0.40)');
    gradient.addColorStop(0.62, 'rgba(255,255,255,0.15)');
    gradient.addColorStop(0.78, 'rgba(255,255,255,0.045)');
    gradient.addColorStop(1, 'rgba(255,255,255,0)');

    ctx.fillStyle = gradient;
    ctx.fillRect(0, 0, size, size);

    const texture = new THREE.CanvasTexture(textureCanvas);
    texture.colorSpace = THREE.SRGBColorSpace;
    texture.needsUpdate = true;

    return texture;
  }

  function createParticlePosition() {
    /*
     * Mayoritas bokeh dikonsentrasikan di area tengah supaya
     * terasa seperti efek bokeh di belakang kartu login.
     */
    const centerX = width / 2;
    const centerY = height / 2;
    const maxRadius = Math.min(width, height) * 0.72;

    if (Math.random() < 0.78) {
      const angle = random(0, Math.PI * 2);
      const radius = Math.pow(Math.random(), 1.75) * maxRadius;

      return {
        x: centerX + Math.cos(angle) * radius,
        y: centerY + Math.sin(angle) * radius
      };
    }

    return {
      x: random(-CONFIG.wrapPadding, width + CONFIG.wrapPadding),
      y: random(-CONFIG.wrapPadding, height + CONFIG.wrapPadding)
    };
  }

  function createParticles() {
    const texture = createBokehTexture();
    const lightColor = new THREE.Color('#fff8e8');
    const shadowColor = new THREE.Color('#8b5e3c');

    for (let i = 0; i < CONFIG.particleCount; i++) {
      const size = random(CONFIG.minSize, CONFIG.maxSize);
      const start = createParticlePosition();

      const shadowMaterial = new THREE.SpriteMaterial({
        map: texture,
        color: shadowColor,
        transparent: true,
        opacity: random(0.055, 0.13),
        depthWrite: false,
        depthTest: false
      });

      const lightMaterial = new THREE.SpriteMaterial({
        map: texture,
        color: lightColor,
        transparent: true,
        opacity: random(0.30, 0.68),
        depthWrite: false,
        depthTest: false
      });

      const shadow = new THREE.Sprite(shadowMaterial);
      const light = new THREE.Sprite(lightMaterial);

      shadow.scale.set(size * 1.08, size * 1.08, 1);
      light.scale.set(size, size, 1);

      shadow.position.set(start.x + 4, start.y + 5, -1);
      light.position.set(start.x, start.y, 0);

      const data = {
        baseX: start.x,
        baseY: start.y,
        size,
        speedX: random(CONFIG.minSpeedX, CONFIG.maxSpeedX),
        speedY: random(CONFIG.minSpeedY, CONFIG.maxSpeedY),
        driftX: random(0.15, 0.75),
        driftY: random(0.15, 0.75),
        phaseX: random(0, Math.PI * 2),
        phaseY: random(0, Math.PI * 2),
        pulsePhase: random(0, Math.PI * 2),
        interactionX: 0,
        interactionY: 0,
        shadow,
        light,
        shadowOpacity: shadowMaterial.opacity,
        lightOpacity: lightMaterial.opacity
      };

      light.userData = data;
      shadow.userData = data;

      scene.add(shadow);
      scene.add(light);
      bokehs.push(light);
    }
  }

  function initThree() {
    canvas = getCanvas();

    canvas.style.position = 'fixed';
    canvas.style.inset = '0';
    canvas.style.width = '100%';
    canvas.style.height = '100%';
    canvas.style.display = 'block';
    canvas.style.pointerEvents = 'none';
    canvas.style.opacity = '1';

    scene = new THREE.Scene();

    camera = new THREE.OrthographicCamera(
      0,
      width,
      height,
      0,
      -100,
      100
    );

    camera.position.z = 10;

    try {
      renderer = new THREE.WebGLRenderer({
        canvas,
        alpha: true,
        antialias: true,
        powerPreference: 'low-power',
        premultipliedAlpha: true
      });
    } catch (error) {
      console.warn(
        'Three.js WebGL tidak tersedia. Menggunakan Canvas2D fallback.',
        error
      );
      return false;
    }

    renderer.setPixelRatio(
      Math.min(window.devicePixelRatio || 1, CONFIG.maxPixelRatio)
    );

    renderer.setSize(width, height, false);
    renderer.setClearColor(0x000000, 0);
    renderer.autoClear = true;

    createParticles();

    window.addEventListener('resize', handleResize, { passive: true });
    window.addEventListener('pointermove', handlePointerMove, { passive: true });
    window.addEventListener('touchmove', handleTouchMove, { passive: true });
    window.addEventListener('mouseleave', handlePointerLeave, { passive: true });

    requestAnimationFrame(animate);

    return true;
  }

  function animate(timestamp) {
    requestAnimationFrame(animate);

    if (timestamp - lastFrameTime < frameInterval) {
      return;
    }

    const delta = Math.min(
      (timestamp - lastFrameTime || frameInterval) / frameInterval,
      2
    );

    lastFrameTime = timestamp;

    parallaxX += (
      (inputX || width / 2) - width / 2 - parallaxX
    ) * CONFIG.parallaxEase;

    parallaxY += (
      (inputY || height / 2) - height / 2 - parallaxY
    ) * CONFIG.parallaxEase;

    const seconds = timestamp * 0.001;

    for (const light of bokehs) {
      const data = light.userData;

      data.baseX += data.speedX * delta;
      data.baseY += data.speedY * delta;

      /*
       * Gerakan random halus tambahan membuat particle
       * tidak terlihat seperti bergerak lurus.
       */
      data.baseX += Math.sin(seconds * data.driftX + data.phaseX) * 0.24 * delta;
      data.baseY += Math.cos(seconds * data.driftY + data.phaseY) * 0.22 * delta;

      wrapParticle(data);

      const dx = data.baseX - inputX;
      const dy = data.baseY - inputY;
      const distance = Math.sqrt(dx * dx + dy * dy);

      let targetInteractionX = 0;
      let targetInteractionY = 0;

      if (distance > 0 && distance < CONFIG.interactionRadius) {
        const strength =
          (1 - distance / CONFIG.interactionRadius) *
          CONFIG.interactionStrength;

        targetInteractionX = (dx / distance) * strength;
        targetInteractionY = (dy / distance) * strength;
      }

      data.interactionX += (
        targetInteractionX - data.interactionX
      ) * CONFIG.interactionEase;

      data.interactionY += (
        targetInteractionY - data.interactionY
      ) * CONFIG.interactionEase;

      const parallaxScale = data.size / 420;

      const finalX =
        data.baseX +
        parallaxX * 0.045 * parallaxScale +
        data.interactionX;

      const finalY =
        data.baseY +
        parallaxY * 0.045 * parallaxScale +
        data.interactionY;

      const pulse =
        1 +
        Math.sin(seconds * 1.15 + data.pulsePhase) *
        CONFIG.pulseAmount;

      data.light.scale.set(
        data.size * pulse,
        data.size * pulse,
        1
      );

      data.shadow.scale.set(
        data.size * pulse * 1.08,
        data.size * pulse * 1.08,
        1
      );

      data.light.material.opacity =
        data.lightOpacity *
        (0.92 + pulse * 0.08);

      data.shadow.material.opacity =
        data.shadowOpacity *
        (0.94 + pulse * 0.06);

      data.light.position.set(finalX, finalY, 0);
      data.shadow.position.set(finalX + 4, finalY + 5, -1);
    }

    renderer.render(scene, camera);
  }

  function wrapParticle(data) {
    const pad = data.size + CONFIG.wrapPadding;

    if (data.baseX < -pad) {
      data.baseX = width + pad;
    } else if (data.baseX > width + pad) {
      data.baseX = -pad;
    }

    if (data.baseY < -pad) {
      data.baseY = height + pad;
    } else if (data.baseY > height + pad) {
      data.baseY = -pad;
    }
  }

  function handleResize() {
    width = window.innerWidth;
    height = window.innerHeight;

    if (camera) {
      camera.right = width;
      camera.top = height;
      camera.updateProjectionMatrix();
    }

    if (renderer) {
      renderer.setPixelRatio(
        Math.min(window.devicePixelRatio || 1, CONFIG.maxPixelRatio)
      );

      renderer.setSize(width, height, false);
    }
  }

  function handlePointerMove(event) {
    inputX = event.clientX;
    inputY = event.clientY;
  }

  function handleTouchMove(event) {
    const touch = event.touches && event.touches[0];

    if (!touch) {
      return;
    }

    inputX = touch.clientX;
    inputY = touch.clientY;
  }

  function handlePointerLeave() {
    inputX = width / 2;
    inputY = height / 2;
  }

  function initCanvasFallback() {
    canvas = getCanvas();

    const ctx = canvas.getContext('2d', {
      alpha: true,
      desynchronized: true
    });

    if (!ctx) {
      return;
    }

    fallbackRunning = true;

    const particles = Array.from(
      { length: Math.min(CONFIG.particleCount, 22) },
      () => {
        const start = createParticlePosition();
        const size = random(CONFIG.minSize * 0.7, CONFIG.maxSize * 0.85);

        return {
          x: start.x,
          y: start.y,
          size,
          vx: random(CONFIG.minSpeedX, CONFIG.maxSpeedX),
          vy: random(CONFIG.minSpeedY, CONFIG.maxSpeedY),
          phase: random(0, Math.PI * 2),
          alpha: random(0.26, 0.55),
          shadowAlpha: random(0.045, 0.10)
        };
      }
    );

    function resizeFallback() {
      const ratio = Math.min(window.devicePixelRatio || 1, 1.35);

      width = window.innerWidth;
      height = window.innerHeight;

      canvas.width = Math.round(width * ratio);
      canvas.height = Math.round(height * ratio);
      canvas.style.width = '100%';
      canvas.style.height = '100%';

      ctx.setTransform(ratio, 0, 0, ratio, 0, 0);
    }

    function drawFallback(timestamp) {
      if (!fallbackRunning) {
        return;
      }

      requestAnimationFrame(drawFallback);

      if (timestamp - lastFrameTime < frameInterval) {
        return;
      }

      const delta = Math.min(
        (timestamp - lastFrameTime || frameInterval) / frameInterval,
        2
      );

      lastFrameTime = timestamp;

      ctx.clearRect(0, 0, width, height);

      const seconds = timestamp * 0.001;

      for (const particle of particles) {
        particle.x += particle.vx * delta;
        particle.y += particle.vy * delta;

        particle.x += Math.sin(seconds * 0.45 + particle.phase) * 0.18 * delta;
        particle.y += Math.cos(seconds * 0.40 + particle.phase) * 0.16 * delta;

        const dx = particle.x - inputX;
        const dy = particle.y - inputY;
        const distance = Math.sqrt(dx * dx + dy * dy);

        if (distance > 0 && distance < CONFIG.interactionRadius) {
          const force =
            (1 - distance / CONFIG.interactionRadius) * 0.45;

          particle.x += (dx / distance) * force * 20;
          particle.y += (dy / distance) * force * 20;
        }

        if (particle.x < -particle.size) particle.x = width + particle.size;
        if (particle.x > width + particle.size) particle.x = -particle.size;
        if (particle.y < -particle.size) particle.y = height + particle.size;
        if (particle.y > height + particle.size) particle.y = -particle.size;

        const radius = particle.size / 2;

        const shadow = ctx.createRadialGradient(
          particle.x + 5,
          particle.y + 6,
          0,
          particle.x + 5,
          particle.y + 6,
          radius
        );

        shadow.addColorStop(0, `rgba(92,51,18,${particle.shadowAlpha})`);
        shadow.addColorStop(0.72, 'rgba(92,51,18,0.025)');
        shadow.addColorStop(1, 'rgba(92,51,18,0)');

        ctx.fillStyle = shadow;
        ctx.beginPath();
        ctx.arc(
          particle.x + 5,
          particle.y + 6,
          radius,
          0,
          Math.PI * 2
        );
        ctx.fill();

        const glow = ctx.createRadialGradient(
          particle.x,
          particle.y,
          0,
          particle.x,
          particle.y,
          radius
        );

        glow.addColorStop(0, `rgba(255,255,255,${particle.alpha})`);
        glow.addColorStop(0.45, 'rgba(255,255,255,0.22)');
        glow.addColorStop(0.74, 'rgba(255,255,255,0.05)');
        glow.addColorStop(1, 'rgba(255,255,255,0)');

        ctx.fillStyle = glow;
        ctx.beginPath();
        ctx.arc(particle.x, particle.y, radius, 0, Math.PI * 2);
        ctx.fill();
      }
    }

    window.addEventListener('resize', resizeFallback, { passive: true });
    window.addEventListener('pointermove', handlePointerMove, { passive: true });
    window.addEventListener('touchmove', handleTouchMove, { passive: true });

    resizeFallback();
    drawFallback(0);
  }

  function random(min, max) {
    return Math.random() * (max - min) + min;
  }

  function init() {
    const webglStarted = initThree();

    if (!webglStarted) {
      initCanvasFallback();
    }
  }

  window.addEventListener('beforeunload', () => {
    fallbackRunning = false;

    for (const light of bokehs) {
      const data = light.userData;

      data.light?.material?.map?.dispose?.();
      data.light?.material?.dispose?.();
      data.shadow?.material?.dispose?.();
    }

    renderer?.dispose?.();
  });

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init, { once: true });
  } else {
    init();
  }
})();
