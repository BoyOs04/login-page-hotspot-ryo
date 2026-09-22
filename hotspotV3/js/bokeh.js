/* =========================================================
   bokeh.js - Interactive 2D Wheat Bokeh Background
   Engine: Canvas2D
   - animated wheat gradient base
   - random moving gradient blobs
   - touch / pointer reactive gradient
   - high-visibility soft bokeh
   - touch impulse + pointer parallax
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

    interactionRadius: 235,
    interactionStrength: 30,
    interactionEase: 0.075,

    touchRadius: 320,
    touchStrength: 90,
    touchEase: 0.055,
    touchFade: 0.965,

    pulseAmount: 0.055,
    wrapPadding: 260,

    gradientTargetMinMs: 4200,
    gradientTargetMaxMs: 7800
  };

  const WHEAT = {
    // Pure wheat + white palette.
    baseA: '#ffffff',
    baseB: '#fffaf0',
    baseC: '#f5deb3',
    baseD: '#ffffff',

    // White / wheat moving highlights.
    glowA: 'rgba(255, 255, 255, 0.94)',
    glowB: 'rgba(245, 222, 179, 0.76)',
    glowC: 'rgba(255, 255, 255, 0.54)',

    // Touch highlight and subtle wheat depth.
    touchGlow: 'rgba(255, 255, 255, 0.60)',
    touchCore: 'rgba(245, 222, 179, 0.40)',
    shadow: 'rgba(139, 69, 19, 0.12)'
  };

  let canvas = null;
  let ctx = null;
  let width = window.innerWidth;
  let height = window.innerHeight;
  let dpr = Math.min(
    window.devicePixelRatio || 1,
    CONFIG.maxPixelRatio
  );

  let pointerX = width / 2;
  let pointerY = height / 2;
  let pointerVX = 0;
  let pointerVY = 0;
  let previousPointerX = pointerX;
  let previousPointerY = pointerY;
  let pointerActive = false;

  let touchX = width / 2;
  let touchY = height / 2;
  let touchEnergy = 0;

  let lastFrame = 0;
  let running = true;

  const frameInterval = 1000 / CONFIG.targetFPS;

  const gradientBlobs = [
    {
      x: 0.18,
      y: 0.20,
      tx: 0.18,
      ty: 0.20,
      radius: 0.72,
      phase: Math.random() * Math.PI * 2,
      nextTarget: 0,
      interactionX: 0,
      interactionY: 0,
      impulseX: 0,
      impulseY: 0
    },
    {
      x: 0.78,
      y: 0.28,
      tx: 0.78,
      ty: 0.28,
      radius: 0.66,
      phase: Math.random() * Math.PI * 2,
      nextTarget: 0,
      interactionX: 0,
      interactionY: 0,
      impulseX: 0,
      impulseY: 0
    },
    {
      x: 0.58,
      y: 0.78,
      tx: 0.58,
      ty: 0.78,
      radius: 0.76,
      phase: Math.random() * Math.PI * 2,
      nextTarget: 0,
      interactionX: 0,
      interactionY: 0,
      impulseX: 0,
      impulseY: 0
    }
  ];

  function getCanvas() {
    const existing =
      document.getElementById('bgCanvas');

    if (existing) return existing;

    const container =
      document.getElementById(
        'bgCanvas-container'
      );

    if (container) {
      const created =
        document.createElement('canvas');

      created.id = 'bgCanvas';
      container.appendChild(created);

      return created;
    }

    const created =
      document.createElement('canvas');

    created.id = 'bgCanvas';
    document.body.prepend(created);

    return created;
  }

  function resize() {
    width = window.innerWidth;
    height = window.innerHeight;

    dpr = Math.min(
      window.devicePixelRatio || 1,
      CONFIG.maxPixelRatio
    );

    canvas.width =
      Math.max(
        1,
        Math.round(width * dpr)
      );

    canvas.height =
      Math.max(
        1,
        Math.round(height * dpr)
      );

    canvas.style.width = '100vw';
    canvas.style.height = '100vh';

    ctx.setTransform(
      dpr,
      0,
      0,
      dpr,
      0,
      0
    );

    pointerX = Math.min(pointerX, width);
    pointerY = Math.min(pointerY, height);
  }

  function random(min, max) {
    return (
      Math.random() *
        (max - min) +
      min
    );
  }

  function clamp(value, min, max) {
    return Math.max(
      min,
      Math.min(max, value)
    );
  }

  function retargetGradientBlob(blob, time) {
    if (time < blob.nextTarget) return;

    blob.tx = random(0.08, 0.92);
    blob.ty = random(0.08, 0.92);

    blob.nextTarget =
      time +
      random(
        CONFIG.gradientTargetMinMs,
        CONFIG.gradientTargetMaxMs
      );
  }

  function updateGradientBlobs(time) {
    const pointerNX =
      pointerX / Math.max(width, 1);

    const pointerNY =
      pointerY / Math.max(height, 1);

    for (const blob of gradientBlobs) {
      retargetGradientBlob(blob, time);

      // Slow random movement.
      blob.x +=
        (blob.tx - blob.x) *
        0.0028;

      blob.y +=
        (blob.ty - blob.y) *
        0.0028;

      // Organic drift.
      blob.x +=
        Math.sin(
          time * 0.00013 +
          blob.phase
        ) *
        0.00055;

      blob.y +=
        Math.cos(
          time * 0.00011 +
          blob.phase
        ) *
        0.00045;

      // Pointer/touch parallax.
      const parallaxX =
        (pointerNX - 0.5) *
        (0.035 + touchEnergy * 0.045);

      const parallaxY =
        (pointerNY - 0.5) *
        (0.030 + touchEnergy * 0.040);

      blob.interactionX +=
        (parallaxX - blob.interactionX) *
        0.045;

      blob.interactionY +=
        (parallaxY - blob.interactionY) *
        0.045;

      // Touch creates a short directional impulse.
      blob.impulseX +=
        pointerVX *
        touchEnergy *
        0.00010;

      blob.impulseY +=
        pointerVY *
        touchEnergy *
        0.00010;

      blob.impulseX *= 0.94;
      blob.impulseY *= 0.94;

      blob.x += blob.interactionX;
      blob.y += blob.interactionY;

      blob.x += blob.impulseX;
      blob.y += blob.impulseY;

      blob.x = clamp(blob.x, -0.15, 1.15);
      blob.y = clamp(blob.y, -0.15, 1.15);
    }

    // Touch energy fades naturally.
    touchEnergy *= CONFIG.touchFade;

    if (touchEnergy < 0.001) {
      touchEnergy = 0;
    }
  }

  function drawTouchGlow(time) {
    if (touchEnergy <= 0.001) return;

    const pulse =
      1 +
      Math.sin(time * 0.007) *
      0.05;

    const radius =
      CONFIG.touchRadius *
      (0.72 + touchEnergy * 0.55) *
      pulse;

    const gradient =
      ctx.createRadialGradient(
        touchX,
        touchY,
        0,
        touchX,
        touchY,
        radius
      );

    const energy =
      Math.min(touchEnergy, 1);

    gradient.addColorStop(
      0,
      `rgba(255,247,214,${0.26 * energy})`
    );

    gradient.addColorStop(
      0.28,
      `rgba(255,226,150,${0.16 * energy})`
    );

    gradient.addColorStop(
      0.65,
      `rgba(232,185,111,${0.08 * energy})`
    );

    gradient.addColorStop(
      1,
      'rgba(255,255,255,0)'
    );

    ctx.fillStyle = gradient;

    ctx.beginPath();
    ctx.arc(
      touchX,
      touchY,
      radius,
      0,
      Math.PI * 2
    );
    ctx.fill();
  }

  function drawAnimatedBackground(time) {
    updateGradientBlobs(time);

    const angle =
      time * 0.000035 +
      Math.sin(time * 0.00012) *
        0.35 +
      pointerVX *
        0.000015;

    const length =
      Math.hypot(
        width,
        height
      );

    const cx = width * 0.5;
    const cy = height * 0.5;

    const x1 =
      cx -
      Math.cos(angle) *
        length;

    const y1 =
      cy -
      Math.sin(angle) *
        length;

    const x2 =
      cx +
      Math.cos(angle) *
        length;

    const y2 =
      cy +
      Math.sin(angle) *
        length;

    const baseGradient =
      ctx.createLinearGradient(
        x1,
        y1,
        x2,
        y2
      );

    baseGradient.addColorStop(
      0,
      WHEAT.baseA
    );

    baseGradient.addColorStop(
      0.42,
      WHEAT.baseB
    );

    baseGradient.addColorStop(
      0.72,
      WHEAT.baseC
    );

    baseGradient.addColorStop(
      1,
      WHEAT.baseD
    );

    ctx.fillStyle =
      baseGradient;

    ctx.fillRect(
      0,
      0,
      width,
      height
    );

    const blobColors = [
      WHEAT.glowA,
      WHEAT.glowB,
      WHEAT.glowC
    ];

    gradientBlobs.forEach(
      (blob, index) => {
        const x =
          blob.x * width;

        const y =
          blob.y * height;

        const radius =
          Math.max(
            width,
            height
          ) * blob.radius;

        const radial =
          ctx.createRadialGradient(
            x,
            y,
            0,
            x,
            y,
            radius
          );

        radial.addColorStop(
          0,
          blobColors[index]
        );

        radial.addColorStop(
          0.48,
          blobColors[index]
        );

        radial.addColorStop(
          1,
          'rgba(255,255,255,0)'
        );

        ctx.fillStyle =
          radial;

        ctx.fillRect(
          x - radius,
          y - radius,
          radius * 2,
          radius * 2
        );
      }
    );

    drawTouchGlow(time);

    // Subtle edge shading.
    const vignette =
      ctx.createRadialGradient(
        cx,
        cy,
        Math.min(
          width,
          height
        ) * 0.18,
        cx,
        cy,
        Math.max(
          width,
          height
        ) * 0.82
      );

    vignette.addColorStop(
      0,
      'rgba(255,255,255,0)'
    );

    vignette.addColorStop(
      0.72,
      'rgba(92,51,18,0.015)'
    );

    vignette.addColorStop(
      1,
      WHEAT.shadow
    );

    ctx.fillStyle =
      vignette;

    ctx.fillRect(
      0,
      0,
      width,
      height
    );
  }

  function createParticle() {
    const centerX =
      width / 2;

    const centerY =
      height / 2;

    const radius =
      Math.min(
        width,
        height
      ) * 0.70;

    let x;
    let y;

    if (Math.random() < 0.82) {
      const angle =
        random(
          0,
          Math.PI * 2
        );

      const distance =
        Math.pow(
          Math.random(),
          1.7
        ) * radius;

      x =
        centerX +
        Math.cos(angle) *
          distance;

      y =
        centerY +
        Math.sin(angle) *
          distance;
    } else {
      x = random(
        -CONFIG.wrapPadding,
        width + CONFIG.wrapPadding
      );

      y = random(
        -CONFIG.wrapPadding,
        height + CONFIG.wrapPadding
      );
    }

    return {
      x,
      y,
      size: random(
        CONFIG.minSize,
        CONFIG.maxSize
      ),

      vx: random(
        CONFIG.minSpeedX,
        CONFIG.maxSpeedX
      ),

      vy: random(
        CONFIG.minSpeedY,
        CONFIG.maxSpeedY
      ),

      driftX: random(
        0.25,
        0.75
      ),

      driftY: random(
        0.20,
        0.65
      ),

      phaseX: random(
        0,
        Math.PI * 2
      ),

      phaseY: random(
        0,
        Math.PI * 2
      ),

      pulsePhase: random(
        0,
        Math.PI * 2
      ),

      baseAlpha: random(
        0.70,
        0.88
      ),

      interactionX: 0,
      interactionY: 0,
      impulseX: 0,
      impulseY: 0
    };
  }

  function createParticles() {
    return Array.from(
      {
        length:
          CONFIG.particleCount
      },
      createParticle
    );
  }

  function applyTouchForce(particle) {
    if (touchEnergy <= 0.001) {
      return;
    }

    const dx =
      particle.x -
      touchX;

    const dy =
      particle.y -
      touchY;

    const distance =
      Math.hypot(dx, dy);

    if (
      distance <= 0 ||
      distance >=
        CONFIG.touchRadius
    ) {
      return;
    }

    const force =
      (1 -
        distance /
          CONFIG.touchRadius) *
      CONFIG.touchStrength *
      touchEnergy;

    particle.impulseX +=
      (dx / distance) *
      force *
      0.018;

    particle.impulseY +=
      (dy / distance) *
      force *
      0.018;
  }

  function drawParticle(
    particle,
    time
  ) {
    const pulse =
      1 +
      Math.sin(
        time * 0.0012 +
        particle.pulsePhase
      ) *
      CONFIG.pulseAmount;

    const size =
      particle.size *
      pulse;

    const radius =
      size * 0.50;

    const dx =
      particle.x -
      pointerX;

    const dy =
      particle.y -
      pointerY;

    const distance =
      Math.hypot(dx, dy);

    let targetX = 0;
    let targetY = 0;

    if (
      distance > 0 &&
      distance <
        CONFIG.interactionRadius
    ) {
      const force =
        (1 -
          distance /
            CONFIG.interactionRadius) *
        CONFIG.interactionStrength;

      targetX =
        (dx / distance) *
        force;

      targetY =
        (dy / distance) *
        force;
    }

    particle.interactionX +=
      (targetX -
        particle.interactionX) *
      CONFIG.interactionEase;

    particle.interactionY +=
      (targetY -
        particle.interactionY) *
      CONFIG.interactionEase;

    // Touch impulse adds a stronger, short movement.
    particle.impulseX +=
      pointerVX *
      touchEnergy *
      0.010;

    particle.impulseY +=
      pointerVY *
      touchEnergy *
      0.010;

    particle.impulseX *= 0.94;
    particle.impulseY *= 0.94;

    const x =
      particle.x +
      particle.interactionX +
      particle.impulseX;

    const y =
      particle.y +
      particle.interactionY +
      particle.impulseY;

    // Thin warm shadow.
    const shadowGradient =
      ctx.createRadialGradient(
        x + 7,
        y + 9,
        0,
        x + 7,
        y + 9,
        radius
      );

    shadowGradient.addColorStop(
      0,
      'rgba(92,51,18,0.26)'
    );

    shadowGradient.addColorStop(
      0.42,
      'rgba(92,51,18,0.17)'
    );

    shadowGradient.addColorStop(
      0.72,
      'rgba(92,51,18,0.075)'
    );

    shadowGradient.addColorStop(
      1,
      'rgba(92,51,18,0)'
    );

    ctx.fillStyle =
      shadowGradient;

    ctx.beginPath();

    ctx.arc(
      x + 7,
      y + 9,
      radius,
      0,
      Math.PI * 2
    );

    ctx.fill();

    // High-visibility soft bokeh.
    const glowGradient =
      ctx.createRadialGradient(
        x,
        y,
        0,
        x,
        y,
        radius
      );

    const alpha =
      particle.baseAlpha;

    glowGradient.addColorStop(
      0,
      `rgba(255,255,255,${Math.min(
        alpha + 0.12,
        0.98
      )})`
    );

    glowGradient.addColorStop(
      0.20,
      `rgba(255,252,244,${alpha})`
    );

    glowGradient.addColorStop(
      0.44,
      'rgba(255,255,255,0.34)'
    );

    glowGradient.addColorStop(
      0.68,
      'rgba(255,250,240,0.14)'
    );

    glowGradient.addColorStop(
      0.88,
      'rgba(255,255,255,0.035)'
    );

    glowGradient.addColorStop(
      1,
      'rgba(255,255,255,0)'
    );

    ctx.fillStyle =
      glowGradient;

    ctx.beginPath();

    ctx.arc(
      x,
      y,
      radius,
      0,
      Math.PI * 2
    );

    ctx.fill();
  }

  const particles =
    createParticles();

  function animate(time) {
    if (!running) return;

    requestAnimationFrame(
      animate
    );

    if (
      time - lastFrame <
      frameInterval
    ) {
      return;
    }

    const delta =
      Math.min(
        ((time - lastFrame) ||
          frameInterval) /
          frameInterval,
        2
      );

    lastFrame = time;

    ctx.clearRect(
      0,
      0,
      width,
      height
    );

    drawAnimatedBackground(
      time
    );

    const seconds =
      time * 0.001;

    for (
      const particle of particles
    ) {
      applyTouchForce(
        particle
      );

      particle.x +=
        particle.vx *
        delta;

      particle.y +=
        particle.vy *
        delta;

      // Non-linear drift.
      particle.x +=
        Math.sin(
          seconds *
            particle.driftX +
            particle.phaseX
        ) *
        0.28 *
        delta;

      particle.y +=
        Math.cos(
          seconds *
            particle.driftY +
            particle.phaseY
        ) *
        0.24 *
        delta;

      const pad =
        particle.size +
        CONFIG.wrapPadding;

      if (particle.x < -pad) {
        particle.x =
          width + pad;
      }

      if (
        particle.x >
        width + pad
      ) {
        particle.x = -pad;
      }

      if (particle.y < -pad) {
        particle.y =
          height + pad;
      }

      if (
        particle.y >
        height + pad
      ) {
        particle.y = -pad;
      }

      drawParticle(
        particle,
        time
      );
    }

    pointerVX *= 0.88;
    pointerVY *= 0.88;

    if (!pointerActive) {
      pointerX +=
        (width / 2 -
          pointerX) *
        0.012;

      pointerY +=
        (height / 2 -
          pointerY) *
        0.012;
    }
  }

  function setPointer(
    x,
    y,
    interaction = false
  ) {
    const dx =
      x -
      previousPointerX;

    const dy =
      y -
      previousPointerY;

    pointerVX =
      clamp(dx, -30, 30);

    pointerVY =
      clamp(dy, -30, 30);

    pointerX = x;
    pointerY = y;

    if (interaction) {
      touchX = x;
      touchY = y;

      touchEnergy = Math.min(
        1,
        touchEnergy +
          0.42
      );
    }

    previousPointerX = x;
    previousPointerY = y;
  }

  function pointerDown(x, y) {
    pointerActive = true;

    touchX = x;
    touchY = y;

    touchEnergy = 1;

    // Push every gradient blob away from the touch point.
    for (
      const blob of gradientBlobs
    ) {
      const dx =
        blob.x * width -
        x;

      const dy =
        blob.y * height -
        y;

      const distance =
        Math.max(
          30,
          Math.hypot(
            dx,
            dy
          )
        );

      blob.impulseX +=
        (dx / distance) *
        0.018;

      blob.impulseY +=
        (dy / distance) *
        0.018;
    }
  }

  function pointerUp() {
    pointerActive = false;
  }

  function init() {
    canvas =
      getCanvas();

    ctx =
      canvas.getContext(
        '2d',
        {
          alpha: true,
          desynchronized: true
        }
      );

    if (!ctx) {
      console.warn(
        'Canvas2D tidak tersedia.'
      );
      return;
    }

    canvas.style.position =
      'fixed';

    canvas.style.inset = '0';
    canvas.style.zIndex = '1';
    canvas.style.pointerEvents =
      'none';

    canvas.style.display =
      'block';

    canvas.style.opacity =
      '1';

    canvas.setAttribute(
      'aria-hidden',
      'true'
    );

    resize();

    window.addEventListener(
      'resize',
      resize,
      { passive: true }
    );

    window.addEventListener(
      'pointermove',
      event =>
        setPointer(
          event.clientX,
          event.clientY,
          pointerActive
        ),
      { passive: true }
    );

    window.addEventListener(
      'pointerdown',
      event =>
        pointerDown(
          event.clientX,
          event.clientY
        ),
      { passive: true }
    );

    window.addEventListener(
      'pointerup',
      pointerUp,
      { passive: true }
    );

    window.addEventListener(
      'pointercancel',
      pointerUp,
      { passive: true }
    );

    // Touch fallback for browsers that do not expose
    // pointer events consistently.
    window.addEventListener(
      'touchstart',
      event => {
        const touch =
          event.touches &&
          event.touches[0];

        if (!touch) return;

        pointerDown(
          touch.clientX,
          touch.clientY
        );

        setPointer(
          touch.clientX,
          touch.clientY,
          true
        );
      },
      { passive: true }
    );

    window.addEventListener(
      'touchmove',
      event => {
        const touch =
          event.touches &&
          event.touches[0];

        if (!touch) return;

        setPointer(
          touch.clientX,
          touch.clientY,
          true
        );
      },
      { passive: true }
    );

    window.addEventListener(
      'touchend',
      pointerUp,
      { passive: true }
    );

    window.addEventListener(
      'mouseleave',
      () => {
        pointerActive = false;
        pointerVX = 0;
        pointerVY = 0;
      },
      { passive: true }
    );

    requestAnimationFrame(
      animate
    );
  }

  window.addEventListener(
    'beforeunload',
    () => {
      running = false;
    },
    { once: true }
  );

  if (
    document.readyState ===
    'loading'
  ) {
    document.addEventListener(
      'DOMContentLoaded',
      init,
      { once: true }
    );
  } else {
    init();
  }
})();
