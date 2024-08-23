//website domain
// const domain = "https://shamuk-new.digitalelliptical.com/";
// const domain = "http://192.168.100.4:8101/";
// const domain = "http://192.168.100.6:8101/";
// const domain = "https://shamuk.com.pk/";
const domain = "https://shamuk.ae/";

//All account register api
const accRegisterApi = "${domain}api/User/Register";
const accLoginApi = "${domain}api/User/Login";
const accResendOtpApi = "${domain}api/User/Resend/Otp";
const accVerifyOtpApi = "${domain}api/Verify/User/Email";

//all categories api's
const getCategoriesApi = "${domain}api/Get/Category";
const getCategoriesCardApi = "${domain}uploads/category/card/";
const getSubCategoriesApi = "${domain}api/Get/SubCategory/";

//product api
const getProductsApi = "${domain}api/Get/Product";
const getProductCardApi = "${domain}uploads/product/card/";
const getProductDetailApi = "${domain}api/Product";
const getProductDetailSliderCardApi = "${domain}uploads/product/images/";
const getProductDetailSliderMapCardApi = "${domain}uploads/property/maps/";

//add to whishlist
const addProductToWhishlistApi = "${domain}api/Insert/Wishlist";

//product cart api
const productAddToCartApi = "${domain}api/Add/To/Cart";
const getCartProductsApi = "${domain}api/Get/Cart";
const removeProductFromCartApi = "${domain}api/Delete/Cart";
const updateCartProductQuantityApi = "${domain}api/Update/Cart";

//coupon api
const applyCouponApi = "${domain}api/Check/Coupon";

//shipment details api
const getShipmentDetailsApi = "${domain}api/Get/Shipment";

//checkout
const checkoutApi = "${domain}api/Placed/Order";

//properties api
const getAllPropertiesApi = "${domain}api/Get/Property";
const getPropertyCardApi = "${domain}uploads/property/card/";
const getPropertyDetailApi = "${domain}api/Property";
const getPropertyDetailSliderCardApi = "${domain}uploads/property/images/";
const getPropertyDetailPDFApi = "${domain}uploads/property/pdf/";
const getPropertyLinkShare = "${domain}property/";

//services api
const getServicesByServiceIdApi = "${domain}api/Get/Professional";
const getServiceProfileCardApi = "${domain}uploads/professional/profile/";
const getServiceCardApi = "${domain}uploads/professional/image/";
const getServiceProfessiobalDetailApi = "${domain}api/Professional";
const getServiceProfessiobalDetailPDFApi = "${domain}uploads/professional/pdf/";

//current User Api Data
const currentUserAccDataApi = "${domain}api/User";

//get country api
const getCountryApi = "${domain}Get/Country";
//get state api
const getStateApi = "${domain}Get/State";
//get city api
const getCityApi = "${domain}Get/City";

//user update detail api
const userUpdateDetailApi = "${domain}api/User/Personal";

//user change password api
const userChangePasswordApi = "${domain}api/User/Password";

//orders
const getOrderListingApi = "${domain}api/Order/Get";
const getOrderDetailApi = "${domain}api/Order/Info";

//wanted
const userWantedApi = "${domain}api/Wanted/Insert";

//user contact us api
const userContactUsApi = "${domain}api/Contact/Insert";

//home slider cities api
const homeSliderCitiesAPi = "${domain}api/Get/Cities";
const getCityInfoId = "${domain}api/Get/City/Info/";

const homeSliderCardAPi = "${domain}uploads/city/card/";

//product review api
const productReviewApi = "${domain}api/Product/Review";

//professional review api
const professionalReviewApi = "${domain}api/Professional/Review";

//update token api for firebase messaging
const updateDeviceTokenApi = "${domain}api/Token";
