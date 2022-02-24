import numpy as np
import matplotlib.pyplot as plt

def sign(i):
    return -1 if i & 0x80 else 1

def exponent(i):
    return ((i & 0x78) >> 3) - 7

def mantissa(i):
    return i & 7

def to_8bit_float(i):
    return sign(i) * (1 + mantissa(i) * 0.125) * 2**exponent(i)
#    return (1 + 0.5 * (1 if i & 4 else 0) + 0.25 * (1 if i & 2 else 0) + 0.125 * (1 if i & 1 else 0)) * 2**(((i & 0x78) >> 3)  - 7)

#m = 128
# plt.plot([to_8bit_float(i) for i in range(0, m)], [0.5 for i in range(0, m)], '|')
# plt.plot([-to_8bit_float(i) for i in range(0, m)], [0.5 for i in range(0, m)], '|')

# for i in range(0x80, 0xFF + 1):
#     plt.plot((to_8bit_float(i), to_8bit_float(i)), (0, 3), c='brown', linewidth=0.75, aa=False)

# for i in range(0, 0x7F + 1):
#     plt.plot((to_8bit_float(i), to_8bit_float(i)), (0, 3), c='blue', linewidth=0.75, aa=False)

# for i in range(0x80, 0xdf):
#     plt.plot((to_8bit_float(i), to_8bit_float(i)), (0, 3), c='brown', linewidth=0.75, aa=False)

# for i in range(0, 0x5f):
#     plt.plot((to_8bit_float(i), to_8bit_float(i)), (0, 3), c='blue', linewidth=0.75, aa=False)


# for i in range(0, m):
#     plt.plot((-to_8bit_float(i), -to_8bit_float(i)), (0, 3), c='brown', linewidth=0.75, aa=False)

n = 20
# pos = [str(hex(i)) in range(0, n)]
# neg = [str(hex(i)) for i in range
# plt.scatter(['a','b','c'],[1,2,3])


for i in range(0, n):
    plt.scatter(i, -to_8bit_float(n - i), c = 'brown', marker = '.')

for i in range(0, n):
    plt.scatter(i + n, to_8bit_float(i), c = 'blue', marker = '.')

# pos_bits   = [str(hex(i)) for i in range(0, n)]
# pos_values = [to_8bit_float(i) for i in range(0, n)]
# plt.scatter(pos_bits, pos_values, c = 'blue', marker = '.')

# for b in neg:
#     plt.scatter(b, to_8bit_float(b), c = 'brown', marker = '.')
# for i in range(0, n):
#     plt.scatter(n + i, to_8bit_float(i), c = 'blue', marker = '.')

# plt.scatter(bits, map (lambda x: -to_8bit_float(x), bits), c = 'brown', marker = '.')
# plt.scatter(bits, map (to_8bit_float, bits), c = 'blue', marker = '.')

# plt.axis([-2.25, 2.25, 0, 5])
# plt.xticks(np.arange(-2.25, 2.25, 0.25))

# plt.axis([-520, 520, 0, 5])
# plt.xticks(np.arange(-520, 520, 40))

frame = plt.gca()
frame.axes.get_xaxis().set_visible(False)

plt.xlabel('bit pattern')
plt.ylabel('float value')


plt.show()
