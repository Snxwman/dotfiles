-- The MIT License (MIT)
--
-- Copyright (c) 2022 Leon Heidelbach
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

-- All credits to https://github.com/LeonHeidelbach for making this!
-- 90% of functions are written by him

-- Copied from https://github.com/NvChad/base46/blob/v3.0/lua/base46/colors.lua

local color = {}

-- Convert a hex color value to RGB
-- @param hex: The hex color value
-- @return r: Red (0-255)
-- @return g: Green (0-255)
-- @return b: Blue (0-255)
color.hex2rgb = function(hex)
  local hash = string.sub(hex, 1, 1) == "#"
  if string.len(hex) ~= (7 - (hash and 0 or 1)) then
    return nil
  end

  local r = tonumber(hex:sub(2 - (hash and 0 or 1), 3 - (hash and 0 or 1)), 16)
  local g = tonumber(hex:sub(4 - (hash and 0 or 1), 5 - (hash and 0 or 1)), 16)
  local b = tonumber(hex:sub(6 - (hash and 0 or 1), 7 - (hash and 0 or 1)), 16)
  return r, g, b
end

-- Convert a hex color value to RGB ratio
-- @param hex: The hex color value
-- @return r: Red (0-100)
-- @return g: Green (0-100)
-- @return b: Blue (0-100)
color.hex2rgb_ratio = function(hex)
  local r, g, b = color.hex2rgb(hex)
  return math.floor(r / 255 * 100), math.floor(g / 255 * 100), math.floor(b / 255 * 100)
end

-- Convert an RGB color value to hex
-- @param r: Red (0-255)
-- @param g: Green (0-255)
-- @param b: Blue (0-255)
-- @return The hexadecimal string representation of the color
color.rgb2hex = function(r, g, b)
  return string.format("#%02x%02x%02x", math.floor(r), math.floor(g), math.floor(b))
end

-- Helper function to convert a HSL color value to RGB
-- Not to be used directly, use M.hsl2rgb instead
color.hsl2rgb_helper = function(p, q, a)
  if a < 0 then
    a = a + 6
  end
  if a >= 6 then
    a = a - 6
  end
  if a < 1 then
    return (q - p) * a + p
  elseif a < 3 then
    return q
  elseif a < 4 then
    return (q - p) * (4 - a) + p
  else
    return p
  end
end

-- Convert a HSL color value to RGB
-- @param h: Hue (0-360)
-- @param s: Saturation (0-1)
-- @param l: Lightness (0-1)
-- @return r: Red (0-255)
-- @return g: Green (0-255)
-- @return b: Blue (0-255)
color.hsl2rgb = function(h, s, l)
  local t1, t2, r, g, b

  h = h / 60
  if l <= 0.5 then
    t2 = l * (s + 1)
  else
    t2 = l + s - (l * s)
  end

  t1 = l * 2 - t2
  r = color.hsl2rgb_helper(t1, t2, h + 2) * 255
  g = color.hsl2rgb_helper(t1, t2, h) * 255
  b = color.hsl2rgb_helper(t1, t2, h - 2) * 255

  return r, g, b
end

-- Convert an RGB color value to HSL
-- @param r Red (0-255)
-- @param g Green (0-255)
-- @param b Blue (0-255)
-- @return h Hue (0-360)
-- @return s Saturation (0-1)
-- @return l Lightness (0-1)
color.rgb2hsl = function(r, g, b)
  local min, max, l, s, maxcolor, h
  r, g, b = r / 255, g / 255, b / 255

  min = math.min(r, g, b)
  max = math.max(r, g, b)
  maxcolor = 1 + (max == b and 2 or (max == g and 1 or 0))

  if maxcolor == 1 then
    h = (g - b) / (max - min)
  elseif maxcolor == 2 then
    h = 2 + (b - r) / (max - min)
  elseif maxcolor == 3 then
    h = 4 + (r - g) / (max - min)
  end

  if not rawequal(type(h), "number") then
    h = 0
  end

  h = h * 60

  if h < 0 then
    h = h + 360
  end

  l = (min + max) / 2

  if min == max then
    s = 0
  else
    if l < 0.5 then
      s = (max - min) / (max + min)
    else
      s = (max - min) / (2 - max - min)
    end
  end

  return h, s, l
end

-- Convert a hex color value to HSL
-- @param hex: The hex color value
-- @param h: Hue (0-360)
-- @param s: Saturation (0-1)
-- @param l: Lightness (0-1)
color.hex2hsl = function(hex)
  local r, g, b = color.hex2rgb(hex)
  return color.rgb2hsl(r, g, b)
