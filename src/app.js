const sql= require('mssql/msnodesqlv8');
const config={
    server:'localhost',
    database:'QL_Logistic',
    driver:'SQL Server',
    option:{
        trustedConnection:true,
        trustServerCertificate:true
    }
};
async function getDataBaseInfo(){
    try{
        let pool=await sql.connect(config);
        console.log("Liên kết SQL thành công");
        let result = await pool.request().query('SELECT*FROM KhachHang');
        let result1=await pool.request().query('SELECT*FROM HOADON')
         return{
            khachhang:result.recordset,
            hoadon:result1.recordset
        };
    }catch(error){
        console.log("Liên kết thất bại.Lỗi cụ thể:",error.message);
        return{khachhang:[],hoadon:[]}
}

async function procesOrders() {
    console.log("Đang gửi yêu cầu lấy đơn hàng")
    const data = await getDataBaseInfo()
    const donHangDaHuy=data.hoadon.filter(item=>item.TrangThai==="hủy")
    const donHangDuocBoiThuong = donHangDaHuy.map(item=>{
        return{
            ...item,
            boithuong:item.TongTien*0.5,
            phiship:item.TongTien*0.1
        };
    });
    data.khachhang.forEach(khach => {
        console.log(`Tên khách hàng: ${khach.TenKH}|Email: ${khach.Email}`)
    });
    console.log(donHangDuocBoiThuong);
}
procesOrders()
}