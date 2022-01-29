defmodule Newsletter do
  def read_emails(path) do
    path
    |> File.read!()
    |> String.trim()
    |> case do
      "" -> []
      email_str -> String.split(email_str, "\n")
    end
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    {read_emails(emails_path), open_log(log_path)}
    |> then(fn {emails, log_pid} ->
      Enum.each(emails, fn email ->
        case send_fun.(email) do
          :ok -> log_sent_email(log_pid, email)
          _ -> nil
        end
      end)

      log_pid
    end)
    |> close_log()
  end
end
