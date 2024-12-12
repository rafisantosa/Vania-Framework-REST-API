import 'package:coba_vania/app/models/vendor.dart';
import 'package:vania/vania.dart';

class VendorController extends Controller {
     Future<Response> index() async {
          return Response.json({'message':'Hello World'});
     }

     Future<Response> create() async {
          return Response.json({'message':'Hello World'});
     }
    //  Menampilkan Data yang ada didalam database
     Future<Response> show() async {
      try {
        final listVendor = await Vendor().query().get();
        return Response.json({
          'message' : "List Vendor Yang Tersedia",
          'data': listVendor,
        },200);
      } catch (e) {
        return Response.json({
          'message':'Data Tidak Ditemukan',
          'error': e.toString()
        },500);
        
      }}
      // Melakukan Update Data
      Future<Response> update(Request request,int vend_id) async {
          try {
            final listVendor = request.input();

            final vendor = await Vendor().query().where('vend_id','=',vend_id).first();

            if (vendor == null) {
              return Response.json({
                'message': 'Data Tidak Ditemukan'
              },404);
            }
            
            await Vendor().query().where('vend_id','=',vend_id).update(listVendor);

            return Response.json({
              'message':'Data Berhasil Diubah',
              "data": listVendor
            },200);
          } catch (e) {
            return Response.json({
              "message": "Data Gagal Diubah",
              "error" : e.toString() 
            },500);
            
          }
     }
     Future<Response> destroy(int vend_id) async {
      try {
        final vendor= await Vendor().query().where('vend_id','=',vend_id).first();

        if (vendor == null) {
          return Response.json({
            'message' : "Data Tidak Ditemukan",
          },400);
        }

        await Vendor().query().where("vend_id",'=',vend_id).delete();

        return Response.json({
          "message":"DATA BERHASIL TERHAPUS"
        },200);

      } catch (e) {
        return Response.json({
          'message': "Data gagal dihapus",
          "error": e.toString()
        },500);
      }
     }
    // Menambahkan data kedalam Database
     Future<Response> store(Request request) async {
        try {
          
        final requestData=request.input();

        final existingVendor = await Vendor().query().where("vend_id","=", requestData['vend_id']).first();

        if (existingVendor !=  null) {
          return Response.json(
            {'message':"Data Sudah Ada"},409
          );
        }

        requestData['created_at'] = DateTime.now().toIso8601String();

        await Vendor().query().insert(requestData);

        return Response.json({
          "massage":"Data Berhasil Ditambahkan",
          "data":requestData,
        },201);

      } catch (e) {
        return Response.json({
          "massage":"Data Gagal Ditambahkan",
        },
        500,
        );
      }
     }     
     }
     
     Future<Response> edit(int id) async {
          return Response.json({});
     }

     


final VendorController vendorController = VendorController();

