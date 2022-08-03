import 'dart:typed_data';

import 'package:multibase/multibase.dart';
import 'package:test/test.dart';

void main() {
  group('basic', () {
    _testRoundTrip(Multibase.base16, 'f796573206d616e692021');
    _testRoundTrip(Multibase.base16upper, 'F796573206D616E692021');
    _testRoundTrip(Multibase.base32, 'bpfsxgidnmfxgsibb');
    _testRoundTrip(Multibase.base32upper, 'BPFSXGIDNMFXGSIBB');
    _testRoundTrip(Multibase.base58btc, 'z7paNL19xttacUY');
    _testRoundTrip(Multibase.base64, 'meWVzIG1hbmkgIQ');
    _testRoundTrip(Multibase.base64url, 'ueWVzIG1hbmkgIQ');
    _testRoundTrip(Multibase.base64urlpad, 'UeWVzIG1hbmkgIQ==');
  });
  group('leading zero', () {
    _testRoundTrip(Multibase.base16, 'f00796573206d616e692021');
    _testRoundTrip(Multibase.base16upper, 'F00796573206D616E692021');
    _testRoundTrip(Multibase.base32, 'bab4wk4zanvqw42jaee');
    _testRoundTrip(Multibase.base32upper, 'BAB4WK4ZANVQW42JAEE');
    _testRoundTrip(Multibase.base58btc, 'z17paNL19xttacUY');
    _testRoundTrip(Multibase.base64, 'mAHllcyBtYW5pICE');
    _testRoundTrip(Multibase.base64url, 'uAHllcyBtYW5pICE');
    _testRoundTrip(Multibase.base64urlpad, 'UAHllcyBtYW5pICE=');
  });
  group('two leading zeros', () {
    _testRoundTrip(Multibase.base16, 'f0000796573206d616e692021');
    _testRoundTrip(Multibase.base16upper, 'F0000796573206D616E692021');
    _testRoundTrip(Multibase.base32, 'baaahszltebwwc3tjeaqq');
    _testRoundTrip(Multibase.base32upper, 'BAAAHSZLTEBWWC3TJEAQQ');
    _testRoundTrip(Multibase.base58btc, 'z117paNL19xttacUY');
    _testRoundTrip(Multibase.base64, 'mAAB5ZXMgbWFuaSAh');
    _testRoundTrip(Multibase.base64url, 'uAAB5ZXMgbWFuaSAh');
    _testRoundTrip(Multibase.base64urlpad, 'UAAB5ZXMgbWFuaSAh');
  });
  group('case insensetivity', () {
    _testRoundTrip(
      Multibase.base16,
      'f68656c6c6f20776F726C64',
      'f68656c6c6f20776f726c64',
    );
    _testRoundTrip(
      Multibase.base16upper,
      'F68656c6c6f20776F726C64',
      'F68656C6C6F20776F726C64',
    );
    _testRoundTrip(
      Multibase.base32,
      'bnbswy3dpeB3W64TMMQ',
      'bnbswy3dpeb3w64tmmq',
    );
    _testRoundTrip(
      Multibase.base32upper,
      'Bnbswy3dpeB3W64TMMQ',
      'BNBSWY3DPEB3W64TMMQ',
    );
  });
  group('allow empty data', () {
    _testRoundTrip(Multibase.base16, 'f');
    _testRoundTrip(Multibase.base16upper, 'F');
    _testRoundTrip(Multibase.base32, 'b');
    _testRoundTrip(Multibase.base32upper, 'B');
    _testRoundTrip(Multibase.base58btc, 'z');
    _testRoundTrip(Multibase.base64, 'm');
    _testRoundTrip(Multibase.base64url, 'u');
    _testRoundTrip(Multibase.base64urlpad, 'U');
  });
  group('out of character', () {
    test('base16', () {
      expect(
        () => multibaseDecode('f0000796573206d616e692021g'),
        throwsFormatException,
      );
    });
    test('base32', () {
      expect(
        () => multibaseDecode('baaahszltebwwc3tjeaqq8'),
        throwsFormatException,
      );
    });
  });
  group('padding rejected', () {
    test('base64', () {
      expect(() => multibaseDecode('meWVzIG1hbmkgIQ=='), throwsFormatException);
    });
    test('base64url', () {
      expect(() => multibaseDecode('ueWVzIG1hbmkgIQ=='), throwsFormatException);
    });
  });
  group('padding required', () {
    test('base64urlpad invalid padding', () {
      expect(() => multibaseDecode('UaGVsbG93bw='), throwsFormatException);
    });
  });
}

void _testRoundTrip(
  final Multibase base,
  final String input, [
  final String? output,
]) {
  if (output == null) {
    test('${base.name} $input', () {
      final Uint8List a = multibaseDecode(input);
      final String b = multibaseEncode(base, a);
      expect(b, input);
    });
  } else {
    test('${base.name} $input -> $output', () {
      final Uint8List a = multibaseDecode(input);
      final String b = multibaseEncode(base, a);
      expect(b, output);
    });
  }
}
