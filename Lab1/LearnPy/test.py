alphabet = "абвгдеєжзиіїйклмнопрстуфхцчшщьюя_"

rot11 = [
    alphabet,
    range(1, len(alphabet) + 1),
    [5,7,17,23,28,26,20,21,2,19,13,32,12,9,16,11,10,25,24,8,4,27,3,31,15,14,33,18,1,29,22,30,6]
  ]

rot22 = [
    range(1, len(alphabet) + 1),
    [20,19,25,22,27,8,13,29,30,12,32,24,1,31,6,7,17,26,2,28,11,4,23,14,16,5,9,18,10,21,3,33,15],
    alphabet
  ]

rot1 = [
    alphabet,
    range(1, len(alphabet) + 1),
    [8, 15, 29, 23, 22, 7, 1, 28, 5, 32, 27, 9, 20, 14, 21, 19, 6, 13, 26, 17, 10, 4, 25, 12, 18, 3, 30, 33, 16, 11, 24, 31, 2]
  ]

rot2 = [
    range(1, len(alphabet) + 1),
    [22, 14, 26, 19, 8, 33, 7, 10, 5, 17, 21, 6, 15, 3, 1, 29, 4, 24, 25, 31, 11, 18, 32, 28, 20, 27, 12, 23, 9, 16, 30, 2, 13],
    alphabet
  ]

def rotor_encrypt(word, start_shift):
  print("sh  s1  c1  p1  c2  p2  s2")
  print("--------------------------")
  sh = start_shift
  res = ""
  for letter in word:
    s1 = letter
    c1 = rot1[1][rot1[0].index(s1)]
    p1 = rot1[1][rot1[2].index(c1)]
    c2 = (p1 + sh) % len(alphabet)
    if c2 == 0:
      c2 = 33
    p2 = rot2[0][rot2[1].index(c2)]
    s2 = rot2[2][rot2[0].index(p2)]
    print("%2d   %s  %2d  %2d  %2d  %2d   %s" % (sh, s1, c1, p1, c2, p2, s2))
    sh += 1
    res += s2
  return res

def rotor_decrypt(word):
  decryptions = []
  for sh in range(len(alphabet)):
    res = ""
    cs = sh
    for letter in word:
      s2 = letter
      p2 = rot2[0][rot2[2].index(s2)]
      c2 = rot2[1][rot2[0].index(p2)]
      p1 = (c2 - cs) % len(alphabet)
      if p1 == 0:
        p1 = 33
      c1 = rot1[2][rot1[1].index(p1)]
      s1 = rot1[0][rot1[1].index(c1)]
      res += s1
      cs += 1
    decryptions.append("Shift: %2d, decryption: %s\n(run rotor_encrypt('%s', %d) for print checking)\n" % (sh, res, res, sh))
  print("\n".join(decryptions))

# rotor_decrypt("рьіхьхьрттх")
rotor_encrypt('метро', 28)
# rotor_decrypt('о_ясо')