end

-- Convert a HSL color value to hex
-- @param h: Hue (0-360)
-- @param s: Saturation (0-1)
-- @param l: Lightness (0-1)
-- @returns hex color value
color.hsl2hex = function(h, s, l)
  local r, g, b = color.hsl2rgb(h, s, l)
  return color.rgb2hex(r, g, b)
end

-- Change the hue of a color by a given amount
-- @param hex The hex color value
-- @param amount The amount to change the hue.
--               Negative values decrease the hue, positive values increase it.
-- @return The hex color value
color.change_hex_hue = function(hex, percent)
  local h, s, l = color.hex2hsl(hex)
  -- Convert percentage to a degree shift
  local shift = (percent / 100) * 360
  h = (h + shift) % 360
  if h < 0 then
    h = h + 360
  end
  return color.hsl2hex(h, s, l)
end

-- Desaturate or saturate a color by a given percentage
-- @param hex The hex color value
-- @param percent The percentage to desaturate or saturate the color.
--                Negative values desaturate the color, positive values saturate it
-- @return The hex color value
color.change_hex_saturation = function(hex, percent)
  local h, s, l = color.hex2hsl(hex)
  s = s + (percent / 100)
  if s > 1 then
    s = 1
  end
  if s < 0 then
    s = 0
  end
  return color.hsl2hex(h, s, l)
end

-- Lighten or darken a color by a given percentage
-- @param hex The hex color value
-- @param percent The percentage to lighten or darken the color.
--                Negative values darken the color, positive values lighten it
-- @return The hex color value
color.change_hex_lightness = function(hex, percent)
  local h, s, l = color.hex2hsl(hex)
  l = l + (percent / 100)
  if l > 1 then
    l = 1
  end
  if l < 0 then
    l = 0
  end
  return color.hsl2hex(h, s, l)
end

-- Compute a gradient between two colors
-- @param hex1 The first hex color value
-- @param hex2 The second hex color value
-- @param steps The number of steps to compute
-- @return A table of hex color values
color.compute_gradient = function(hex1, hex2, steps)
  local h1, s1, l1 = color.hex2hsl(hex1)
  local h2, s2, l2 = color.hex2hsl(hex2)
  local h, s, l
  local h_step = (h2 - h1) / (steps - 1)
  local s_step = (s2 - s1) / (steps - 1)
  local l_step = (l2 - l1) / (steps - 1)
  local gradient = {}

  for i = 0, steps - 1 do
    h = h1 + (h_step * i)
    s = s1 + (s_step * i)
    l = l1 + (l_step * i)
    gradient[i + 1] = color.hsl2hex(h, s, l)
  end

  return gradient
end

-- Generate complementary colors
-- @param hex The hex color value (string)
-- @param count The number of complementary colors to generate
-- @return A table containing the complementary colors in hex format
color.hex2complementary = function(hex, count)
  local h, s, l = color.hex2hsl(hex)
  local complementary_colors = {}

  -- Calculate the hue for the complementary color (180 degrees shift)
  local complementary_hue = (h + 180) % 360

  -- Create a gradient of colors by slightly varying the complementary hue
  local hue_step = 360 / count
  for i = 0, count - 1 do
    local new_hue = (complementary_hue + (hue_step * i)) % 360
    local complementary_hex = color.hsl2hex(new_hue, s, l)
    table.insert(complementary_colors, complementary_hex)
  end

  return complementary_colors
end

-- Mix two colors with a given percentage.
-- @param first The primary hex color.
-- @param second The hex color you want to mix into the first color.
-- @param strength The percentage of second color in the output.
--                 This needs to be a number between 0 - 100.
-- @return The mixed color as a hex value
color.mix = function(first, second, strength)
  if strength == nil then
    strength = 0.5
  end

  local s = strength / 100
  local r1, g1, b1 = color.hex2rgb(first)
  local r2, g2, b2 = color.hex2rgb(second)

  if r1 == nil or r2 == nil then
    return first
  end

  if s == 0 then
    return first
  elseif s == 1 then
    return second
  end

  local r3 = r1 * (1 - s) + r2 * s
  local g3 = g1 * (1 - s) + g2 * s
  local b3 = b1 * (1 - s) + b2 * s

  return color.rgb2hex(r3, g3, b3)
end

return color
