import 'package:amazon/Facility_Manager/paymob_manager/constatnts/paymob_Apikey.dart';
import 'package:dio/dio.dart';

class PayMobManager{
  Dio dio =Dio();

  //
  Future<String> paywithPaymob({required int amount}) async {
    try{
      String token =await getToken();
      int OrderId= await getOrderId(token:token,amount: (100*amount).toString() );
      String paymentKey=await getPaymentKey(orderId:OrderId.toString(),
          amount: (100*amount).toString(), token:token  );
      return paymentKey;
    }catch(e){
      rethrow;
    }
  }


  // first function to get token
  Future<String> getToken() async {
    try{
      Response response=await dio.post("https://accept.paymob.com/api/auth/tokens" ,
          data: {"api_key":Constants.ApiKey});
      print(response.data["token"]);
      return response.data["token"];
    }catch(e){
      rethrow;
    }
  }

// second function
  Future<int> getOrderId({required String token , required String amount}) async {
    try{
      Response response=await dio.post("https://accept.paymob.com/api/ecommerce/orders" ,
          data: {"auth_token":token ,
          "delivery_needed":true,
          "amount_cents": amount,
            "currency":"EGP",
            "items":[]

          });
      print(response.data["id"]);
      return response.data["id"];
    }catch(e){
      rethrow;
    }
  }

//third Function
  Future<String> getPaymentKey({required String token , required String amount,  required String orderId}) async {
    try{
      Response response=await dio.post("https://accept.paymob.com/api/acceptance/payment_keys" ,
          data:
          {
            "auth_token": token,  // من الخطوة 1
            "amount_cents": amount,  // السعر بالقروش
            "expiration": 3600, // وقت انتهاء صلاحية رمز الدفع هذا بالثواني. (الحد الأقصى هو 3600 ثانية وهي ساعة)
            "currency": "EGP",  // العملة جنية مصري
            "order_id": 103,  // من الخطوة 2
            "integration_id": 4892740, // معرّف لقناة الدفع التي تريد أن يقوم عميلك بالدفع من خلالها يوجد في حسابك.
            "billing_data": {
              "apartment": "803",
              "email": "claudette09@exa.com",
              "floor": "42",
              "first_name": "Clifford",
              "street": "Ethan Land",
              "building": "8028",
              "phone_number": "+86(8)9135210487",
              "shipping_method": "PKG",
              "postal_code": "01898",
              "city": "Jaskolskiburgh",
              "country": "CR",
              "last_name": "Nicolas",
              "state": "Utah"
            },
            "lock_order_when_paid": "false"
          }
          );
      return response.data["token"];
    }catch(e){
      rethrow;
    }
  }
  }
