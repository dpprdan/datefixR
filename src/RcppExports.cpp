// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// process_french
String process_french(String date);
RcppExport SEXP _datefixR_process_french(SEXP dateSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< String >::type date(dateSEXP);
    rcpp_result_gen = Rcpp::wrap(process_french(date));
    return rcpp_result_gen;
END_RCPP
}
// imputemonth
void imputemonth(Nullable<String> monthImpute_);
RcppExport SEXP _datefixR_imputemonth(SEXP monthImpute_SEXP) {
BEGIN_RCPP
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Nullable<String> >::type monthImpute_(monthImpute_SEXP);
    imputemonth(monthImpute_);
    return R_NilValue;
END_RCPP
}
// imputeday
void imputeday(Nullable<String> dayImpute_);
RcppExport SEXP _datefixR_imputeday(SEXP dayImpute_SEXP) {
BEGIN_RCPP
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Nullable<String> >::type dayImpute_(dayImpute_SEXP);
    imputeday(dayImpute_);
    return R_NilValue;
END_RCPP
}
// checkday
void checkday(Nullable<NumericVector> dayImpute);
RcppExport SEXP _datefixR_checkday(SEXP dayImputeSEXP) {
BEGIN_RCPP
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Nullable<NumericVector> >::type dayImpute(dayImputeSEXP);
    checkday(dayImpute);
    return R_NilValue;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_datefixR_process_french", (DL_FUNC) &_datefixR_process_french, 1},
    {"_datefixR_imputemonth", (DL_FUNC) &_datefixR_imputemonth, 1},
    {"_datefixR_imputeday", (DL_FUNC) &_datefixR_imputeday, 1},
    {"_datefixR_checkday", (DL_FUNC) &_datefixR_checkday, 1},
    {NULL, NULL, 0}
};

RcppExport void R_init_datefixR(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
