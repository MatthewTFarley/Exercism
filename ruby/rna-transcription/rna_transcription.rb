# frozen_string_literal: true

class Complement
  class << self
    def of_dna(dna)
      dna.chars.map(&to_rna).join
    end

    def to_rna
      ->(nucleotide) { DNA_TO_RNA[nucleotide] }
    end

    DNA_TO_RNA = {
      'G' => 'C',
      'C' => 'G',
      'T' => 'A',
      'A' => 'U',
    }.freeze
  end
end
