import 'package:coba_vania/app/models/product.dart';
import 'package:vania/vania.dart';

class ProductController extends Controller {

     Future<Response> index() async {
          return Response.json({'message':'Hello World'});
     }

     Future<Response> create(Request request) async {
      // percobaan
      try {
        final requestData=request.input();

        return Response.json({
          "massage":"Produk Berhasil Ditambahkan",
          "data":requestData,
        },201);
        
      } catch (e) {
        return Response.json({
          "massage":"Produk Berhasil Ditambahkan",
        },
        500,
        );
      }
     } 
Future<Response> show() async {
      try {
        final listProduct = await Product().query().get();
        return Response.json({
          'message' : "List Produk Yang Tersedia",
          'data': listProduct,
        },200);
      } catch (e) {
        return Response.json({
          'message':'Data Tidak Ditemukan',
          'error': e.toString()
        },500);
        
      }
      }
      Future<Response> store(Request request) async {
        try {
          
        final requestData=request.input();

        final existingProduct = await Product().query().where("prod_id","=", requestData['prod_id']).first();

        if (existingProduct !=  null) {
          return Response.json(
            {'message':"Produk Sudah Ada"},409
          );
        }

        requestData['created_at'] = DateTime.now().toIso8601String();

        await Product().query().insert(requestData);

        return Response.json({
          "massage":"Produk Berhasil Ditambahkan",
          "data":requestData,
        },201);

      } catch (e) {
        return Response.json({
          "massage":"Produk Gagal Ditambahkan",
        },
        500,
        );
      }
     }
     Future<Response> edit(int id) async {
          return Response.json({});
     }

     Future<Response> update(Request request,int prod_id) async {
          try {
            final listProduct = request.input();

            final product = await Product().query().where('prod_id','=',prod_id).first();

            if (product == null) {
              return Response.json({
                'message': 'Data Tidak Ditemukan'
              },404);
            }
            
            await Product().query().where('prod_id','=',prod_id).update(listProduct);

            return Response.json({
              'message':'Data Berhasil Diubah',
              "data": listProduct
            },200);
          } catch (e) {
            return Response.json({
              "message": "Data Gagal Diubah",
              "error" : e.toString() 
            },500);
            
          }
     }
      
     Future<Response> destroy(int prod_id) async {
      try {
        final product= await Product().query().where('prod_id','=',prod_id).first();

        if (product == null) {
          return Response.json({
            'message' : "Data Tidak Ditemukan",
          },400);
        }

        await Product().query().where("prod_id",'=',prod_id).delete();

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
     }
     
     


final ProductController productController = ProductController();

