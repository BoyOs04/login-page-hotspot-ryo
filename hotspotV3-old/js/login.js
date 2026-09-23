/* ===================================================
   login.js - CHAP handler, autofill, & clock system
=================================================== */

/* ===== LOGIN PROCESS (CHAP & PAP Fallback) ===== */
function doLogin(event) { // <--- Tambahkan 'event' di sini
  const loginForm = document.forms['login'];
  const u = loginForm.username.value.trim();
  const p = loginForm.password.value.trim();

  // Validasi Input
  if (!u || !p) {
    if (event) event.preventDefault(); // Cegah reload
    if (typeof showToast === 'function') showToast("Username dan password wajib diisi!", 3000);
    return false;
  }

  if (u.length < 3 || p.length < 3) {
    if (event) event.preventDefault(); // Cegah reload
    if (typeof showToast === 'function') showToast("Minimal 3 karakter!", 3000);
    return false;
  }

  const chapId = window.CHAP_ID;
  const challenge = window.CHAP_CHALLENGE;
  const sendinForm = document.forms['sendin'];

  // Cek apakah CHAP aktif
  if (chapId && challenge && chapId !== '$(chap-id)' && sendinForm) {
    if (event) event.preventDefault(); // <--- WAJIB ADA: Mencegah form utama terkirim secara plaintext
    
    try {
      sendinForm.username.value = u;
      
      // Enkripsi MD5 standar bawaan MikroTik
      sendinForm.password.value = hexMD5(chapId + p + challenge);
      
      // Submit ke form tersembunyi (Mode CHAP)
      sendinForm.submit();
      return false; 
      
    } catch (e) {
      console.error("CHAP error:", e);
      if (typeof showToast === 'function') showToast("Error hashing (CHAP)", 3000);
      return false; 
    }
  } else {
    // JIKA MODE PAP AKTIF:
    // Biarkan browser mengirim form 'login' utama secara Plaintext.
    return true; 
  }
}

/* ===== AUTOFILL FROM MAIN (PLAIN) ===== */
(function(){
  const params = new URLSearchParams(window.location.search);
  const u = params.get("u");
  const p = params.get("p");

  if (!u || !p) return;

  try {
    const loginForm = document.forms['login'];
    if (loginForm) {
      loginForm.username.value = u;
      loginForm.password.value = p;
    }
  } catch(e) {
    console.error("Autofill Error: ", e);
  }
})();


/* ===================================================
   CLOCK SYSTEM
=================================================== */

let clock24H = true; // default 24 jam

function updateClock(){
  const now = new Date();

  let hours = now.getHours();
  let suffix = "";

  if(!clock24H){
    suffix = hours >= 12 ? " PM" : " AM";
    hours = hours % 12 || 12;
  }

  const jam   = String(hours).padStart(2, '0');
  const menit = String(now.getMinutes()).padStart(2, '0');
  const detik = String(now.getSeconds()).padStart(2, '0');

  const hari = ["Minggu","Senin","Selasa","Rabu","Kamis","Jumat","Sabtu"];
  const bulan = ["Januari","Februari","Maret","April","Mei","Juni","Juli","Agustus","September","Oktober","November","Desember"];

  // Format BENAR: Menggunakan Template Literal Backtick (`)
  const waktu   = `${jam}:${menit}:${detik}${suffix}`;   
  const tanggal = `${hari[now.getDay()]}, ${now.getDate()} ${bulan[now.getMonth()]} ${now.getFullYear()}`;

  const t = document.getElementById("clock-time");
  const d = document.getElementById("clock-date");

  if(t && d){
    t.textContent = waktu;
    d.textContent = tanggal;
  }
}

/* ===== EVENT LISTENERS (Dijalankan saat DOM siap) ===== */
document.addEventListener("DOMContentLoaded", () => {
  
  // 1. Inisialisasi Jam & Klik Jam
  const clockBox = document.getElementById("clock-box");
  if(clockBox){
    clockBox.style.cursor = "pointer";
    clockBox.addEventListener("click", () => {
      clock24H = !clock24H;
      updateClock();
      if (typeof showToast === 'function') {
        showToast(clock24H ? "Mode 24 Jam" : "Mode AM/PM", 1500);
      }
    });
  }

  // 2. Tangkap Error MikroTik & Jadikan Toast
  const errMsg = document.getElementById('error-message');
  if (errMsg && errMsg.textContent.trim()) {
    if (typeof showToast === 'function') {
      showToast(errMsg.textContent, 4000);  // Munculkan di Toast
      errMsg.style.display = 'none';        // Sembunyikan teks merah asli agar lebih elegan
    }
  }

  // 3. Toggle Mata (Melihat Username/Password)
  const toggleEye = document.getElementById('toggleUsername');
  const usernameInput = document.getElementById('usernameInput');
  if (toggleEye && usernameInput) {
      toggleEye.addEventListener('click', function() {
          if (usernameInput.type === 'password') {
              usernameInput.type = 'text';
              toggleEye.textContent = '🙈';
          } else {
              usernameInput.type = 'password';
              toggleEye.textContent = '👁️';
          }
      });
  }

  // Start clock
  updateClock();                    
  setInterval(updateClock, 1000);   
});
