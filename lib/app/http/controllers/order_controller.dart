import 'package:coba_vania/app/models/order.dart';
import 'package:vania/vania.dart';

class OrderController extends Controller {

     Future<Response> index() async {
          return Response.json({'message':'Hello World'});
     }

     Future<Response> create() async {
          return Response.json({});
     }

     Future<Response> store(Request request) async {
        try {
        
        final requestData=request.input();

        final existingOrder = await Order().query().where("order_num","=", requestData['order_num']).first();

        if (existingOrder !=  null) {
          return Response.json(
            {'message':"Customer Sudah Ada"},409
          );
        }

        requestData['created_at'] = DateTime.now().toIso8601String();

        await Order().query().insert(requestData);

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

     Future<Response> show() async {
        try {
        final listOrder = await Order().query().get();
        return Response.json({
          'message' : "List Order Yang Tersedia",
          'data': listOrder,
        },200);
      } catch (e) {
        return Response.json({
          'message':'Data Tidak Ditemukan',
          'error': e.toString()
        },500);
      }
     }

     Future<Response> edit(int id) async {
          return Response.json({});
     }

     Future<Response> update(Request request,int order_num) async {
          try {
            final listOrder = request.input();

            final product = await Order().query().where('order_num','=',order_num).first();

            if (product == null) {
              return Response.json({
                'message': 'Data Tidak Ditemukan'
              },404);
            }
            
            await Order().query().where('order_num','=',order_num).update(listOrder);

            return Response.json({
              'message':'Data Berhasil Diubah',
              "data": listOrder
            },200);
          } catch (e) {
            return Response.json({
              "message": "Data Gagal Diubah",
              "error" : e.toString() 
            },500);
            
          }
     }

     Future<Response> destroy(int order_num) async {
        try {
        final order= await Order().query().where('order_num','=',order_num).first();

        if (order == null) {
          return Response.json({
            'message' : "Data Tidak Ditemukan",
          },400);
        }

        await Order().query().where("order_num",'=',order_num).delete();

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

final OrderController orderController = OrderController();

