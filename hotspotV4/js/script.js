/* =====================================================
   js/script.js - Logika UI Login Hotspot
   Author: Ryo Rumagit (Linelejan)
===================================================== */

/* 1. Fungsi: Menampilkan Notifikasi (Toast) */
function showToast(message, duration = 1000) {
  const toast = document.getElementById('toast');
  if (!toast) return;
  toast.textContent = message;
  toast.classList.add('show');
  clearTimeout(toast._timeout);
  toast._timeout = setTimeout(() => {
    toast.classList.remove('show');
  }, duration);
}

/* 2. Fungsi: Salin Teks (Fallback Method) */
function fallbackCopy(text) {
  const ta = document.createElement('textarea');
  ta.value = text;
  ta.style.position = 'fixed';
  ta.style.left = '-9999px';
  document.body.appendChild(ta);
  ta.focus();
  ta.select();
  try {
    document.execCommand('copy');
    showToast('Berhasil disalin!', 1000);
  } catch (err) {
    showToast('Gagal menyalin!', 1000);
  }
  document.body.removeChild(ta);
}

/* =====================================================
   3. Fungsi: Jam Interaktif (Mode Normal & Mode Zona Waktu)
===================================================== */
let is12HourFormat = false;
let tzMode = false;
let currentTzIdx = 0;

const tzList = [
  { id: 'Asia/Jakarta', label: 'WIB' },
  { id: 'Asia/Makassar', label: 'WITA' },
  { id: 'Asia/Jayapura', label: 'WIT' },
  { id: 'America/Chicago', label: 'Texas (CT)' },
  { id: 'America/New_York', label: 'Florida (ET)' }
];

function updateClock() {
  const timeEl = document.getElementById('clock-time');
  const dateEl = document.getElementById('clock-date');
  if (!timeEl || !dateEl) return;

  const now = new Date();

  let timeOptions = {
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
    fractionalSecondDigits: 3,
    hour12: is12HourFormat
  };

  if (tzMode) {
    timeOptions.timeZone = tzList[currentTzIdx].id;
  }

  const locale = is12HourFormat ? 'en-US' : 'id-ID';
  let timeString = now.toLocaleTimeString(locale, timeOptions);

  if (tzMode) {
    timeString = `${timeString} ${tzList[currentTzIdx].label}`;
  }

  timeEl.textContent = timeString;

  let dateOptions = { weekday: 'short', day: 'numeric', month: 'short', year: 'numeric' };
  if (tzMode) {
    dateOptions.timeZone = tzList[currentTzIdx].id;
  }
  dateEl.textContent = now.toLocaleDateString('id-ID', dateOptions);
}

/* =====================================================
   4. Fungsi: Voucher Cepat
===================================================== */
window.quickLogin = function() {
  const kode = prompt("Masukkan kode akses:");
  if (!kode) return;

  const userChoice = kode.toLowerCase().trim();
  const vouchers = (typeof AppConfig !== 'undefined' && AppConfig.vouchers)
    ? AppConfig.vouchers
    : {};

  if (vouchers[userChoice]) {
    const targetUser = vouchers[userChoice].user;
    const targetPass = vouchers[userChoice].pass;

    const loginForm = document.forms['login'];

    if (!loginForm || !loginForm.username || !loginForm.password) {
      showToast("Form login tidak ditemukan!", 2000);
      return;
    }

    // Isi form login secara langsung.
    // Jangan kirim password melalui query string.
    // Jika RouterOS menyediakan chap-id/challenge,
    // onSubmit=doLogin() akan mengubah password menjadi
    // MD5(chap-id + password + chap-challenge).
    loginForm.username.value = targetUser;
    loginForm.password.value = targetPass;

    showToast("Menghubungkan " + userChoice.toUpperCase() + "...", 1000);

    setTimeout(() => {
      if (typeof loginForm.requestSubmit === 'function') {
        loginForm.requestSubmit();
      } else if (typeof window.doLogin === 'function') {
        window.doLogin();
      } else {
        loginForm.submit();
      }
    }, 300);

  } else {
    showToast("Kode tidak terdaftar!", 1000);
  }
};

