import "@typespec/http";
import "@typespec/openapi";
import "./models.file.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@post
@route("/accounts/{accountID}/files")
@tag("Files")
@doc("""
  Upload a file and link it to the specified Moov account. 
  
  The maximum file size is 10MB. Each account is allowed a maximum of 50 files. Acceptable file types include csv, jpg, pdf, 
  and png. 
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/files.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/files.write"]>)
@extension("x-speakeasy-name-override", "upload")
op uploadFile(
  ...CommonHeaders,
  @header contentType: "multipart/form-data",

  @format("uuid")
  @path
  accountID: string,

  @body body: FileUploadRequest,
): PostResponses<FileDetails, FileValidationError>;

@get
@route("/accounts/{accountID}/files")
@tag("Files")
@doc("""
  List all the files associated with a particular Moov account.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/files.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/files.read"]>)
@extension("x-speakeasy-name-override", "list")
op listFiles(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,
): ListResponses<FileDetails>;

@get
@route("/accounts/{accountID}/files/{fileID}")
@tag("Files")
@doc("""
  Retrieve file details associated with a specific Moov account.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/files.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/files.read"]>)
@extension("x-speakeasy-name-override", "get")
op getFileDetails(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  fileID: string,
): GetResponses<FileDetails>;
