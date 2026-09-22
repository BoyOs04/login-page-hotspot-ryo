/* =========================================================
   bokeh.js - Three.js 2D Bokeh Background
   Engine: Three.js r180
   Tujuan: menggantikan P5.js dengan background bokeh 2D
   yang ringan untuk captive portal / perangkat mobile.
========================================================= */

import * as THREE from './three.module.min.js';

(() => {
  'use strict';

  /* ===== KONFIGURASI ANIMASI ===== */
  const CONFIG = {
    particleCount: 25,
    minSize: 85,
    maxSize: 300,
    minSpeedX: -2,
    maxSpeedX: 1.5,
    minSpeedY: -2,
    maxSpeedY: 1,
    targetFPS: 30,
    maxPixelRatio: 1.5,
    parallaxEase: 0.05
  };

  let renderer;
  let scene;
  let camera;
  let bokehs = [];
  let canvas;
  let width = window.innerWidth;
  let height = window.innerHeight;

  let inputX = width / 2;
  let inputY = height / 2;
  let parallaxX = 0;
  let parallaxY = 0;

  let lastFrameTime = 0;
  const frameInterval = 1000 / CONFIG.targetFPS;

  /* ===== WARNA DARI CSS :root ===== */
  function getThemeColor() {
    const root = getComputedStyle(document.documentElement);
    const value = root.getPropertyValue('--color-wheat').trim();

    if (/^#[0-9a-fA-F]{6}$/.test(value)) {
      return value;
    }

    return '#f5deb3';
  }

  /* ===== BUAT TEKSTUR BULAT BOKEH 2D ===== */
  function createBokehTexture() {
    const size = 128;
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

    gradient.addColorStop(0, 'rgba(255,255,255,0.55)');
    gradient.addColorStop(0.45, 'rgba(255,255,255,0.25)');
    gradient.addColorStop(0.72, 'rgba(255,255,255,0.08)');
    gradient.addColorStop(1, 'rgba(255,255,255,0)');

    ctx.fillStyle = gradient;
    ctx.fillRect(0, 0, size, size);

    const texture = new THREE.CanvasTexture(textureCanvas);
    texture.colorSpace = THREE.SRGBColorSpace;
    texture.needsUpdate = true;

    return texture;
  }

  /* ===== BUAT CANVAS JIKA BELUM ADA ===== */
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

  /* ===== INISIALISASI THREE.JS ===== */
  function init() {
    canvas = getCanvas();

    scene = new THREE.Scene();

    /* OrthographicCamera membuat seluruh efek benar-benar 2D. */
    camera = new THREE.OrthographicCamera(
      0,
      width,
      height,
      0,
      -100,
      100
    );
    camera.position.z = 10;

    renderer = new THREE.WebGLRenderer({
      canvas,
      alpha: true,
      antialias: false,
      powerPreference: 'low-power'
    });

    renderer.setPixelRatio(
      Math.min(window.devicePixelRatio || 1, CONFIG.maxPixelRatio)
    );
    renderer.setSize(width, height, false);
    renderer.setClearColor(0x000000, 0);

    createParticles();

    window.addEventListener('resize', handleResize, { passive: true });
    window.addEventListener('pointermove', handlePointerMove, { passive: true });
    window.addEventListener('touchmove', handleTouchMove, { passive: true });

    requestAnimationFrame(animate);
  }

  /* ===== PARTIKEL BOKEH ===== */
  function createParticles() {
    const texture = createBokehTexture();
    const color = new THREE.Color(getThemeColor());

    for (let i = 0; i < CONFIG.particleCount; i++) {
      const size = random(CONFIG.minSize, CONFIG.maxSize);

      const material = new THREE.SpriteMaterial({
        map: texture,
        color,
        transparent: true,
        opacity: random(0.18, 0.48),
        depthWrite: false,
        depthTest: false
      });

      const sprite = new THREE.Sprite(material);

      sprite.scale.set(size, size, 1);
      sprite.position.set(
        random(-width, width * 2),
        random(-height, height * 2),
        random(-5, 5)
      );

      sprite.userData = {
        size,
        speedX: random(CONFIG.minSpeedX, CONFIG.maxSpeedX),
        speedY: random(CONFIG.minSpeedY, CONFIG.maxSpeedY),
        baseOpacity: material.opacity
      };

      scene.add(sprite);
      bokehs.push(sprite);
    }
  }

  /* ===== LOOP ANIMASI ===== */
  function animate(timestamp) {
    requestAnimationFrame(animate);

    if (timestamp - lastFrameTime < frameInterval) {
      return;
    }

    lastFrameTime = timestamp;

    parallaxX += (
      (inputX || width / 2) - width / 2 - parallaxX
    ) * CONFIG.parallaxEase;

    parallaxY += (
      (inputY || height / 2) - height / 2 - parallaxY
    ) * CONFIG.parallaxEase;

    for (const sprite of bokehs) {
      const data = sprite.userData;

      sprite.position.x += data.speedX;
      sprite.position.y += data.speedY;

      const offsetScale = data.size / 500;

      const renderX =
        sprite.position.x +
        parallaxX * offsetScale;

      const renderY =
        sprite.position.y +
        parallaxY * offsetScale;

      /* Wrap horizontal. */
      if (sprite.position.x < -data.size) {
        sprite.position.x = width + data.size;
      } else if (sprite.position.x > width + data.size) {
        sprite.position.x = -data.size;
      }

      /* Wrap vertical. */
      if (sprite.position.y < -data.size) {
        sprite.position.y = height + data.size;
      } else if (sprite.position.y > height + data.size) {
        sprite.position.y = -data.size;
      }

      /* Sprite hanya bergerak secara visual 2D. */
      sprite.position.set(renderX, renderY, sprite.position.z);

      /*
       * Posisi sebelumnya ikut dipakai sebagai offset visual.
       * Kembalikan koordinat dasar agar parallax tidak menumpuk.
       */
      sprite.position.x -= parallaxX * offsetScale;
      sprite.position.y -= parallaxY * offsetScale;
    }

    renderer.render(scene, camera);
  }

  /* ===== RESPONSIVE ===== */
  function handleResize() {
    width = window.innerWidth;
    height = window.innerHeight;

    camera.right = width;
    camera.top = height;
    camera.updateProjectionMatrix();

    renderer.setPixelRatio(
      Math.min(window.devicePixelRatio || 1, CONFIG.maxPixelRatio)
    );
    renderer.setSize(width, height, false);
  }

  /* ===== MOUSE / POINTER ===== */
  function handlePointerMove(event) {
    inputX = event.clientX;
    inputY = event.clientY;
  }

  /* ===== TOUCH ===== */
  function handleTouchMove(event) {
    const touch = event.touches && event.touches[0];

    if (!touch) {
      return;
    }

    inputX = touch.clientX;
    inputY = touch.clientY;
  }

  /* ===== HELPER RANDOM ===== */
  function random(min, max) {
    return Math.random() * (max - min) + min;
  }

  /* ===== START ===== */
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init, { once: true });
  } else {
    init();
  }

  /* ===== CLEANUP ===== */
  window.addEventListener('beforeunload', () => {
    for (const sprite of bokehs) {
      sprite.material.dispose();
    }

    renderer?.dispose();
  });
})();
