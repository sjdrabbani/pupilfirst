// Generated by BUCKLESCRIPT VERSION 3.1.5, PLEASE EDIT WITH CARE
'use strict';

var Json_decode = require("@glennsl/bs-json/src/Json_decode.bs.js");

function decode(json) {
  return /* record */[
          /* name */Json_decode.field("name", Json_decode.string, json),
          /* id */Json_decode.field("id", Json_decode.$$int, json)
        ];
}

function name(t) {
  return t[/* name */0];
}

exports.decode = decode;
exports.name = name;
/* No side effect */