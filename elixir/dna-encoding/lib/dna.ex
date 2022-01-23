defmodule DNA do
  def encode_nucleotide(?\s), do: 0b0000
  def encode_nucleotide(?A), do: 0b0001
  def encode_nucleotide(?C), do: 0b0010
  def encode_nucleotide(?G), do: 0b0100
  def encode_nucleotide(?T), do: 0b1000

  def decode_nucleotide(0b0000), do: ?\s
  def decode_nucleotide(0b0001), do: ?A
  def decode_nucleotide(0b0010), do: ?C
  def decode_nucleotide(0b0100), do: ?G
  def decode_nucleotide(0b1000), do: ?T

  def encode(dna), do: _encode(dna, <<0::0>>)

  defp _encode([], acc), do: acc

  defp _encode([head | tail], acc) do
    _encode(tail, <<acc::bitstring, encode_nucleotide(head)::4>>)
  end

  def decode(dna), do: _decode(dna, '')

  defp _decode(<<0::0>>, acc), do: acc

  defp _decode(<<head::4, tail::bitstring>>, acc) do
    _decode(tail, acc ++ [decode_nucleotide(head)])
  end
end
