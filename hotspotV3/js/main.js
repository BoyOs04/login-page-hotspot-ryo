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

  // PERBAIKAN: Menggunakan relative path agar dinamis (tidak hardcoded domain)
  const loginMap = {
    ryo: "/login?username=ryoline&password=claudio04",
    rl: "/login?username=ryoline&password=claudio04",
    andrew: "/login?username=andrew&password=andrew1234",
    juan: "/login?username=juan&password=juan1234",
    fam: "/login?username=family&password=family1234"
  };

  if(loginMap[u]){
    showToast("Menghubungkan...",1500);
    setTimeout(()=>{
      window.location.href = loginMap[u];
    },500);
  }else{
    showToast("User tidak dikenal!",3000);
  }
}

/* ===== CLOSE DROPDOWN ON OUTSIDE CLICK ===== */
document.addEventListener("click",e=>{
  const d=document.getElementById("dropdownMenu");
  const m=document.querySelector(".menu-toggle");
  if(d && m && !d.contains(e.target) && !m.contains(e.target)){
    d.classList.remove("show");
  }
});