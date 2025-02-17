import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_base_core/flutter_base_core.dart';

void main() {
  group('flutter core', () {
    test('ExString', () {
      expect('123456'.dToMD5(), 'e10adc3949ba59abbe56e057f20f883e');
      expect('123456'.dIsPhone(), false);
      expect('17688454587'.dIsPhone(), true);
      expect('11688454587'.dIsPhone(), false);
      expect('#ff0000'.dToColor(), const Color(0xffff0000));
      expect('17688454587'.dReplaceString(), '176****4587');
      expect('17688'.dReplaceString(), '17688');
      expect('17688'.dReplaceString(end: 5), '176****');
      expect('17688'.dReplaceString(start: 6, end: 5), '17688');
      expect(
          '17688'.dReplaceString(start: 1, end: 2, replacement: '#'), '1#688');
      expect('123456'.dReverse(), '654321');
      expect('12345'.dReverse(), '54321');
      expect('12'.dReverse(), '21');
      expect('1'.dReverse(), '1');
      expect('13777777777'.dIsPhone(), true);
      expect('1377777777'.dIsPhone(), false);
      expect('1377777777'.dIsUrl(), false);
      expect('http://www.hao123.com'.dIsUrl(), true);
      expect('https://www.hao123.com'.dIsUrl(), true);
      expect('https:www.hao123.com'.dIsUrl(), true);
      expect('https://hao123.com'.dIsUrl(), true);

      expect('https://hao123.com'.dIsBlank, false);
      expect('1 1'.dIsBlank, false);
      expect(' '.dIsBlank, true);
      expect('  '.dIsBlank, true);
      expect('     '.dIsBlank, true);
    });

    test('ExDate', () {
      expect(DateTime.now().dIsToday, true);
      expect(DateTime(2200, 1, 1).dIsToday, false);

      expect(DateTime(2000, 1, 1).dIsPast, true);
      expect(DateTime(2023, 8, 17).dIsPast, true);
      expect(DateTime(2200, 1, 1).dIsPast, false);
      expect(DateTime(2000, 1, 1).dFormat(pattern: 'yyyy-MM-dd'), '2000-01-01');
      expect(
          DateTime(2000, 12, 1).dFormat(pattern: 'yyyy/MM/dd'), '2000/12/01');
      expect(DateTime(2000, 1, 1, 11, 11, 11).dFormat(pattern: 'HH:mm:ss'),
          '11:11:11');
      expect(
          DateTime(2000, 1, 1, 01, 02, 13).dFormat(pattern: 'mm:ss'), '02:13');
    });

    test('ExColor', () {
      expect(const Color(0xffffffff).dToHex, '#ffffff');
    });

    test('ExList', () {
      expect([].dSafeLast, null);
      expect([].dSafeLast, null);
      expect([1, 3, 3].dSafeLast, 1);
      expect([1, 2].dSafeLast, 2);
      expect([1, 2].dSafeFirstWhere((e) => e == 2), 2);
      expect([1, 2].dSafeFirstWhere((e) => e == 21), null);
    });
  });
}
