defmodule FileSniffer do
  @elf_signature <<0x7F, 0x45, 0x4C, 0x46>>
  @bmp_signature <<0x42, 0x4D>>
  @png_signature <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>
  @jpg_signature <<0xFF, 0xD8, 0xFF>>
  @gif_signature <<0x47, 0x49, 0x46>>

  def type_from_extension("exe"), do: "application/octet-stream"
  def type_from_extension("bmp"), do: "image/bmp"
  def type_from_extension("png"), do: "image/png"
  def type_from_extension("jpg"), do: "image/jpg"
  def type_from_extension("gif"), do: "image/gif"

  def type_from_binary(<<@bmp_signature, _::binary()>>), do: "image/bmp"
  def type_from_binary(<<@gif_signature, _::binary()>>), do: "image/gif"
  def type_from_binary(<<@jpg_signature, _::binary()>>), do: "image/jpg"
  def type_from_binary(<<@png_signature, _::binary()>>), do: "image/png"
  def type_from_binary(<<@elf_signature, _::binary()>>), do: "application/octet-stream"

  def verify(file_binary, extension) do
    type = type_from_binary(file_binary)

    if type == type_from_extension(extension) do
      {:ok, type}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end