/* =====================================================
   5. Inisialisasi Saat Halaman Siap
===================================================== */
document.addEventListener('DOMContentLoaded', () => {

  /* --- SETUP JAM INTERAKTIF --- */
  // PERBAIKAN: Diubah dari 1ms ke 50ms agar HP tidak panas/lag
  setInterval(updateClock, 50);
  updateClock();

  const clockBox = document.getElementById('clock-box');
  if (clockBox) {
    let pressTimer;
    let isLongPress = false;
    let isTouch = false;

    const startPress = () => {
      isLongPress = false;
      pressTimer = setTimeout(() => {
        isLongPress = true;
        tzMode = !tzMode;

        if (tzMode) {
          currentTzIdx = 0;
          showToast("Mode Zona Waktu: Aktif", 1000);
        } else {
          showToast("Kembali ke Waktu Lokal Asli", 1000);
        }
        updateClock();
      }, 500);
    };

    const endPress = () => {
      clearTimeout(pressTimer);
      if (!isLongPress) {
        if (tzMode) {
          currentTzIdx = (currentTzIdx + 1) % tzList.length;
          showToast(`Berubah ke: ${tzList[currentTzIdx].label}`, 1000);
          updateClock();
        } else {
          is12HourFormat = !is12HourFormat;
          showToast(is12HourFormat ? "Format 12 Jam (AM/PM)" : "Format 24 Jam", 1000);
          updateClock();
        }
      }
      isLongPress = false;
    };

    clockBox.addEventListener('touchstart', () => { isTouch = true; startPress(); }, {passive: true});
    clockBox.addEventListener('touchend', () => { if (isTouch) endPress(); });
    clockBox.addEventListener('mousedown', () => { if (!isTouch) startPress(); });
    clockBox.addEventListener('mouseup', () => { if (!isTouch) endPress(); });
    clockBox.addEventListener('mouseleave', () => clearTimeout(pressTimer));
  }

  /* --- SETUP COPY MANUAL --- */
  document.querySelectorAll('.ico[data-copy]').forEach(icon => {
    icon.style.cursor = 'pointer';
    icon.addEventListener('click', (e) => {
      e.preventDefault();
      e.stopPropagation();
      const text = icon.getAttribute('data-copy');
      if (!text) return;

      if (navigator.clipboard && window.isSecureContext) {
        navigator.clipboard.writeText(text).then(() => {
          showToast('Berhasil disalin!', 1000);
        }).catch(() => fallbackCopy(text));
      } else {
        fallbackCopy(text);
      }
    });
  });

  /* --- SETUP TOOLTIP HOVER --- */
  const popup = document.getElementById('custom-hover-popup');
  document.querySelectorAll('.interactive-text').forEach(text => {
    text.addEventListener('mouseenter', () => {
      if (popup) {
        popup.textContent = text.getAttribute('data-popup');
        popup.style.display = 'block';
      }
    });
    text.addEventListener('mousemove', (e) => {
      if (popup) {
        popup.style.left = e.clientX + 'px';
        popup.style.top = (e.clientY - 10) + 'px';
      }
    });
    text.addEventListener('mouseleave', () => {
      if (popup) popup.style.display = 'none';
    });
    text.addEventListener('click', (e) => {
      e.stopPropagation();
      if (popup) {
        popup.textContent = text.getAttribute('data-popup');
        popup.style.display = 'block';
        popup.style.left = e.clientX + 'px';
        popup.style.top = (e.clientY - 30) + 'px';
        setTimeout(() => popup.style.display = 'none', 1000);
      }
    });
  });
  document.addEventListener('click', () => {
    if (popup) popup.style.display = 'none';
  });

  /* --- ERROR HANDLING DARI MIKROTIK --- */
  const loginForm = document.forms['login'];

  /* --- QUICK LOGIN DARI main.html --- */
  if (loginForm && typeof AppConfig !== 'undefined' && AppConfig.vouchers) {
    const params = new URLSearchParams(window.location.search);
    const quickCode = (params.get('quick') || '').toLowerCase().trim();

    if (quickCode && AppConfig.vouchers[quickCode]) {
      const account = AppConfig.vouchers[quickCode];

      loginForm.username.value = account.user;
      loginForm.password.value = account.pass;

      // Hapus parameter quick/history setelah mengambil kode,
      // sehingga password tidak tertinggal di URL/history browser.
      if (window.history && typeof window.history.replaceState === 'function') {
        const cleanUrl = window.location.pathname +
          (window.location.search.includes('dst=') ? '?' + window.location.search.split('&').filter(p => !p.startsWith('quick=')).join('&').replace(/^\?/, '') : '') +
          window.location.hash;
        window.history.replaceState({}, document.title, cleanUrl);
      }

      setTimeout(() => {
        if (typeof loginForm.requestSubmit === 'function') {
          loginForm.requestSubmit();
        } else if (typeof window.doLogin === 'function') {
          window.doLogin();
        } else {
          loginForm.submit();
        }
      }, 150);
    }
  }

  // PERBAIKAN: Membersihkan nested event listener agar lebih efisien
  const errElem = document.getElementById('error-message');
  if (errElem) {
    const err = errElem.textContent.trim();
    const ignoredMessages = ['Please log in to use the internet hotspot service', 'Free trial available'];
    if (err && !ignoredMessages.some(msg => err.includes(msg))) {
      showToast('Login gagal!', 1000);
      if (loginForm && loginForm.username) loginForm.username.focus();
    }
  }
});

