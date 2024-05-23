import gleam/list
import gleam/result

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0b00
    Cytosine -> 0b01
    Guanine -> 0b10
    Thymine -> 0b11
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0b00 -> Ok(Adenine)
    0b01 -> Ok(Cytosine)
    0b10 -> Ok(Guanine)
    0b11 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  dna
  |> list.map(encode_nucleotide)
  |> list.fold(<<>>, fn(bit_array, next) { <<bit_array:bits, next:2>> })
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  decode_nucleotides(dna, [])
}

fn decode_nucleotides(
  dna: BitArray,
  nucleotides: List(Nucleotide),
) -> Result(List(Nucleotide), Nil) {
  case dna {
    <<>> -> Ok(list.reverse(nucleotides))
    <<next:2, rest:bits>> -> {
      next
      |> decode_nucleotide
      |> result.try(fn(nucleotide) {
        decode_nucleotides(rest, [nucleotide, ..nucleotides])
      })
    }
    _ -> Error(Nil)
  }
}
