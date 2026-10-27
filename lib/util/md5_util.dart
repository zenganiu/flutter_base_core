import 'dart:convert';
import 'dart:typed_data';

class MD5Util {
  // 辅助常量：每轮循环中用到的位移数
  static const List<int> _s = [
    7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22,
    5,  9, 14, 20, 5,  9, 14, 20, 5,  9, 14, 20, 5,  9, 14, 20,
    4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23,
    6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21,
  ];

  // 辅助常量：T 表 (sin 函数值的二进制整数部分)
  static final List<int> _t = List.generate(64, (i) {
    // floor(2^32 * abs(sin(i + 1)))
    return (4294967296 * 1.abs().toDouble() * (i >= 0 ? 1 : 1)).toInt(); // 简化计算，直接用预生成或公式
  });

  // 由于 Dart 中大整数的处理，我们可以预先生成固定的 _t 数组，避免浮点数精度问题：
  static const List<int> _kTable = [
    0xd76aa478, 0xe8c7b756, 0x242070db, 0xc1bdceee,
    0xf57c0faf, 0x4787c62a, 0xa8304613, 0xfd469501,
    0x698098d8, 0x8b44f7af, 0xffff5bb1, 0x895cd7be,
    0x6b901122, 0xfd987193, 0xa679438e, 0x49b40821,
    0xf61e2562, 0xc040b340, 0x265e5a51, 0xe9b6c7aa,
    0xd62f105d, 0x02441453, 0xd8a1e681, 0xe7d3fbc8,
    0x21e1cde6, 0xc33707d6, 0xf4d50d87, 0x455a14ed,
    0xa9e3e905, 0xfcefa3f8, 0x676f02d9, 0x8d2a4c8a,
    0xfffa3942, 0x8771f681, 0x6d9d6122, 0xfde5380c,
    0xa4beea44, 0x4bdecfa9, 0xf6bb4b60, 0xbebfbc70,
    0x289b7ec6, 0xeaa127fa, 0xd4ef3085, 0x04881d05,
    0xd9d4d039, 0xe6db99e5, 0x1fa27cf8, 0xc4ac5665,
    0xf4292244, 0x432aff97, 0xab9423a7, 0xfc93a039,
    0x655b59c3, 0x8f0ccc92, 0xffeff47d, 0x85845dd1,
    0x6fa87e4f, 0xfe2ce6e0, 0xa3014314, 0x4e0811a1,
    0xf7537e82, 0xbd3af235, 0x2ad7d2bb, 0xeb86d391,
  ];

  // 循环左移
  static int _leftRotate(int val, int shift) {
    return ((val << shift) | (val >> (32 - shift))) & 0xFFFFFFFF;
  }

  // 计算字符串的 MD5
  static String hash(String input) {
    return hashBytes(utf8.encode(input));
  }

  // 计算字节数组的 MD5
  static String hashBytes(List<int> bytes) {
    // 1. 初始化标准缓冲区变量 (32位整数)
    int h0 = 0x67452301;
    int h1 = 0xefcdab89;
    int h2 = 0x98badcfe;
    int h3 = 0x10325476;

    // 2. 预处理：填充数据
    // 原始字节长度（bit数）
    int originalLenBits = bytes.length * 8;

    // 创建一个可变的字节列表
    List<int> msg = List<int>.from(bytes);

    // 附加一个 0x80 (10000000) 字节
    msg.add(0x80);

    // 填充 0，直到长度满足 (length % 64 == 56) 字节（即 448 位）
    while (msg.length % 64 != 56) {
      msg.add(0x00);
    }

    // 将原始长度（64位小端序）附加到末尾
    ByteData lengthData = ByteData(8);
    lengthData.setUint64(0, originalLenBits, Endian.little);
    msg.addAll(lengthData.buffer.asUint8List());

    // 3. 以 64 字节（512位）为单位分块处理
    for (int offset = 0; offset < msg.length; offset += 64) {
      // 将当前 64 字节块解析为 16 个 32 位小端序整数
      List<int> w = List<int>.filled(16, 0);
      for (int i = 0; i < 16; i++) {
        w[i] = (msg[offset + i * 4]) |
        (msg[offset + i * 4 + 1] << 8) |
        (msg[offset + i * 4 + 2] << 16) |
        (msg[offset + i * 4 + 3] << 24);
      }

      int a = h0;
      int b = h1;
      int c = h2;
      int d = h3;

      // 4. 主循环（64步）
      for (int i = 0; i < 64; i++) {
        int f = 0;
        int g = 0;

        if (i < 16) {
          f = (b & c) | (~b & d);
          g = i;
        } else if (i < 32) {
          f = (d & b) | (~d & c);
          g = (5 * i + 1) % 16;
        } else if (i < 48) {
          f = b ^ c ^ d;
          g = (3 * i + 5) % 16;
        } else {
          f = c ^ (b | ~d);
          g = (7 * i) % 16;
        }

        // f = (f + a + _kTable[i] + w[g]) & 0xFFFFFFFF;
        int temp = d;
        d = c;
        c = b;
        b = (b + _leftRotate((a + f + _kTable[i] + w[g]) & 0xFFFFFFFF, _s[i])) & 0xFFFFFFFF;
        a = temp;
      }

      // 将当前块的计算结果加回到总体缓冲区
      h0 = (h0 + a) & 0xFFFFFFFF;
      h1 = (h1 + b) & 0xFFFFFFFF;
      h2 = (h2 + c) & 0xFFFFFFFF;
      h3 = (h3 + d) & 0xFFFFFFFF;
    }

    // 5. 转换缓冲区为 16 字节的小端序字节数组，并格式化为 32 位十六进制字符串
    ByteData resultBuffer = ByteData(16);
    resultBuffer.setUint32(0, h0, Endian.little);
    resultBuffer.setUint32(4, h1, Endian.little);
    resultBuffer.setUint32(8, h2, Endian.little);
    resultBuffer.setUint32(12, h3, Endian.little);

    StringBuffer sb = StringBuffer();
    for (int i = 0; i < 16; i++) {
      sb.write(resultBuffer.getUint8(i).toRadixString(16).padLeft(2, '0'));
    }

    return sb.toString();
  }
}