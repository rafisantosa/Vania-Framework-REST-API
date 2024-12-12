import 'package:coba_vania/app/models/customer.dart';
import 'package:vania/vania.dart';

class CustomerController extends Controller {

     Future<Response> index() async {
          return Response.json({'message':'Hello World'});
     }

     Future<Response> create() async {
          return Response.json({});
     }

     Future<Response> show() async {
        try {
        final listCustomer = await Customer().query().get();
        return Response.json({
          'message' : "List Customers Yang Tersedia",
          'data': listCustomer,
        },200);
      } catch (e) {
        return Response.json({
          'message':'Data Tidak Ditemukan',
          'error': e.toString()
        },500);
      }
    }

     
     Future<Response> edit(int cust_id) async {
          return Response.json({});
     }

     Future<Response> update(Request request,int cust_id) async {
          try {
            final listCustomer = request.input();

            final product = await Customer().query().where('cust_id','=',cust_id).first();

            if (product == null) {
              return Response.json({
                'message': 'Data Tidak Ditemukan'
              },404);
            }
            
            await Customer().query().where('cust_id','=',cust_id).update(listCustomer);

            return Response.json({
              'message':'Data Berhasil Diubah',
              "data": listCustomer
            },200);
          } catch (e) {
            return Response.json({
              "message": "Data Gagal Diubah",
              "error" : e.toString() 
            },500);
            
          }
     }
     
     Future<Response> destroy(int cust_id) async {
        try {
        final customer= await Customer().query().where('cust_id','=',cust_id).first();

        if (customer == null) {
          return Response.json({
            'message' : "Data Tidak Ditemukan",
          },400);
        }

        await Customer().query().where("cust_id",'=',cust_id).delete();

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
     Future<Response> store(Request request) async {
        try {
        
        final requestData=request.input();

        final existingCustomer = await Customer().query().where("cust_id","=", requestData['cust_id']).first();

        if (existingCustomer !=  null) {
          return Response.json(
            {'message':"Customer Sudah Ada"},409
          );
        }

        requestData['created_at'] = DateTime.now().toIso8601String();

        await Customer().query().insert(requestData);

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
     


final CustomerController customerController = CustomerController();

