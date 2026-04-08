const orders=[
    {
    id:"001",
    name:"Nguyen Van A",
    status:"hủy",
    totalAmount:20000,
    },
    {
    id:"002",
    name:"Nguyen Thi B",
    status:"hủy",
    totalAmount:100000,
    },
    {
    id:"003",
    name:"Nguyen Huu Nhat",
    status:"đang giao",
    totalAmount:2000000
    },
]
function getDataBaseInfo(){
   return new Promise((resolve,reject)=>{
    setTimeout(()=>{resolve(orders);},2000)
   });
}
async function procesOrders() {
    console.log("Đang gửi yêu cầu lấy đơn hàng")
    const data = await getDataBaseInfo()
    const donHangDaHuy=data.filter(item=>item.status==="hủy")
    const donHangDuocBoiThuong = donHangDaHuy.map(item=>{
        return{
            ...item,
            boithuong:item.totalAmount*0.5,
            phiship:item.totalAmount*0.1
        };
    });
    console.log(donHangDaHuy);
    console.log(donHangDuocBoiThuong);
}
procesOrders()