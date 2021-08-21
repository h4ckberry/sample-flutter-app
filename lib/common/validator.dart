// import 'validatable.dart';

// class Validator implements Validatable {
//   static String Function(String) validate = (value) {
//     if (value == null) {
//       return '値が未設定です。';
//     }
//     if (value.isEmpty) {
//       return '値が未設定です。';
//     }

//     if (value.indexOf(' ') >= 0 && value.trim() == '') {
//       return '空文字は受け付けていません。';
//     }

//     if (value.indexOf('　') >= 0 && value.trim() == '') {
//       return '空文字は受け付けていません。';
//     }

//     if (value.length > 30) {
//       return '30文字以下にしてください';
//     }
//     return null;
//   };
// }
