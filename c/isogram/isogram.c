#include "isogram.h"
#include "ctype.h"
#include "stdio.h"
#include "string.h"

bool is_isogram(const char phrase[]) {
  if (phrase == NULL) {
    return false;
  }

  int letters[128] = {0};
  int i, l;

  // initialize hash of unique letter count
  for (i = 0; (unsigned long)i < strlen(phrase); i++) {
    if (phrase[i] == *"-" || phrase[i] == *" ") {
      continue;
    }

    l = tolower((int)phrase[i]);

    letters[l]++;

    if (letters[l] > 1) {
      return false;
    }
  }

  return true;
}
