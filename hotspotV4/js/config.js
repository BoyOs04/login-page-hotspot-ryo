/* =====================================================
   js/config.js - PUSAT PENGATURAN HOTSPOT
===================================================== */

const AppConfig = {

    // 1. PENGATURAN AKUN TAMU (Tampil di layar utama)
    tamuUser: "tamu",
    tamuPass: "!guest",

    // 2. DAFTAR AKUN UNTUK LOGIN CEPAT
    // Password dipakai hanya setelah halaman login terbuka,
    // agar tidak dikirim sebagai parameter URL.
    vouchers: {
        'fam':    { user: 'family',  pass: 'family1234' },
        'ryo':    { user: 'ryoline', pass: 'claudio04' },
        'andrew': { user: 'andrew',  pass: 'andrew1234' },
        'juan':   { user: 'juan',    pass: 'juan1234' }

        // Cara tambah baru:
        // 'teman': { user: 'tamu1', pass: '12345' }
    }
};