// Gọi thêm thư viện cấp quyền Windows
const sql = require('mssql/msnodesqlv8');

// Cấu hình không cần mật khẩu
const config = {
    server: 'localhost', 
    database: 'QL_Logistic', // Sếp nhớ ĐỔI dòng này thành tên Database thực tế của Sếp nhé!
    driver: 'SQL Server',
    options: {
        trustedConnection: true, // Lệnh bài miễn tử: Báo là đang dùng quyền Windows
        trustServerCertificate: true 
    }
};

// 2. Thực hiện kết nối
async function testConnection() {
    try {
        await sql.connect(config);
        console.log("🎉 KẾT NỐI SQL SERVER (WINDOWS AUTH) THÀNH CÔNG! CHÚC MỪNG SẾP! 🎉");
    } catch (err) {
        console.error("❌ Úi, lỗi kết nối rồi. Chi tiết lỗi:", err);
    }
}

testConnection();