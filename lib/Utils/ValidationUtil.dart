class ValidationUtil {
//Validate Mobile Number
  static int validateMobile(String mobileNumber) {
    String patttern = r'^(\+91[\-\s]?)?[0]?(91)?[6789]\d{9}$';
    RegExp regExp = new RegExp(patttern);
    if (mobileNumber.length == 0) {
      return 1;
    } else if (mobileNumber.length < 10) {
      return 2;
    } else if (mobileNumber.startsWith(patttern)) {
      return 3;
    } else if (!regExp.hasMatch(mobileNumber)) {
      return 4;
    } else {
      return 0;
    }
  }

  //Validate Title
  static int validateTitle(String title) {
    String patttern = r'(^[a-zA-Z0-9 ,.-?]*$)';
    RegExp regExp = new RegExp(patttern);
    if (title.length == 0) {
      return 1;
    } else if (!regExp.hasMatch(title)) {
      return 0; //return 2;
    } else if (title.length < 10) {
      return 3;
    } else {
      return 0;
    }
  }

  //Validate Description
  static int validateDesc(String desc) {
    String patttern = r'(^[a-zA-Z0-9 ,.-?]*$)';
    RegExp regExp = new RegExp(patttern);
    if (desc.length == 0) {
      return 1;
    } else if (!regExp.hasMatch(desc)) {
      return 0; // return 2;
    } else if (desc.length < 10) {
      return 3;
    } else {
      return 0;
    }
  }

  //Validate Address
  static int validateAddress(String address) {
    String patttern = r'(^[a-zA-Z0-9 ,.-]*$)';
    RegExp regExp = new RegExp(patttern);
    if (address.isEmpty || address.length == 0) {
      return 1;
    } else if (!regExp.hasMatch(address)) {
      return 0; // return 2;
    } else if (address.length < 10) {
      return 3;
    } else {
      return 0;
    }
  }

  //Validate Website
  static int validateWebsite(String website) {
    String patttern = r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+';
    RegExp regExp = new RegExp(patttern);
    if (website.length == 0) {
      return 1;
    } else if (!regExp.hasMatch(website)) {
      return 2;
    } else {
      return 0;
    }
  }

// Email Validator
  static int validateEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    email = email.replaceAll(RegExp(' +'), ' ');
    if (email.length == 0) {
      return 1; //Enter Email Id
    } else if (!regex.hasMatch(email)) {
      return 2; //Invalid email Id
    } else {
      return 0;
    }
  }

  //Validate Price Amount
  static int validatePriceAmount(String price) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (price.length == 0) {
      return 1;
    } else if (!regExp.hasMatch(price)) {
      return 2;
    } else if (price == "0") {
      return 3;
    } else {
      return 0;
    }
  }

  //Validate Max Price Amount
  static int validateMaxPriceAmount(String price, String minAmount) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (price.length == 0) {
      return 1;
    } else if (!regExp.hasMatch(price)) {
      return 2;
    } else if (int.parse(price) < int.parse(minAmount)) {
      return 3;
    } else {
      return 0;
    }
  }

  //Validate Poll Options
  static int validatePollOptions(String options) {
    String patttern = r'(^[a-zA-Z0-9 ,.-?]*$)';
    if (options.length == 0) {
      return 1;
    } else {
      return 0;
    }
  }

  static int validatePincode(String pincodeValue) {
    if (pincodeValue.isEmpty || pincodeValue.length == 0) {
      return 1;
    } else if (pincodeValue.isNotEmpty && pincodeValue.length < 6) {
      return 2;
    } else {
      return 0;
    }
  }

/* Network Validations */
  static int validateNetworkDesc(String desc) {
    String patttern = r'(^[a-zA-Z0-9 ,.-?]*$)';
    RegExp regExp = new RegExp(patttern);
    if (desc.length == 0) {
      return 1;
    } else if (!regExp.hasMatch(desc)) {
      return 0; // return 2;
    } else if (desc.length < 10) {
      return 3;
    } else {
      return 0;
    }
  }
}
