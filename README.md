# dart-multibase

[![Bulid Status](https://github.com/heacare/dart-multibase/actions/workflows/checks.yml/badge.svg)](https://github.com/heacare/dart-multibase/actions/workflows/checks.yml)
[![License](https://img.shields.io/crates/l/multibase?style=flat-square)](LICENSE)
[![Pub](https://img.shields.io/pub/v/multibase)](https://pub.dev/packages/multibase)

> [multibase](https://github.com/multiformats/multibase) implementation in Dart.

## Table of Contents

- [Install](#install)
- [Usage](#usage)

## Install

```sh
dart pub add multibase
```

## Usage

```dart
Codec<Uint8List, String> codec = MultibaseCodec(encodeBase: Multibase.base64);
Uint8List data = Uint8List.fromList("hello".codeUnits);
String base64 = codec.encode(data);
data = codec.decode(base64);
```

Or use the function API:

```dart
Uint8List data = Uint8List.fromList("hello".codeUnits);
String base64 = multibaseEncode(Multibase.base64, data);
data = multibaseDecode(base64);
```
