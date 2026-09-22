/* ===================================================
   login.js - clock system
   CHAP/PAP login handler is centralized in login.html.
=================================================== */

/* ===================================================
   CLOCK SYSTEM
=================================================== */

let clock24H = true;

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
  const bulan = [
    "Januari","Februari","Maret","April","Mei","Juni",
    "Juli","Agustus","September","Oktober","November","Desember"
  ];

  const waktu =
    jam + ":" + menit + ":" + detik + suffix;

  const tanggal =
    hari[now.getDay()] + ", " +
    now.getDate() + " " +
    bulan[now.getMonth()] + " " +
    now.getFullYear();

  const t = document.getElementById("clock-time");
  const d = document.getElementById("clock-date");

  if(t && d){
    t.textContent = waktu;
    d.textContent = tanggal;
  }
}

document.addEventListener("DOMContentLoaded", () => {

  const clockBox = document.getElementById("clock-box");

  if(clockBox){
    clockBox.style.cursor = "pointer";

    clockBox.addEventListener("click", () => {
      clock24H = !clock24H;
      updateClock();

      if(typeof showToast === 'function'){
        showToast(
          clock24H ? "Mode 24 Jam" : "Mode AM/PM",
          1500
        );
      }
    });
  }

  const errMsg = document.getElementById('error-message');

  if(errMsg && errMsg.textContent.trim()){
    if(typeof showToast === 'function'){
      showToast(errMsg.textContent, 4000);
      errMsg.style.display = 'none';
    }
  }

  const toggleEye = document.getElementById('toggleUsername');
  const usernameInput = document.getElementById('usernameInput');

  if(toggleEye && usernameInput){
    toggleEye.addEventListener('click', function(){
      if(usernameInput.type === 'password'){
        usernameInput.type = 'text';
        toggleEye.textContent = '🙈';
      }else{
        usernameInput.type = 'password';
        toggleEye.textContent = '👁️';
      }
    });
  }

  updateClock();
  setInterval(updateClock, 1000);
});