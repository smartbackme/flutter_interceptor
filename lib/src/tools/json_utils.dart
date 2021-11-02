
import 'dart:convert';

String json(String? json) {
  if (json==null||json.isEmpty) {
    return "";
  }else{
    var j = json.trim();
    try{
      if (j.startsWith("{")) {
        Map<String, dynamic> decode = JsonCodec().decode(json);
        var encoder = JsonEncoder.withIndent('  ');
        return encoder.convert(decode);
      }
      if (j.startsWith("[")) {
        List decode = JsonCodec().decode(json);
        var encoder = JsonEncoder.withIndent('  ');
        return encoder.convert(decode);
      }
    }on Exception catch (e) {
      return json;
    }
    return json;
  }
}