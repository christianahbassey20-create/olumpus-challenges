Repository
https://github.com/eadwinCode/django-ninja-extra
Commit: a27a58263f01641d4b81ce518be4569c1332cdef

Title
Bulk/Batch Operations for Model Controllers

Add bulk create, update, patch, and delete operations to the model controller framework.

Define the following in ninja_extra.controllers.model.schemas: BulkOperationConfig (pydantic BaseModel: atomic=True, max_items=100 with ge=1), BulkItemResult (ninja.Schema: index:int, success:bool, status_code:int, data:Optional[Any]=None, errors:Optional[Any]=None), BulkOperationResponse (ninja.Schema: total:int, succeeded:int, failed:int, results:List[BulkItemResult]), and BulkOperationError (Exception: message, results list, failed_index int).

Add bulk_config: Optional[BulkOperationConfig] = None to ModelConfig, along with bulk_create_route_info, bulk_update_route_info, bulk_patch_route_info, bulk_delete_route_info dicts (default {}). The allowed_routes validator must accept "bulk_create", "bulk_update", "bulk_patch", "bulk_delete".

When a bulk route name appears in allowed_routes, auto-register the corresponding endpoint. Read atomic/max_items from bulk_config (fallback: atomic=True, max_items=100) and delegate to the matching factory classmethod.

Factory classmethods: bulk_create(schema_in, path="/bulk", atomic=True, max_items=100, permissions=None), bulk_update(path, lookup_param, schema_in, pk_type=int, atomic=True, max_items=100, permissions=None), bulk_patch(path, lookup_param, schema_in, pk_type=int, atomic=True, max_items=100, permissions=None), bulk_delete(path="/bulk/delete", pk_type=int, lookup_param="id", atomic=True, max_items=100, permissions=None). Factory parameters are self-contained and override bulk_config values entirely. Async model controllers must produce async handlers. Routes: POST /bulk (create), PUT /bulk (update), PATCH /bulk (patch), POST /bulk/delete (delete). Response type: {200: BulkOperationResponse}.

For bulk create, the request body is a list of schema_in items. For bulk update and patch, each item must include the lookup_param field alongside the schema_in fields; the handler extracts the lookup value and applies the remaining fields. Bulk patch applies only the fields provided in the request (partial update semantics). For bulk delete, the request body is a schema with an "ids" field of type List[pk_type].

Exceeding max_items returns HTTP 400. Empty input returns 200 with total=0, succeeded=0, failed=0, results=[].

Successful items serialize instance data as dicts in the result data field. Success status codes per item: 201 (create), 200 (update/patch), 204 (delete). Failure: data=null, errors=string. In non-atomic mode, per-item failure status_code must reflect the actual error (e.g. 404 not found, 403 permission denied), not a blanket 404.

Atomic mode is the default and provides all-or-nothing semantics: if any item fails, all changes are rolled back. On failure, build results covering every input item: prior items marked "Rolled back" (success=False), the failed item with the error message, and remaining items marked "Skipped" (success=False). All failure results carry status_code 404 for update/patch/delete. Returns succeeded=0, failed=total.

Non-atomic mode processes items independently. Individual failures don't affect other items. Each failed item's status_code must come from the exception's own status_code when it is an APIException (e.g. 404 for NotFound, 403 for PermissionDenied), falling back to 500 for unexpected errors.

Default lookup_param is the model pk name. Overridable via factory classmethods. Supports non-pk fields (e.g. lookup_param="title", pk_type=str). All bulk operations including bulk_delete must pass the lookup_param through to the service layer.

Bulk update, patch, and delete must enforce per-object permissions on each instance before mutating it.
