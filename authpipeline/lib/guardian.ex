defmodule IdentityWeb.Guardian do

  use Guardian, otp_app: :authpipeline

  def subject_for_token(_something1, _something2) do
    {:ok, "admin"}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]

    if id == "admin" do
      {:ok, "admin"}
    else
      {:error}
    end
  end
end
