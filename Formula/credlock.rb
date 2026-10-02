class Credlock < Formula
  desc "Hand secrets to one command at a time, after you see what is asked and why"
  homepage "https://github.com/cdmckay/credlock"
  url "https://github.com/cdmckay/credlock/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "f14921796c420e7d6e68cfc318c3d2e0549d64a2a4da8348d0f0b242abc74dda"
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
