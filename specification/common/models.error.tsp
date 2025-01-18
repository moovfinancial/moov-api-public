namespace MoovAPI;

@example(#{ `0`: "first element failed validation..." })
model ArrayValidationError is ArrayValidationErrorObj<string>;

// Template for the error schema Ozzo returns when validating arrays.
// The key is always the index of the array element that failed validation.
// For arrays of primitive types, the ErrorType is always string, while arrays
// of objects will be Ozzo's validation.Errors.
model ArrayValidationErrorObj<ErrorType> is Record<ErrorType>;
