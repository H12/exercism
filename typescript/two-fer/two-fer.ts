/**
 * This stub is provided to make it straightforward to get started.
 */

export function twoFer(input?: string): string {
  // ^                 ^   ^ this is called a return type; it's the type of the
  // ^                 ^     value that is returned from this function
  // ^                 ^
  // ^                 parameters go here
  // ^
  // allows the tests to import this function and call it
  // <-- Your code goes here. You may remove all the commentary in this file.

  let name = 'you';

  if (input) name = input;
  
  return `One for ${name}, one for me.`
}
