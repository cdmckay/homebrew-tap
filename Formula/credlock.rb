class Credlock < Formula
  desc "Hand secrets to one command at a time, after you see what is asked and why"
  homepage "https://github.com/cdmckay/credlock"
  url "https://github.com/cdmckay/credlock/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "d8c91044124371e7f95f6751f010e16daf504fd646eb3f1836ad24b727e4c4af"
  license "GPL-3.0-or-later"
  head "https://github.com/cdmckay/credlock.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build
  depends_on :macos

  def install
    # The 1Password SDK's desktop-app sign-in and the approval window need cgo.
    ENV["CGO_ENABLED"] = "1"
    system "go", "build", *std_go_args(ldflags: "-X main.version=#{version}"), "./cmd/credlock"
  end

  def caveats
    <<~EOS
      credlock signs in through the 1Password desktop app. In 1Password, open
      Settings > Developer and, under "Integrate with the 1Password SDKs",
      choose "Integrate with other apps".
    EOS
  end

  test do
    assert_equal "credlock #{version}", shell_output("#{bin}/credlock version").strip
    assert_match "credlock run --account ACCOUNT --reason TEXT", shell_output("#{bin}/credlock help")
  end
end
