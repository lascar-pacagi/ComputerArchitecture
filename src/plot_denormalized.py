import numpy as np
import matplotlib.pyplot as plt

def sign(i):
    return -1 if i & 0x80 else 1

def exponent(i):
    e = (i & 0x78) >> 3
    if e == 0:
        return -6, True
    else:
        return e - 7, False

def mantissa(i):
    return i & 7

def to_8bit_float(i):
    e, denormalized = exponent(i)
    return sign(i) * ((0 if denormalized else 1) + mantissa(i) * 0.125) * 2**e

n = 20

for i in range(0x80, 0x8f):
    plt.plot((to_8bit_float(i), to_8bit_float(i)), (0, 3), c='brown', linewidth=0.75, aa=False)
for i in range(0, 0x0f):
    plt.plot((to_8bit_float(i), to_8bit_float(i)), (0, 3), c='blue', linewidth=0.75, aa=False)

plt.axis([-0.03, 0.03, 0, 5])
plt.xticks(np.arange(-0.02734375, 0.027348, 2**-8))
locs, _ = plt.xticks()
labels = ['%.8f' % v for v in locs]
plt.xticks(locs, labels)

plt.show()
