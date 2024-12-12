import 'package:coba_vania/app/models/orderitems.dart';
import 'package:vania/vania.dart';

class OrderitemController extends Controller {

     Future<Response> index() async {
          return Response.json({'message':'Hello World'});
     }

     Future<Response> create() async {
          return Response.json({});
     }

     Future<Response> store(Request request) async {
          try {
        
        final requestData=request.input();

        final existingOrderitem = await Orderitems().query().where("order_item","=", requestData['order_item']).first();

        if (existingOrderitem !=  null) {
          return Response.json(
            {'message':"Customer Sudah Ada"},409
          );
        }

        requestData['created_at'] = DateTime.now().toIso8601String();

        await Orderitems().query().insert(requestData);

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
        final listOrderitems = await Orderitems().query().get();
        return Response.json({
          'message' : "List Order Yang Tersedia",
          'data': listOrderitems,
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

     Future<Response> update(Request request,int order_item) async {
          try {
            final listOrderitem = request.input();

            final orderitems = await Orderitems().query().where('order_item','=',order_item).first();

            if (orderitems == null) {
              return Response.json({
                'message': 'Data Tidak Ditemukan'
              },404);
            }
            
            await Orderitems().query().where('order_item','=',order_item).update(listOrderitem);

            return Response.json({
              'message':'Data Berhasil Diubah',
              "data": listOrderitem
            },200);
          } catch (e) {
            return Response.json({
              "message": "Data Gagal Diubah",
              "error" : e.toString() 
            },500);
            
          }
     }

     Future<Response> destroy(int order_item) async {
          try {
        final orderitem= await Orderitems().query().where('order_item','=',order_item).first();

        if (orderitem == null) {
          return Response.json({
            'message' : "Data Tidak Ditemukan",
          },400);
        }

        await Orderitems().query().where("order_item",'=',order_item).delete();

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

final OrderitemController orderitemController = OrderitemController();

