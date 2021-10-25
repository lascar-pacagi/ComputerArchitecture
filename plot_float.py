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

for i in range(0x80, 0x8f):
    plt.plot((to_8bit_float(i), to_8bit_float(i)), (0, 3), c='brown', linewidth=0.75, aa=False)

for i in range(0, 0x0f):
    plt.plot((to_8bit_float(i), to_8bit_float(i)), (0, 3), c='blue', linewidth=0.75, aa=False)


# for i in range(0, m):
#     plt.plot((-to_8bit_float(i), -to_8bit_float(i)), (0, 3), c='brown', linewidth=0.75, aa=False)
plt.axis([-0.03, 0.03, 0, 5])
plt.xticks(np.arange(-0.02734375, 0.027348, 2**-8))
locs, _ = plt.xticks()
labels = ['%.8f' % v for v in locs]
plt.xticks(locs, labels)

# plt.axis([-520, 520, 0, 5])
# plt.xticks(np.arange(-520, 520, 40))

plt.show()
