/* main.js - direct login selector */

function showToast(msg,time=2500){
  const t=document.getElementById("toast");
  if(!t) return;
  t.textContent=msg;
  t.classList.add("show");
  clearTimeout(t._timer);
  t._timer=setTimeout(()=>t.classList.remove("show"),time);
}

function toggleDropdown(){
  const d=document.getElementById("dropdownMenu");
  if(d) d.classList.toggle("show");
}

/* ===== FAMILY PAGE ACCESS ===== */
function accessFamily(){
  const pw=prompt("Masukkan password Family:");
  if(pw==="linelejanrumagit"){
    location.href="fam.html";
  }else if(pw){
    showToast("Password salah!",1000);
  }
}

/* ===== USER LOGIN DIRECT ===== */
function chooseUser(){
  let u = prompt("Pilih user: ryo, andrew, juan");
  if(!u) return;

  u = u.toLowerCase().trim();

  // Alias dipetakan ke kode Quick Login.
  // URL login diambil dari variabel yang disediakan oleh login.html/main.html,
  // bukan hardcoded ke /login.
  const loginMap = {
    ryo: "ryo",
    rl: "ryo",
    andrew: "andrew",
    juan: "juan",
    fam: "fam"
  };

  const quickCode = loginMap[u];
  const hotspotConfig = window.HotspotConfig || {};
  const loginBase = hotspotConfig.loginLink || hotspotConfig.loginUrl || "";

  if(!quickCode){
    showToast("User tidak dikenal!",3000);
    return;
  }

  if(!loginBase){
    showToast("URL Login HotSpot tidak tersedia!",3000);
    return;
  }

  showToast("Menghubungkan...",1500);

  setTimeout(()=>{
    const separator = loginBase.includes("?") ? "&" : "?";
    window.location.href =
      loginBase + separator + "quick=" + encodeURIComponent(quickCode);
  },500);
}

/* ===== CLOSE DROPDOWN ON OUTSIDE CLICK ===== */
document.addEventListener("click",e=>{
  const d=document.getElementById("dropdownMenu");
  const m=document.querySelector(".menu-toggle");
  if(d && m && !d.contains(e.target) && !m.contains(e.target)){
    d.classList.remove("show");
  }
});