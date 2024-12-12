import 'package:coba_vania/app/models/productnotes.dart';
import 'package:vania/vania.dart';

class ProductnotesController extends Controller {

     Future<Response> index() async {
          return Response.json({'message':'Hello World'});
     }

     Future<Response> create() async {
          return Response.json({});
     }

     Future<Response> store(Request request) async {
          try {
          
        final requestData=request.input();

        final existingProductnotes = await Productnotes().query().where("note_id","=", requestData['note_id']).first();

        if (existingProductnotes !=  null) {
          return Response.json(
            {'message':"Produk Sudah Ada"},409
          );
        }

        requestData['created_at'] = DateTime.now().toIso8601String();

        await Productnotes().query().insert(requestData);

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
        final listProductnotes = await Productnotes().query().get();
        return Response.json({
          'message' : "List Produk Yang Tersedia",
          'data': listProductnotes,
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

     Future<Response> update(Request request,int note_id) async {
          try {
            final listProductnotes = request.input();

            final productnotes = await Productnotes().query().where('note_id','=',note_id).first();

            if (productnotes == null) {
              return Response.json({
                'message': 'Data Tidak Ditemukan'
              },404);
            }
            
            await Productnotes().query().where('note_id','=',note_id).update(listProductnotes);

            return Response.json({
              'message':'Data Berhasil Diubah',
              "data": listProductnotes
            },200);
          } catch (e) {
            return Response.json({
              "message": "Data Gagal Diubah",
              "error" : e.toString() 
            },500);
            
          }
     }

     Future<Response> destroy(int note_id) async {
          try {
        final productnotes= await Productnotes().query().where('note_id','=',note_id).first();

        if (productnotes == null) {
          return Response.json({
            'message' : "Data Tidak Ditemukan",
          },400);
        }

        await Productnotes().query().where("note_id",'=',note_id).delete();

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

final ProductnotesController productnotesController = ProductnotesController();

