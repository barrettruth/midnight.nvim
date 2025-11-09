#!/usr/bin/env python3

import sys

import numpy as np
from PIL import Image

if len(sys.argv) != 4:
    print("Usage: python thumbnail.py <midnight.png> <daylight.png> <output.png>")
    sys.exit(1)

dark = Image.open(sys.argv[1]).convert("RGBA")
light = Image.open(sys.argv[2]).convert("RGBA")

if dark.size != light.size:
    light = light.resize(dark.size, Image.Resampling.LANCZOS)

width, height = dark.size
mask = np.zeros((height, width), dtype=np.uint8)

for y in range(height):
    for x in range(width):
        if y * width < x * height:
            mask[y, x] = 255
        else:
            mask[y, x] = 0

mask_img = Image.fromarray(mask, mode="L")
result = Image.composite(light, dark, mask_img)
result.save(sys.argv[3], "PNG")

print(f"✓ {sys.argv[3]} ({width}x{height})")