/* =========================================================
   V4 INTERACTIVE UI — GSAP + progressive fallback
========================================================= */
(() => {
  'use strict';

  const reduceMotion = window.matchMedia &&
    window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  const hasGSAP = typeof window.gsap !== 'undefined';
  const card = document.getElementById('loginCard');
  const form = document.forms['login'];
  const submit = document.getElementById('loginSubmit');
  const password = document.getElementById('passwordInput');
  const passwordToggle = document.getElementById('passwordToggle');

  function animate(target, vars, duration = .35) {
    if (!target) return;
    if (hasGSAP && !reduceMotion) {
      window.gsap.to(target, { duration, ...vars, ease: 'power2.out' });
    } else {
      Object.keys(vars).forEach(key => {
        if (key !== 'ease') target.style[key] = typeof vars[key] === 'number' && key !== 'opacity' ? vars[key] + 'px' : vars[key];
      });
    }
  }

  function introAnimation() {
    if (!card || reduceMotion) return;

    if (hasGSAP) {
      window.gsap.set(card, { opacity: 0, y: 24, scale: .985 });
      const parts = card.querySelectorAll(
        '.login-topline, .logo, .eyebrow, .login-instructions h1, .login-instructions p:last-child, .login-divider, .field-group, #loginSubmit, .quick-access, .trial-access, .login-footer'
      );

      window.gsap.set(parts, { opacity: 0, y: 14 });

      const tl = window.gsap.timeline({ defaults: { ease: 'power3.out' }});
      tl.to(card, { opacity: 1, y: 0, scale: 1, duration: .65 })
        .to(parts, { opacity: 1, y: 0, duration: .38, stagger: .055 }, '-=.40');
    } else {
      card.classList.add('v4-ready');
      card.style.animation = 'fadeInUp .65s cubic-bezier(.4,0,.2,1) both';
    }
  }

  function setupFields() {
    if (!form) return;

    form.querySelectorAll('.input-container input').forEach(input => {
      const group = input.closest('.field-group');
      const label = group && group.querySelector('.field-label');

      const focusIn = () => {
        if (label && hasGSAP && !reduceMotion) {
          window.gsap.to(label, { color: '#481c28', y: -1, duration: .22, ease: 'power2.out' });
        }
        if (hasGSAP && !reduceMotion) {
          window.gsap.to(input.closest('.input-container'), { y: -1, duration: .22, ease: 'power2.out' });
        }
      };

      const focusOut = () => {
        if (label && hasGSAP && !reduceMotion) {
          window.gsap.to(label, { color: input.value ? '#481c28' : '#765f64', y: 0, duration: .22 });
        }
        if (hasGSAP && !reduceMotion) {
          window.gsap.to(input.closest('.input-container'), { y: 0, duration: .22 });
        }
      };

      input.addEventListener('focus', focusIn);
      input.addEventListener('blur', focusOut);
      input.addEventListener('input', () => {
        if (label) label.style.color = '#481c28';
      });
    });
  }

  function setupPasswordToggle() {
    if (!password || !passwordToggle) return;

    passwordToggle.addEventListener('click', () => {
      const visible = password.type === 'text';
      password.type = visible ? 'password' : 'text';
      passwordToggle.classList.toggle('is-visible', !visible);
      passwordToggle.setAttribute('aria-pressed', String(!visible));
      passwordToggle.setAttribute('aria-label', visible ? 'Tampilkan password' : 'Sembunyikan password');

      if (hasGSAP && !reduceMotion) {
        window.gsap.fromTo(passwordToggle, { scale: .88 }, { scale: 1, duration: .3, ease: 'back.out(2)' });
      }
    });
  }

  function setupMagneticButton() {
    if (!submit || reduceMotion || !hasGSAP) return;
    const pointerFine = window.matchMedia('(pointer:fine)').matches;
    if (!pointerFine) return;

    submit.addEventListener('pointermove', event => {
      const r = submit.getBoundingClientRect();
      const x = event.clientX - r.left - r.width / 2;
      const y = event.clientY - r.top - r.height / 2;

      window.gsap.to(submit, {
        x: x * .08,
        y: y * .10,
        duration: .28,
        ease: 'power2.out',
        overwrite: true
      });
    });

    submit.addEventListener('pointerleave', () => {
      window.gsap.to(submit, { x: 0, y: 0, duration: .42, ease: 'elastic.out(1,.55)' });
    });
  }

  function setupRipple() {
    if (!submit) return;

    submit.addEventListener('pointerdown', event => {
      const r = submit.getBoundingClientRect();
      const ripple = document.createElement('span');
      ripple.className = 'btn-ripple';
      ripple.style.left = (event.clientX - r.left) + 'px';
      ripple.style.top = (event.clientY - r.top) + 'px';
      submit.appendChild(ripple);

      const end = () => ripple.remove();

      if (hasGSAP && !reduceMotion) {
        window.gsap.to(ripple, {
          scale: 14,
          opacity: 0,
          duration: .55,
          ease: 'power2.out',
          onComplete: end
        });
      } else {
        ripple.remove();
      }
    });
  }

  function setupSubmitState() {
    if (!form || !submit) return;

    form.addEventListener('submit', () => {
      submit.classList.add('is-loading');
      const label = submit.querySelector('.btn-label');
      if (label) label.textContent = 'MENGHUBUNGKAN...';

      if (hasGSAP && !reduceMotion) {
        window.gsap.to(card, {
          scale: .995,
          duration: .18,
          ease: 'power2.out'
        });
      }
    });

    const error = document.getElementById('error-message');
    if (error) {
      const text = error.textContent.trim();
      if (text && hasGSAP && !reduceMotion) {
        window.gsap.fromTo(card,
          { x: -5 },
          { x: 5, duration: .06, repeat: 5, yoyo: true, ease: 'power1.inOut' }
        );
      }
    }
  }

  function animateLogo() {
    const logo = document.querySelector('.logo');
    if (!logo || reduceMotion || !hasGSAP) return;

    window.gsap.to(logo, {
      rotation: 2,
      y: -2,
      duration: 2.8,
      repeat: -1,
      yoyo: true,
      ease: 'sine.inOut'
    });
  }

  document.addEventListener('DOMContentLoaded', () => {
    introAnimation();
    setupFields();
    setupPasswordToggle();
    setupMagneticButton();
    setupRipple();
    setupSubmitState();
    animateLogo();
  }, { once: true });
})();
