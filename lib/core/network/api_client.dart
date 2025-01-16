import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class APIClient {
  factory APIClient(Dio dio) = _APIClient;

  @GET("/{path}")
  Future<HttpResponse<dynamic>> get(
      @Path("path") String path, {
        @Queries() Map<String, dynamic>? parameters,
      });

  @POST("{path}")
  Future<HttpResponse> postJson(
      @Path("path") String path,
      @Body() dynamic jsonData, {
        @Header("Content-Type") String contentType = "application/json",
      });

  @POST("{path}")
  Future<HttpResponse> postWithHeaders(
      @Path("path") String path,
      @Body() dynamic jsonData, {
        @Header("Content-Type") String contentType = "application/json",
        @Header("token") String? token,
      });

  // Method for posting form data
  @POST("{path}")
  @FormUrlEncoded()
  Future<HttpResponse> postFormData(
      @Path("path") String path,
      @Body() FormData formData, {
        @SendProgress() ProgressCallback? onSendProgress,
        @CancelRequest() CancelToken? cancelToken,
      });

  @PUT("{path}")
  Future<HttpResponse> putJson(
      @Path("path") String path,
      @Body() Map<String, dynamic> jsonData, {
        @Header("Content-Type") String contentType = "application/json",
      });

  // Method for put form data
  @PUT("{path}")
  @FormUrlEncoded()
  Future<HttpResponse> putFormData(
      @Path("path") String path,
      @Body() FormData formData, {
        @SendProgress() ProgressCallback? onSendProgress,
        @CancelRequest() CancelToken? cancelToken,
      });

  // Method for deleting resources
  @DELETE("{path}")
  Future<HttpResponse> delete(
      @Path("path") String path, {
        @Queries() Map<String, dynamic>? parameters,
        @CancelRequest() CancelToken? cancelToken,
      });

  // Method for posting XML data
  @POST("{path}")
  Future<HttpResponse> postXml(
      @Path("path") String path,
      @Body() String xmlData, {
        @Header("Content-Type") String contentType = "application/xml",
      });
}
