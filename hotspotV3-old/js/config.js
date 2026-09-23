/* =====================================================
   js/config.js - PUSAT PENGATURAN HOTSPOT
===================================================== */

const AppConfig = {
    
    // 1. PENGATURAN AKUN TAMU (Tampil di layar utama)
    tamuUser: "tamu",
    tamuPass: "!guest",

    // 2. DAFTAR VOUCHER / KODE AKSES CEPAT
    // Format: 'alias': { user: 'username_mikrotik', pass: 'password_mikrotik' }
    vouchers: {
        'fam': { user: 'family', pass: 'family1234' },
        'ryo': { user: 'ryoline', pass: 'claudio04' }
        
        // Cara tambah baru: 
        // 'teman': { user: 'tamu1', pass: '12345' }
    }
};