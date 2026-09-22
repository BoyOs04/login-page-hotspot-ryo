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
    // Jangan redirect dengan ?username=...&password=...
    // karena RouterOS HTTP-CHAP membutuhkan proses hash
    // chap-id + password + chap-challenge sebelum submit.
    loginForm.username.value = targetUser;
    loginForm.password.value = targetPass;

    showToast("Menghubungkan " + userChoice.toUpperCase() + "...", 1000);

    setTimeout(() => {
      if (typeof loginForm.requestSubmit === 'function') {
        loginForm.requestSubmit();
      } else {
        // Fallback untuk browser captive portal lama.
        const event = new Event('submit', { cancelable: true });
        loginForm.dispatchEvent(event);
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
          showToast(`Berhasil disalin!`, 1000);
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
  if (loginForm) {
    loginForm.addEventListener('submit', (e) => {
      const username = (loginForm.username ? loginForm.username.value : '').trim();
      const password = (loginForm.password ? loginForm.password.value : '').trim();
      if (!username || !password) {
        e.preventDefault();
        showToast('Username dan password wajib diisi!', 1000);
      }
    });
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