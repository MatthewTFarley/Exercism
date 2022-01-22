defmodule HighSchoolSweetheart do
  def first_letter(name) do
    name
    |> String.trim()
    |> String.at(0)
  end

  def initial(name) do
    first_letter(name)
    |> String.upcase()
    |> Kernel.<>(".")
  end

  def initials(full_name) do
    full_name
    |> String.split(" ")
    |> Enum.map(&initial/1)
    |> Enum.join(" ")
  end

  def pair(full_name1, full_name2) do
    initial_line =
      [full_name1, full_name2]
      |> Enum.map(&initials/1)
      |> Enum.join("  +  ")

    """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{initial_line}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """
  end
end
